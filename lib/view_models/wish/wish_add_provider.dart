import 'dart:io';

import 'package:dio/dio.dart';
import 'package:earned_it/config/exception.dart';
import 'package:earned_it/config/toastMessage.dart';
import 'package:earned_it/models/wish/wish_add_state.dart';
import 'package:earned_it/models/wish/wish_model.dart';
import 'package:earned_it/models/wish/wish_search_state.dart';
import 'package:earned_it/services/auth/login_service.dart';
import 'package:earned_it/services/wish_service.dart';
import 'package:earned_it/view_models/wish/wish_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

final wishAddViewModelProvider =
    NotifierProvider.autoDispose<WishAddViewModel, WishAddState>(
      WishAddViewModel.new,
    );

class WishAddViewModel extends AutoDisposeNotifier<WishAddState> {
  late final TextEditingController nameController;
  late final TextEditingController vendorController;
  late final TextEditingController priceController;
  late final TextEditingController urlController;

  late final LoginService _loginService;
  late final WishService _wishService;

  final ImagePicker _picker = ImagePicker();
  final ImageCropper _cropper = ImageCropper();
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  @override
  WishAddState build() {
    nameController = TextEditingController();
    vendorController = TextEditingController();
    priceController = TextEditingController();
    urlController = TextEditingController();

    _loginService = ref.read(loginServiceProvider);
    _wishService = ref.read(wishServiceProvider);

    nameController.addListener(_updateCanSubmit);
    vendorController.addListener(_updateCanSubmit);
    priceController.addListener(_updateCanSubmit);

    ref.onDispose(() {
      nameController.removeListener(_updateCanSubmit);
      vendorController.removeListener(_updateCanSubmit);
      priceController.removeListener(_updateCanSubmit);
      nameController.dispose();
      vendorController.dispose();
      priceController.dispose();
      urlController.dispose();
    });

    return const WishAddState();
  }

  /// 검색된 ProductModel로 위시 아이템 추가 필드를 채웁니다.
  Future<void> populateFromProduct(ProductModel product) async {
    nameController.text = product.name;
    vendorController.text = product.maker ?? '';
    priceController.text = product.price.toInt().toString();
    urlController.text = product.url;

    final imageFile = await _urlToXFile(product.imageUrl);
    if (imageFile != null) {
      // 다운로드한 이미지를 원본과 최종 이미지 둘 다에 설정
      state = state.copyWith(
        originalImageSource: imageFile,
        itemImage: imageFile,
      );
    }
    _updateCanSubmit();
  }

  // URL을 XFile 객체로 변환하는 헬퍼 메서드
  Future<XFile?> _urlToXFile(String imageUrl) async {
    try {
      final response = await http.get(Uri.parse(imageUrl));
      if (response.statusCode == 200) {
        final tempDir = await getTemporaryDirectory();
        final fileName = imageUrl
            .split('/')
            .lastWhere(
              (e) => e.isNotEmpty,
              orElse: () => '${DateTime.now().millisecondsSinceEpoch}.jpg',
            );
        final file = File('${tempDir.path}/$fileName');
        await file.writeAsBytes(response.bodyBytes);
        return XFile(file.path);
      }
    } catch (e) {
      debugPrint("이미지 다운로드 실패: $e");
    }
    return null;
  }

  void _updateCanSubmit() {
    final priceText = priceController.text;
    final priceValue = int.tryParse(priceText.replaceAll(',', '')) ?? 0;
    String currentPriceError = "";
    if (priceText.isNotEmpty && priceValue == 0) {
      currentPriceError = '금액은 1원 이상 입력해주세요.';
    }

    final canSubmit =
        nameController.text.isNotEmpty &&
        vendorController.text.isNotEmpty &&
        priceController.text.isNotEmpty &&
        state.itemImage != null && // 최종 이미지가 있는지 확인
        currentPriceError.isEmpty;

    state = state.copyWith(canSubmit: canSubmit, priceError: currentPriceError);
  }

