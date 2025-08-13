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
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart'; // path_provider 패키지 import

// 2. 로직을 처리하는 Notifier(ViewModel) 클래스
class WishEditViewModel extends AutoDisposeNotifier<WishEditState> {
  late final TextEditingController nameController;
  late final TextEditingController vendorController;
  late final TextEditingController priceController;
  late final TextEditingController urlController;
  late final WishService _wishService;
  final ImagePicker _picker = ImagePicker();
  final _storage = const FlutterSecureStorage();
  late final LoginService _loginService;

  @override
  WishEditState build() {
    _wishService = ref.read(wishServiceProvider);
    nameController = TextEditingController();
    vendorController = TextEditingController();
    priceController = TextEditingController();
    urlController = TextEditingController();
    _loginService = ref.read(loginServiceProvider);

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

    // 👇 4. 기존 이미지 URL을 파일로 다운로드하여 상태에 저장
    if (wishItem.itemImage.isNotEmpty) {
      final imageFile = await _urlToXFile(wishItem.itemImage);
      state = state.copyWith(imageForUpload: imageFile);
    }
    _updateCanSubmit();
  }

  // URL을 XFile 객체로 변환하는 헬퍼 메서드
  Future<XFile?> _urlToXFile(String imageUrl) async {
    try {
      final response = await http.get(Uri.parse(imageUrl));
      if (response.statusCode == 200) {
        final tempDir = await getTemporaryDirectory();
        final fileName = imageUrl.split('/').last;
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
    final initial = state.initialWish;
    if (initial == null) return;

    // 1. 금액 유효성 검사
    final priceText = priceController.text;
    final priceValue = int.tryParse(priceText.replaceAll(',', '')) ?? 0;
    String currentPriceError = "";
    if (priceText.isNotEmpty && priceValue == 0) {
      currentPriceError = '금액은 1원 이상 입력해주세요.';
    }

    // 2. 폼 전체 유효성 검사 (필수 필드 + 이미지 + 금액 에러)
    final isFormValid =
        nameController.text.isNotEmpty &&
        vendorController.text.isNotEmpty &&
        priceController.text.isNotEmpty &&
        state.imageForUpload != null &&
        currentPriceError.isEmpty;

    // 3. 변경 사항 감지 (이미지 변경 포함)
    final hasChanges =
        nameController.text != initial.name ||
        vendorController.text != initial.vendor ||
        priceController.text.replaceAll(',', '') != initial.price.toString() ||
        urlController.text != initial.url ||
        state.isTop5 != initial.starred ||
        (state.imageForUpload?.path !=
            state.initialWish?.itemImage); // 이미지 변경 여부 확인

    // 4. 최종 상태 업데이트
    state = state.copyWith(
      canSubmit: isFormValid && hasChanges,
      priceError: currentPriceError,
    );
  }

  // 이미지 선택 로직
  Future<void> pickImage(BuildContext context) async {
    try {
      final pickedImage = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 50,
      );
      if (pickedImage != null) {
        final imageSize = await pickedImage.length();
        const maxSizeInBytes = 5 * 1024 * 1024; // 5MB

        if (imageSize > maxSizeInBytes) {
          if (context.mounted) {
            toastMessage(
              context,
              '이미지 크기는 최대 5MB 이하입니다.',
              type: ToastmessageType.errorType,
            );
          }
          return;
        }
        state = state.copyWith(imageForUpload: pickedImage);
        _updateCanSubmit();
      }
    } catch (e) {
      debugPrint('Image picking error: $e');
    }
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

      // 👇 5. imageForUpload를 전달 (null이 아님을 보장)
      await _wishService.editWishItem(
        accessToken: accessToken!,
        wishId: updatedWish.wishId,
        updatedWish: updatedWish,
        newImage: state.imageForUpload, // nullable로 전달
      );

      // 로컬 업데이트
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
      if (context.mounted) {
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

// Provider 정의
final wishEditViewModelProvider =
    NotifierProvider.autoDispose<WishEditViewModel, WishEditState>(
      WishEditViewModel.new,
    );
