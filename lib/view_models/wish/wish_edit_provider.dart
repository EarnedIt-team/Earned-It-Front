import 'dart:io';
import 'package:dio/dio.dart';
import 'package:earned_it/config/exception.dart';
import 'package:earned_it/models/wish/wish_edit_state.dart';
import 'package:earned_it/models/wish/wish_model.dart';
import 'package:earned_it/services/wish_service.dart';
import 'package:earned_it/view_models/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toastification/toastification.dart';

// 2. 로직을 처리하는 Notifier(ViewModel) 클래스
class WishEditViewModel extends AutoDisposeNotifier<WishEditState> {
  late final TextEditingController nameController;
  late final TextEditingController vendorController;
  late final TextEditingController priceController;
  late final TextEditingController urlController;
  late final WishService _wishService;
  final ImagePicker _picker = ImagePicker();
  final _storage = const FlutterSecureStorage();

  @override
  WishEditState build() {
    _wishService = ref.read(wishServiceProvider);
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
  void initialize(WishModel wishItem) {
    state = state.copyWith(initialWish: wishItem, isTop5: wishItem.starred);
    nameController.text = wishItem.name;
    vendorController.text = wishItem.vendor;
    priceController.text = wishItem.price.toString();
    urlController.text = wishItem.url;
    _updateCanSubmit(); // 초기 상태 검사
  }

  // 버튼 활성화 여부를 업데이트하는 핵심 로직
  void _updateCanSubmit() {
    final initial = state.initialWish;
    if (initial == null) return;

    final isFormValid =
        nameController.text.isNotEmpty &&
        vendorController.text.isNotEmpty &&
        priceController.text.isNotEmpty;

    final hasChanges =
        nameController.text != initial.name ||
        vendorController.text != initial.vendor ||
        priceController.text.replaceAll(',', '') != initial.price.toString() ||
        urlController.text != initial.url ||
        state.isTop5 != initial.starred ||
        state.newImage != null;

    state = state.copyWith(canSubmit: isFormValid && hasChanges);
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
            toastification.show(
              context: context,
              type: ToastificationType.error,
              title: const Text('이미지 크기는 5MB를 초과할 수 없습니다.'),
            );
          }
          return;
        }
        state = state.copyWith(newImage: pickedImage);
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

      // 수정된 내용으로 새로운 WishModel 생성
      final updatedWish = state.initialWish!.copyWith(
        name: nameController.text,
        vendor: vendorController.text,
        price: int.tryParse(priceController.text.replaceAll(',', '')) ?? 0,
        url: urlController.text,
        starred: state.isTop5,
      );

      // 👇 핵심 수정: imageXFile에 nullable한 state.newImage를 그대로 전달
      await _wishService.editWishItem(
        accessToken: accessToken!,
        wishId: updatedWish.wishId,
        updatedWish: updatedWish,
        newImage: state.newImage, // 👈 '!' 제거
      );

      // 수정 성공 시, 전체 유저 정보를 다시 불러와 리스트 갱신
      await ref.read(userProvider.notifier).loadUser();

      if (context.mounted) {
        toastification.show(
          context: context,
          type: ToastificationType.success,
          title: const Text("위시 아이템이 수정되었습니다."),
        );
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

  // 에러 처리 헬퍼 메서드들 (생략)
  void _handleApiError(BuildContext context, DioException e) {
    /* ... */
  }
  void _handleGeneralError(BuildContext context, Object e) {
    /* ... */
  }
}

// Provider 정의
final wishEditViewModelProvider =
    NotifierProvider.autoDispose<WishEditViewModel, WishEditState>(
      WishEditViewModel.new,
    );