  /// 갤러리에서 이미지를 선택하고 편집합니다.
  Future<void> pickImage(BuildContext context) async {
    try {
      final pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );
      if (pickedFile == null || !context.mounted) return;

      final croppedFile = await _cropper.cropImage(
        sourcePath: pickedFile.path,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: '이미지 편집',
            toolbarColor: Theme.of(context).primaryColor,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false,
          ),
          IOSUiSettings(
            title: '이미지 편집',
            aspectRatioLockEnabled: false,
            doneButtonTitle: '완료',
            cancelButtonTitle: '취소',
          ),
        ],
      );
      if (croppedFile == null || !context.mounted) return;

      const maxSizeInBytes = 5 * 1024 * 1024;
      final imageFile = File(croppedFile.path);
      final imageSize = await imageFile.length();
      if (imageSize > maxSizeInBytes) {
        toastMessage(
          context,
          '이미지는 최대 5MB 이하로 등록 가능합니다.',
          type: ToastmessageType.errorType,
        );
        return;
      }

      // 선택한 이미지를 원본으로, 잘린 이미지를 최종본으로 각각 저장
      final finalXFile = XFile(croppedFile.path);
      state = state.copyWith(
        originalImageSource: pickedFile,
        itemImage: finalXFile,
      );
      _updateCanSubmit();
    } catch (e) {
      debugPrint('Image processing error: $e');
      if (context.mounted) {
        toastMessage(
          context,
          '이미지 처리 중 오류가 발생했습니다.',
          type: ToastmessageType.errorType,
        );
      }
    }
  }

  /// 현재 선택된 이미지를 (원본 기준으로) 다시 편집합니다.
  Future<void> editImage(BuildContext context) async {
    // 편집할 원본 이미지가 있는지 확인
    if (state.originalImageSource == null) {
      toastMessage(
        context,
        '편집할 원본 이미지가 없습니다.',
        type: ToastmessageType.errorType,
      );
      return;
    }

    try {
      // 원본 이미지 경로를 사용하여 편집기 실행
      final croppedFile = await _cropper.cropImage(
        sourcePath: state.originalImageSource!.path,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: '이미지 편집',
            toolbarColor: Theme.of(context).primaryColor,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false,
          ),
          IOSUiSettings(
            title: '이미지 편집',
            aspectRatioLockEnabled: false,
            doneButtonTitle: '완료',
            cancelButtonTitle: '취소',
          ),
        ],
      );
      if (croppedFile == null || !context.mounted) return;

      const maxSizeInBytes = 5 * 1024 * 1024;
      final imageFile = File(croppedFile.path);
      final imageSize = await imageFile.length();
      if (imageSize > maxSizeInBytes) {
        toastMessage(
          context,
          '이미지는 최대 5MB 이하로 등록 가능합니다.',
          type: ToastmessageType.errorType,
        );
        return;
      }

      // 편집된 이미지를 itemImage에만 업데이트 (원본은 그대로 유지)
      final finalXFile = XFile(croppedFile.path);
      state = state.copyWith(itemImage: finalXFile);
      _updateCanSubmit();
    } catch (e) {
      debugPrint('Image editing error: $e');
      if (context.mounted) {
        toastMessage(
          context,
          '이미지 편집 중 오류가 발생했습니다.',
          type: ToastmessageType.errorType,
        );
      }
    }
  }

  /// 현재 선택된 이미지를 삭제합니다.
  Future<void> deleteImage() async {
    // 원본과 최종 이미지를 모두 null로 초기화
    state = state.copyWith(itemImage: null, originalImageSource: null);
    _updateCanSubmit();
  }

  void toggleIsTop5(bool? value) {
    state = state.copyWith(isTop5: value ?? false);
  }

  /// 위시아이템 추가
  Future<void> submitWishItem(BuildContext context) async {
    if (!state.canSubmit) return;
    state = state.copyWith(isLoading: true);

    try {
      final String? accessToken = await _storage.read(key: 'accessToken');
      final String currentTime = DateTime.now().toIso8601String();
      final newWishItem = WishModel(
        name: nameController.text,
        vendor: vendorController.text,
        price: int.tryParse(priceController.text.replaceAll(',', '')) ?? 0,
        url: urlController.text,
        starred: state.isTop5,
        createdAt: currentTime,
      );

      // 최종 이미지(itemImage)를 서버로 전송
      await _wishService.addWishItem(
        accessToken: accessToken!,
        wishItem: newWishItem,
        imageXFile: state.itemImage!,
      );

      await ref.read(wishViewModelProvider.notifier).loadStarWish();
      await ref.read(wishViewModelProvider.notifier).loadHighLightWish();

      if (context.mounted) {
        toastMessage(context, '위시 아이템이 추가되었습니다.');
        context.pop();
      }
    } on DioException catch (e) {
      if (context.mounted) _handleApiError(context, e);
    } catch (e) {
      if (context.mounted) _handleGeneralError(context, e);
    } finally {
      if (ref.exists(wishAddViewModelProvider)) {
        state = state.copyWith(isLoading: false);
      }
    }
  }

  Future<void> _handleApiError(BuildContext context, DioException e) async {
    if (e.response?.data['code'] == "AUTH_REQUIRED") {
      toastMessage(
        context,
        '잠시 후 다시 시도해주세요.',
        type: ToastmessageType.errorType,
      );
      try {
        final String? refreshToken = await _storage.read(key: 'refreshToken');
        await _loginService.checkToken(refreshToken!);
      } catch (_) {
        if (context.mounted) context.go('/login');
      }
    } else {
      _handleGeneralError(context, e);
    }
  }

  void _handleGeneralError(BuildContext context, Object e) {
    toastMessage(
      context,
      e.toDisplayString(),
      type: ToastmessageType.errorType,
    );
  }
}
