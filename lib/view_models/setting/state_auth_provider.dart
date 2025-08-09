import 'package:dio/dio.dart';
import 'package:earned_it/config/exception.dart';
import 'package:earned_it/services/auth/login_service.dart';
import 'package:earned_it/services/auth/logout_service.dart';
import 'package:earned_it/services/auth/resign_service.dart';
import 'package:earned_it/view_models/theme_provider.dart';
import 'package:earned_it/view_models/user_provider.dart';
import 'package:earned_it/view_models/wish/wish_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:toastification/toastification.dart';

// 로딩 상태 Provider
final stateAuthLoadingProvider = StateProvider<bool>((ref) => false);

// 로직 Provider
final stateAuthViewModelProvider = Provider.autoDispose((ref) {
  return StateAuthViewModel(ref);
});

class StateAuthViewModel {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  final Ref _ref;

  StateAuthViewModel(this._ref);

  /// 로그아웃을 시도합니다.
  Future<void> signout(BuildContext context) async {
    _ref.read(stateAuthLoadingProvider.notifier).state = true;
    try {
      // 1. AccessToken 가져오기
      final accessToken = await _storage.read(key: 'accessToken');
      if (accessToken == null) {
        throw Exception("로그인이 필요합니다.");
      }

      await _ref.read(logoutServiceProvider).signout(accessToken);
      await const FlutterSecureStorage().deleteAll();

      if (context.mounted) {
        toastification.show(
          context: context,
          type: ToastificationType.success,
          title: const Text('로그아웃이 정상적으로 처리되었습니다.'),
        );
        context.go('/login');
        // provider 강제 파괴
        _ref.invalidate(userProvider);
        _ref.invalidate(wishViewModelProvider);
        _ref.invalidate(themeProvider);
      }
    } on DioException catch (e) {
      _ref.read(stateAuthLoadingProvider.notifier).state = false;

      if (e.response?.data['code'] == "AUTH_REQUIRED") {
        print("토큰이 만료되어 재발급합니다.");
        final String? refreshToken = await _storage.read(key: 'refreshToken');
        try {
          await _ref.read(loginServiceProvider).checkToken(refreshToken!);
          toastification.show(
            alignment: Alignment.topCenter,
            style: ToastificationStyle.simple,
            context: context,
            title: const Text("잠시 후, 다시 시도해주세요."),
            autoCloseDuration: const Duration(seconds: 3),
          );
        } catch (e) {
          context.go('/login');
          toastification.show(
            alignment: Alignment.topCenter,
            style: ToastificationStyle.simple,
            context: context,
            title: const Text("다시 로그인해주세요."),
            autoCloseDuration: const Duration(seconds: 3),
          );
        }
      }
    } catch (e) {
      print('로그아웃 중 에러 발생: $e');
      _ref.read(stateAuthLoadingProvider.notifier).state = false;
      toastification.show(
        alignment: Alignment.topCenter,
        style: ToastificationStyle.simple,
        context: context,
        title: Text(e.toDisplayString()),
        autoCloseDuration: const Duration(seconds: 3),
      );
    } finally {
      if (_ref.exists(stateAuthLoadingProvider)) {
        _ref.read(stateAuthLoadingProvider.notifier).state = false;
      }
    }
  }

  /// 회원탈퇴를 시도합니다.
  Future<void> resign(BuildContext context) async {
    _ref.read(stateAuthLoadingProvider.notifier).state = true;
    try {
      // 1. AccessToken 가져오기
      final accessToken = await _storage.read(key: 'accessToken');
      if (accessToken == null) {
        throw Exception("로그인이 필요합니다.");
      }

      await _ref.read(reSignServiceProvider).reSign(accessToken);
      await const FlutterSecureStorage().deleteAll();

      if (context.mounted) {
        toastification.show(
          context: context,
          type: ToastificationType.success,
          title: const Text('회원탈퇴가 정상적으로 처리되었습니다.'),
        );
        context.go('/login');
        // provider 강제 파괴
        _ref.invalidate(userProvider);
        _ref.invalidate(wishViewModelProvider);
        _ref.invalidate(themeProvider);
      }
    } on DioException catch (e) {
      _ref.read(stateAuthLoadingProvider.notifier).state = false;

      if (e.response?.data['code'] == "AUTH_REQUIRED") {
        print("토큰이 만료되어 재발급합니다.");
        final String? refreshToken = await _storage.read(key: 'refreshToken');
        try {
          await _ref.read(loginServiceProvider).checkToken(refreshToken!);
          toastification.show(
            alignment: Alignment.topCenter,
            style: ToastificationStyle.simple,
            context: context,
            title: const Text("잠시 후, 다시 시도해주세요."),
            autoCloseDuration: const Duration(seconds: 3),
          );
        } catch (e) {
          context.go('/login');
          toastification.show(
            alignment: Alignment.topCenter,
            style: ToastificationStyle.simple,
            context: context,
            title: const Text("다시 로그인해주세요."),
            autoCloseDuration: const Duration(seconds: 3),
          );
        }
      }
    } catch (e) {
      print('회원탈퇴 중 에러 발생: $e');
      _ref.read(stateAuthLoadingProvider.notifier).state = false;
      toastification.show(
        alignment: Alignment.topCenter,
        style: ToastificationStyle.simple,
        context: context,
        title: Text(e.toDisplayString()),
        autoCloseDuration: const Duration(seconds: 3),
      );
    } finally {
      if (_ref.exists(stateAuthLoadingProvider)) {
        _ref.read(stateAuthLoadingProvider.notifier).state = false;
      }
    }
  }
}
