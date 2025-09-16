import 'package:dio/dio.dart';
import 'package:earned_it/config/exception.dart';
import 'package:earned_it/config/toastMessage.dart';
import 'package:earned_it/models/setting/set_public_state.dart';
import 'package:earned_it/models/user/user_state.dart';
import 'package:earned_it/services/auth/login_service.dart';
import 'package:earned_it/services/setting_service.dart';
import 'package:earned_it/view_models/user/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final setPublicViewModelProvider =
    NotifierProvider.autoDispose<SetPublicProvider, SetPublicState>(
      SetPublicProvider.new,
    );

class SetPublicProvider extends AutoDisposeNotifier<SetPublicState> {
  late final SettingService _settingService;
  // ✨ 1. 토큰 재발급을 위해 LoginService 추가
  late final LoginService _loginService;
  final _storage = const FlutterSecureStorage();

  @override
  SetPublicState build() {
    _settingService = ref.read(settingServiceProvider);
    _loginService = ref.read(loginServiceProvider);
    // UserProvider에서 초기 isPublic 값을 가져와 상태를 초기화합니다.
    final initialIsPublic = ref.read(userProvider).isPublic ?? false;
    return SetPublicState(isPublic: initialIsPublic);
  }

  /// 사용자의 공개 설정을 서버에 업데이트합니다.
  Future<void> updatePublicStatus(BuildContext context, bool newStatus) async {
    // 이미 로딩 중이면 중복 요청 방지
    if (state.isLoading) return;

    // ✨ 2. API 호출 전에 상태를 먼저 업데이트하여 UI에 즉시 반영
    final previousStatus = state.isPublic;
    state = state.copyWith(isLoading: true, isPublic: newStatus);

    try {
      final accessToken = await _storage.read(key: 'accessToken');
      if (accessToken == null) throw Exception("로그인이 필요합니다.");

      // SettingService를 통해 API 호출
      await _settingService.setPublic(accessToken, newStatus);

      state = state.copyWith(isPublic: newStatus);

      // API 호출 성공 시, 전역 User 상태도 업데이트
      // ref.read(userProvider.notifier).updateIsPublic(newStatus);

      if (context.mounted) {
        toastMessage(context, "공개 설정이 완료되었습니다.");
      }
    } on DioException catch (e) {
      // ✨ 3. 에러 발생 시, 상태를 이전 값으로 되돌리고 헬퍼 메서드 호출
      state = state.copyWith(isPublic: previousStatus);
      if (context.mounted) {
        await _handleApiError(context, e);
      }
    } catch (e) {
      // ✨ 3. 에러 발생 시, 상태를 이전 값으로 되돌리고 헬퍼 메서드 호출
      state = state.copyWith(isPublic: previousStatus);
      if (context.mounted) {
        _handleGeneralError(context, e);
      }
    } finally {
      if (ref.exists(setPublicViewModelProvider)) {
        state = state.copyWith(isLoading: false);
      }
    }
  }

  // --- 에러 처리 헬퍼 메서드 ---
  Future<void> _handleApiError(BuildContext context, DioException e) async {
    // 로딩 상태는 헬퍼 메서드 호출 전에 이미 false로 설정됨
    if (e.response?.data['code'] == "AUTH_REQUIRED") {
      // TODO: 토큰 재발급 로직 구현
      // 예: final newAccessToken = await _loginService.reissueToken();
      // await _storage.write(key: 'accessToken', value: newAccessToken);
      // 재시도: await updatePublicStatus(context, state.isPublic);
      _handleGeneralError(context, '인증이 만료되었습니다. 다시 시도해주세요.');
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
