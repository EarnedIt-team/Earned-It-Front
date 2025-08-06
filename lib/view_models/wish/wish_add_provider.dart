import 'package:dio/dio.dart';
import 'package:earned_it/config/exception.dart';
import 'package:earned_it/models/wish/wish_add_state.dart';
import 'package:earned_it/models/wish/wish_model.dart';
import 'package:earned_it/services/auth/login_service.dart';
import 'package:earned_it/services/wish_service.dart';
import 'package:earned_it/view_models/user_provider.dart';
import 'package:earned_it/view_models/wish/wish_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toastification/toastification.dart';

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
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  @override
  WishAddState build() {
    nameController = TextEditingController();
    vendorController = TextEditingController();
    priceController = TextEditingController();
    urlController = TextEditingController();

    _loginService = ref.read(loginServiceProvider);
    _wishService = ref.read(wishServiceProvider);

    // 👇 1. '회사' 컨트롤러에도 리스너 추가
    nameController.addListener(_updateCanSubmit);
    vendorController.addListener(_updateCanSubmit);
    priceController.addListener(_updateCanSubmit);

    ref.onDispose(() {
      nameController.removeListener(_updateCanSubmit);
      vendorController.removeListener(_updateCanSubmit); // 리스너 제거
      priceController.removeListener(_updateCanSubmit);
      nameController.dispose();
      vendorController.dispose();
      priceController.dispose();
      urlController.dispose();
    });

    return const WishAddState();
  }

  // 👇 2. 버튼 활성화 조건에 '회사' 필드 추가
  void _updateCanSubmit() {
    final canSubmit =
        nameController.text.isNotEmpty &&
        vendorController.text.isNotEmpty && // '회사' 입력 여부 확인
        priceController.text.isNotEmpty &&
        state.itemImage != null;
    state = state.copyWith(canSubmit: canSubmit);
  }

  Future<void> pickImage(BuildContext context) async {
    try {
      final pickedImage = await _picker.pickImage(
        source: ImageSource.gallery,
        // 이미지 품질을 50%로 설정
        imageQuality: 50,
        requestFullMetadata: false,
      );

      if (pickedImage != null) {
        // 이미지 크기 검사
        final imageSize = await pickedImage.length();
        const maxSizeInBytes = 5 * 1024 * 1024; // 5MB

        if (imageSize > maxSizeInBytes) {
          // 크기 초과 시 사용자에게 알림
          if (context.mounted) {
            toastification.show(
              context: context,
              type: ToastificationType.error,
              style: ToastificationStyle.flat,
              title: const Text('이미지 크기는 5MB를 초과할 수 없습니다.'),
              autoCloseDuration: const Duration(seconds: 3),
            );
          }
          return; // 이미지 설정을 중단
        }

        // 유효한 이미지일 경우 상태 업데이트
        state = state.copyWith(itemImage: pickedImage);
        _updateCanSubmit(); // 버튼 활성화 상태 재검사
      }
    } catch (e) {
      debugPrint('Image picking error: $e');
      if (context.mounted) {
        toastification.show(
          context: context,
          type: ToastificationType.error,
          style: ToastificationStyle.flat,
          title: const Text('이미지를 불러오는 중 오류가 발생했습니다.'),
          autoCloseDuration: const Duration(seconds: 3),
        );
      }
    }
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

      // 1. UI 데이터로 WishModel 객체 생성
      final newWishItem = WishModel(
        name: nameController.text,
        vendor: vendorController.text,
        price: int.tryParse(priceController.text.replaceAll(',', '')) ?? 0,
        url: urlController.text,
        starred: state.isTop5,
        // itemImage 필드는 서버에서 URL을 받아 채워지므로 여기서는 비워둡니다.
      );

      // 2. WishService의 수정된 메서드 호출
      await _wishService.addWishItem(
        accessToken: accessToken!,
        wishItem: newWishItem,
        imageXFile: state.itemImage!, // canSubmit 조건으로 인해 null이 아님
      );

      await ref.read(wishViewModelProvider.notifier).loadStarWish();
      await ref.read(wishViewModelProvider.notifier).loadHighLightWish();

      if (context.mounted) {
        toastification.show(
          context: context,
          type: ToastificationType.success,
          title: const Text("위시 아이템이 추가되었습니다."),
          autoCloseDuration: const Duration(seconds: 3),
        );
        context.pop();
      }
    } on DioException catch (e) {
      print(e);
      if (context.mounted) _handleApiError(context, e);
    } catch (e) {
      print(e);
      if (context.mounted) _handleGeneralError(context, e);
    } finally {
      if (context.mounted) {
        state = state.copyWith(isLoading: false);
      }
    }
  }

  Future<void> _handleApiError(BuildContext context, DioException e) async {
    if (e.response?.data['code'] == "AUTH_REQUIRED") {
      toastification.show(
        context: context,
        title: const Text("토큰이 만료되어 재발급합니다. 잠시 후 다시 시도해주세요."),
        autoCloseDuration: const Duration(seconds: 3),
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
    toastification.show(
      context: context,
      title: Text(e.toDisplayString()),
      autoCloseDuration: const Duration(seconds: 3),
    );
  }
}
