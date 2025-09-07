import 'package:dio/dio.dart';
import 'package:earned_it/config/exception.dart';
import 'package:earned_it/config/toastMessage.dart';
import 'package:earned_it/models/user/profile_state.dart';
import 'package:earned_it/models/user/profile_user_model.dart';
import 'package:earned_it/models/wish/wish_model.dart';
import 'package:earned_it/services/auth/login_service.dart';
import 'package:earned_it/services/auth/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// ✨ NotifierProvider.autoDispose.family를 사용합니다.
// 첫 번째 제네릭: Notifier 클래스 (ProfileViewModel)
// 두 번째 제네릭: 관리할 State (ProfileState)
// 세 번째 제네릭: Provider에 전달할 파라미터 타입 (int, 즉 userId)
final profileViewModelProvider = NotifierProvider.autoDispose
    .family<ProfileViewModel, ProfileState, int>(ProfileViewModel.new);

class ProfileViewModel extends AutoDisposeFamilyNotifier<ProfileState, int> {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  late final UserService _userService;
  late final LoginService _loginService;

  // .family를 사용하면 build 메서드에서 파라미터(arg)를 받을 수 있습니다.
  // 여기서는 userId를 받습니다.
  @override
  ProfileState build(int userId) {
    _userService = ref.read(userServiceProvider);
    _loginService = ref.read(loginServiceProvider);
    // 초기 상태 반환
    return const ProfileState();
  }

  /// 다른 사용자의 프로필 정보 불러오기
  Future<void> loadProfileData(BuildContext context) async {
    if (state.isLoading) return;

    state = state.copyWith(isLoading: true);
    try {
      final accessToken = await _storage.read(key: 'accessToken');
      if (accessToken == null) throw Exception("로그인이 필요합니다.");

      // build 메서드에서 받은 userId(arg)를 사용하여 API 호출
      final response = await _userService.loadOtherProfile(accessToken, arg);

      final data = response.data;
      final userInfo = ProfileUserModel.fromJson(data['userInfo']);
      final starList =
          (data['starList'] as List)
              .map((item) => WishModel.fromJson(item as Map<String, dynamic>))
              .toList();

      state = state.copyWith(
        isLoading: false,
        userInfo: userInfo,
        starList: starList,
      );
    } on DioException catch (e) {
      if (context.mounted) await _handleApiError(context, e);
    } catch (e) {
      if (context.mounted) _handleGeneralError(context, e);
    } finally {
      if (ref.exists(profileViewModelProvider(arg))) {
        state = state.copyWith(isLoading: false);
      }
    }
  }

  // --- 에러 처리 헬퍼 메서드 ---
  Future<void> _handleApiError(BuildContext context, DioException e) async {
    state = state.copyWith(isLoading: false);
    if (e.response?.data['code'] == "AUTH_REQUIRED") {
      // ... (토큰 재발급 로직)
    } else {
      _handleGeneralError(context, e);
    }
  }

  void _handleGeneralError(BuildContext context, Object e) {
    state = state.copyWith(isLoading: false);
    print(e);
    toastMessage(
      context,
      e.toDisplayString(),
      type: ToastmessageType.errorType,
    );
  }
}
