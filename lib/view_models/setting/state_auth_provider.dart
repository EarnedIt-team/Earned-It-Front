import 'package:dio/dio.dart';
import 'package:earned_it/config/exception.dart';
import 'package:earned_it/config/toastMessage.dart';
import 'package:earned_it/services/auth/login_service.dart';
import 'package:earned_it/services/auth/logout_service.dart';
import 'package:earned_it/services/auth/resign_service.dart';
import 'package:earned_it/view_models/home_provider.dart';
import 'package:earned_it/view_models/piece_provider.dart';
import 'package:earned_it/view_models/user_provider.dart';
import 'package:earned_it/view_models/wish/wish_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    await _executeAuthAction(
      context: context,
      authApiCall:
          (accessToken) =>
              _ref.read(logoutServiceProvider).signout(accessToken),
      successMessage: '로그아웃이 정상적으로 처리되었습니다.',
      errorMessage: '로그아웃 중 에러 발생',
    );
  }

  /// 회원탈퇴를 시도합니다.
  Future<void> resign(BuildContext context) async {
    await _executeAuthAction(
      context: context,
      authApiCall:
          (accessToken) => _ref.read(reSignServiceProvider).reSign(accessToken),
      successMessage: '회원탈퇴가 정상적으로 처리되었습니다.',
      errorMessage: '회원탈퇴 중 에러 발생',
    );
  }

  // --- 비공개 헬퍼 메서드들 ---

  /// 로그아웃/회원탈퇴의 공통 로직을 처리하는 헬퍼 메서드
  Future<void> _executeAuthAction({
    required BuildContext context,
    required Future<void> Function(String accessToken) authApiCall,
    required String successMessage,
    required String errorMessage,
  }) async {
    _ref.read(stateAuthLoadingProvider.notifier).state = true;
    try {
      final accessToken = await _storage.read(key: 'accessToken');
      if (accessToken == null) throw Exception("로그인이 필요합니다.");

      // 1. 전달받은 API 호출 실행
      await authApiCall(accessToken);

      // 2. 모든 로컬 데이터 및 상태 초기화
      await _clearAllUserData();

      if (context.mounted) {
        toastMessage(context, successMessage);
        // 3. 모든 정리가 끝난 후 페이지 이동
        context.go('/login');
      }
    } on DioException catch (e) {
      if (context.mounted) _handleApiError(context, e);
    } catch (e) {
      print('$errorMessage: $e');
      if (context.mounted) {
        toastMessage(
          context,
          e.toDisplayString(),
          type: ToastmessageType.errorType,
        );
      }
    } finally {
      if (context.mounted) {
        _ref.read(stateAuthLoadingProvider.notifier).state = false;
      }
    }
  }

  /// 모든 로컬 데이터와 Riverpod 상태를 초기화합니다.
  Future<void> _clearAllUserData() async {
    // 1. 로컬 저장소 데이터 삭제
    await _storage.deleteAll();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('hideCheckedInModalDate');

    // 2. Riverpod Provider 상태 초기화 (invalidate)
    _ref.invalidate(userProvider);
    _ref.invalidate(wishViewModelProvider);
    _ref.invalidate(pieceProvider);
    _ref.invalidate(homeViewModelProvider);
    // ... 다른 non-autoDispose Provider들도 여기에 추가 ...
  }

  /// API 에러 처리 헬퍼 메서드
  Future<void> _handleApiError(BuildContext context, DioException e) async {
    if (e.response?.data['code'] == "AUTH_REQUIRED") {
      print("토큰이 만료되어 재발급합니다.");
      final String? refreshToken = await _storage.read(key: 'refreshToken');
      try {
        await _ref.read(loginServiceProvider).checkToken(refreshToken!);
        toastMessage(
          context,
          '잠시 후, 다시 시도해주세요.',
          type: ToastmessageType.errorType,
        );
      } catch (e) {
        context.go('/login');
        toastMessage(context, '다시 로그인해주세요.', type: ToastmessageType.errorType);
      }
    } else {
      _handleGeneralError(context, e);
    }
  }

  /// 일반 에러 처리 헬퍼 메서드
  void _handleGeneralError(BuildContext context, Object e) {
    toastMessage(
      context,
      e.toDisplayString(),
      type: ToastmessageType.errorType,
    );
  }
}
