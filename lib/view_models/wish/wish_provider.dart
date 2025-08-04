import 'package:dio/dio.dart';
import 'package:earned_it/config/exception.dart';
import 'package:earned_it/services/auth/login_service.dart';
import 'package:earned_it/services/wish_service.dart';
import 'package:earned_it/view_models/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:toastification/toastification.dart';

class WishState {
  final bool isLoading;

  const WishState({this.isLoading = false});

  WishState copyWith({bool? isLoading}) {
    return WishState(isLoading: isLoading ?? this.isLoading);
  }
}

final wishViewModelProvider = NotifierProvider<WishViewModel, WishState>(
  WishViewModel.new,
);

class WishViewModel extends Notifier<WishState> {
  late final WishService _wishService;
  late final LoginService _loginService;
  final _storage = const FlutterSecureStorage();

  @override
  WishState build() {
    _wishService = ref.read(wishServiceProvider);
    _loginService = ref.read(loginServiceProvider);
    return const WishState(); // isLoading이 false인 초기 상태
  }

  /// 위시리스트 아이템 삭제 로직
  Future<void> deleteWishItem(BuildContext context, int wishId) async {
    // 👇 2. 로딩 상태 시작
    state = state.copyWith(isLoading: true);
    try {
      final accessToken = await _storage.read(key: 'accessToken');
      if (accessToken == null) {
        throw Exception("로그인이 필요합니다.");
      }

      await _wishService.deleteWishItem(
        accessToken: accessToken,
        wishId: wishId,
      );

      await ref.read(userProvider.notifier).loadUser();
      await ref.read(userProvider.notifier).loadHighLightWish();

      if (context.mounted) {
        toastification.show(
          context: context,
          type: ToastificationType.success,
          title: const Text('위시 아이템이 삭제되었습니다.'),
          autoCloseDuration: const Duration(seconds: 3),
        );
      }
    } on DioException catch (e) {
      if (context.mounted) _handleApiError(context, e);
    } catch (e) {
      if (context.mounted) _handleGeneralError(context, e);
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  // --- 에러 처리 헬퍼 메서드 ---
  Future<void> _handleApiError(BuildContext context, DioException e) async {
    if (e.response?.data['code'] == "AUTH_REQUIRED") {
      toastification.show(
        context: context,
        title: const Text("토큰이 만료되어 재발급합니다. 잠시 후 다시 시도해주세요."),
        autoCloseDuration: const Duration(seconds: 3),
      );
      try {
        final refreshToken = await _storage.read(key: 'refreshToken');
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
