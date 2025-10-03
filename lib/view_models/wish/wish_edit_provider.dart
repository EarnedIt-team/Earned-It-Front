import 'dart:io';

import 'package:dio/dio.dart';
import 'package:earned_it/config/exception.dart';
import 'package:earned_it/config/toastMessage.dart';
import 'package:earned_it/models/wish/wish_edit_state.dart';
import 'package:earned_it/models/wish/wish_model.dart';
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

// Provider 정의
final wishEditViewModelProvider =
    NotifierProvider.autoDispose<WishEditViewModel, WishEditState>(
      WishEditViewModel.new,
    );

// 로직을 처리하는 Notifier(ViewModel) 클래스
class WishEditViewModel extends AutoDisposeNotifier<WishEditState> {
  late final TextEditingController nameController;
  late final TextEditingController vendorController;
  late final TextEditingController priceController;
  late final TextEditingController urlController;
  late final WishService _wishService;
  final ImagePicker _picker = ImagePicker();
  final _storage = const FlutterSecureStorage();
  late final LoginService _loginService;
  final ImageCropper _cropper = ImageCropper();

  @override
  WishEditState build() {
    _wishService = ref.read(wishServiceProvider);
    _loginService = ref.read(loginServiceProvider);
    nameController = TextEditingController();
    vendorController = TextEditingController();
    priceController = TextEditingController();
    urlController = TextEditingController();

    nameController.addListener(_updateCanSubmit);
    vendorController.addListener(_updateCanSubmit);
    priceController.addListener(_updateCanSubmit);
    urlController.addListener(_updateCanSubmit);

    ref.onDispose(() {
      nameController.removeListener(_updateCanSubmit);
      vendorController.removeListener(_updateCanSubmit);
      priceController.removeListener(_updateCanSubmit);
      urlController.removeListener(_updateCanSubmit);
      nameController.dispose();
      vendorController.dispose();
      priceController.dispose();
      urlController.dispose();
    });

    return const WishEditState();
  }

  // View로부터 초기 데이터를 받아 상태와 컨트롤러를 설정
  Future<void> initialize(WishModel wishItem) async {
    state = state.copyWith(initialWish: wishItem, isTop5: wishItem.starred);
    nameController.text = wishItem.name;
    vendorController.text = wishItem.vendor;
    priceController.text = wishItem.price.toString();
    urlController.text = wishItem.url;

    if (wishItem.itemImage.isNotEmpty) {
      final imageFile = await _urlToXFile(wishItem.itemImage);
      // 다운로드한 파일을 원본과 편집본 둘 다에 설정
      state = state.copyWith(
        originalImageSource: imageFile,
        itemImage: imageFile,
        imageHasChanged: false, // 아직 변경되지 않음
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

  // 버튼 활성화 여부를 결정하는 함수
  void _updateCanSubmit() {
    final initial = state.initialWish;
    if (initial == null) return;

    final priceText = priceController.text;
    final priceValue = int.tryParse(priceText.replaceAll(',', '')) ?? 0;
    String currentPriceError = "";
    if (priceText.isNotEmpty && priceValue == 0) {
      currentPriceError = '금액은 1원 이상 입력해주세요.';
    }

    final isFormValid =
        nameController.text.isNotEmpty &&
        vendorController.text.isNotEmpty &&
        priceController.text.isNotEmpty &&
        state.itemImage != null &&
        currentPriceError.isEmpty;

    // 이미지가 변경되었는지 여부 확인
    final imageHasChanged =
        state.originalImageSource?.path != state.itemImage?.path;

    final hasChanges =
        nameController.text != initial.name ||
        vendorController.text != initial.vendor ||
        priceController.text.replaceAll(',', '') != initial.price.toString() ||
        urlController.text != initial.url ||
        state.isTop5 != initial.starred ||
        imageHasChanged;

    state = state.copyWith(
      canSubmit: isFormValid && hasChanges,
      priceError: currentPriceError,
    );
  }

  /// 갤러리에서 이미지를 선택하고 편집하는 함수
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

      // 선택한 파일을 원본으로, 잘린 파일을 편집본으로 각각 저장하고 변경 플래그 설정
      final finalXFile = XFile(croppedFile.path);
      state = state.copyWith(
        originalImageSource: pickedFile,
        itemImage: finalXFile,
        imageHasChanged: true,
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

  /// 현재 이미지를 (원본 기준으로) 다시 편집하는 함수
  Future<void> editImage(BuildContext context) async {
    if (state.originalImageSource == null) {
      toastMessage(
        context,
        '편집할 원본 이미지가 없습니다.',
        type: ToastmessageType.errorType,
      );
      return;
    }

    try {
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

      // 편집된 이미지를 imageForUpload에만 업데이트하고 변경 플래그 설정
      final finalXFile = XFile(croppedFile.path);
      state = state.copyWith(itemImage: finalXFile, imageHasChanged: true);
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

  /// 현재 선택된 이미지를 초기화 하는 함수
  Future<void> resetImage() async {
    state = state.copyWith(
      itemImage: state.originalImageSource,
      imageHasChanged: false, // 이미지 삭제도 변경사항으로 간주
    );
    _updateCanSubmit();
  }

  // TOP5 체크박스 토글 로직
  void toggleIsTop5(bool? value) {
    state = state.copyWith(isTop5: value ?? false);
    _updateCanSubmit();
  }

  // "수정 완료" 버튼을 눌렀을 때 실행될 메서드
  Future<void> submitUpdate(BuildContext context) async {
    if (!state.canSubmit || state.initialWish == null) return;
    state = state.copyWith(isLoading: true);

    try {
      final accessToken = await _storage.read(key: 'accessToken');

      final updatedWish = state.initialWish!.copyWith(
        name: nameController.text,
        vendor: vendorController.text,
        price: int.tryParse(priceController.text.replaceAll(',', '')) ?? 0,
        url: urlController.text,
        starred: state.isTop5,
      );

      // 이미지가 변경되었을 때만 newImage 파라미터에 값을 전달
      final imageHasChanged =
          state.originalImageSource?.path != state.itemImage?.path;

      await _wishService.editWishItem(
        accessToken: accessToken!,
        wishId: updatedWish.wishId,
        updatedWish: updatedWish,
        newImage: imageHasChanged ? state.itemImage : null,
      );

      ref
          .read(wishViewModelProvider.notifier)
          .updateWishItemLocally(updatedWish);
      await ref.read(wishViewModelProvider.notifier).loadStarWish();
      await ref.read(wishViewModelProvider.notifier).loadHighLightWish();

      if (context.mounted) {
        toastMessage(context, '위시 아이템이 수정되었습니다.');
        context.pop();
      }
    } on DioException catch (e) {
      if (context.mounted) _handleApiError(context, e);
    } catch (e) {
      if (context.mounted) _handleGeneralError(context, e);
    } finally {
      if (ref.exists(wishEditViewModelProvider)) {
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
