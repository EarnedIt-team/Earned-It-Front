import 'package:dio/dio.dart';
import 'package:earned_it/config/exception.dart';
import 'package:earned_it/config/toastMessage.dart';
import 'package:earned_it/models/setting/nickname_edit_state.dart';
import 'package:earned_it/services/auth/login_service.dart';
import 'package:earned_it/services/setting_service.dart';
import 'package:earned_it/view_models/user/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';

// 로직을 처리하는 Notifier(ViewModel) 클래스
class NicknameEditViewModel extends AutoDisposeNotifier<NicknameEditState> {
  late final TextEditingController nicknameController;
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  late final SettingService _settingService;
  late final LoginService _loginService;

  @override
  NicknameEditState build() {
    // 1. userProvider로부터 초기 닉네임을 먼저 가져옵니다.
    final initialNickname = ref.read(userProvider).name;
    _settingService = ref.read(settingServiceProvider);
    _loginService = ref.read(loginServiceProvider);

    // 2. 가져온 닉네임으로 컨트롤러를 초기화합니다.
    nicknameController = TextEditingController(text: initialNickname);

    // 3. Notifier가 소멸될 때 컨트롤러와 리스너를 함께 해제합니다.
    ref.onDispose(() {
      nicknameController.removeListener(_validateNickname);
      nicknameController.dispose();
    });

    // 4. 초기 닉네임으로 Provider의 초기 상태를 생성합니다.
    final initialState = NicknameEditState(initialNickname: initialNickname);

    // 5. 상태가 완전히 설정된 후에 리스너를 추가합니다.
    // 이렇게 하면 _validateNickname이 호출될 때 state.initialNickname이 null이 아님을 보장합니다.
    nicknameController.addListener(_validateNickname);

    // 6. 생성된 초기 상태를 반환합니다.
    return initialState;
  }

  // 닉네임 유효성을 검사하고 버튼 상태를 업데이트하는 핵심 로직
  void _validateNickname() {
    final initial = state.initialNickname;
    final currentText = nicknameController.text;
    String? error;

    // --- 유효성 검사 규칙 ---
    if (currentText.isEmpty) {
      error = '닉네임을 입력해주세요.';
    } else if (RegExp(r'\s').hasMatch(currentText)) {
      error = '공백은 사용할 수 없습니다.';
    } else if (RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(currentText)) {
      error = '특수문자는 사용할 수 없습니다.';
    } else if (RegExp(r'^[ㄱ-ㅎㅏ-ㅣ]+$').hasMatch(currentText)) {
      error = '자음 또는 모음만으로 닉네임을 만들 수 없습니다.';
    }

    // 변경 사항이 있는지 확인
    final hasChanges = currentText != initial;

    // 최종 상태 업데이트
    state = state.copyWith(
      validationError: error,
      // 에러가 없고, 변경 사항이 있을 때만 버튼 활성화
      canSubmit: error == null && hasChanges,
    );
  }

  // "수정하기" 버튼을 눌렀을 때 실행될 메서드
  Future<void> submitUpdate(BuildContext context) async {
    if (!state.canSubmit) return;
    state = state.copyWith(isLoading: true);

    print("--- 수정된 닉네임 ---");
    print(nicknameController.text);

    try {
      final String? accessToken = await _storage.read(key: 'accessToken');

      // 닉네임 수정 API
      final response = await _settingService.setNickName(
        "Bearer $accessToken",
        nicknameController.text,
      );

      print('프로필 닉네임 수정 완료: ${response.data}');
      state = state.copyWith(isLoading: false);

      // 닉네임 정보 업데이트
      ref
          .read(userProvider.notifier)
          .updateNickName(nickName: nicknameController.text);

      toastMessage(context, '닉네임이 변경되었습니다.');

      context.pop();
    } on DioException catch (e) {
      state = state.copyWith(isLoading: false); // 로딩 상태 해제

      if (e.response?.data['code'] == "AUTH_REQUIRED") {
        print("토큰이 만료되어 재발급합니다.");
        final String? refreshToken = await _storage.read(key: 'refreshToken');
        try {
          await _loginService.checkToken(refreshToken!);
          toastMessage(
            context,
            '잠시 후, 다시 시도해주세요.',
            type: ToastmessageType.errorType,
          );
        } catch (e) {
          context.go('/login');
          toastMessage(
            context,
            '다시 로그인해주세요.',
            type: ToastmessageType.errorType,
          );
        }
      }
    } catch (e) {
      print('닉네임 설정 중 에러 발생: $e');
      state = state.copyWith(isLoading: false);
      toastMessage(
        context,
        e.toDisplayString(),
        type: ToastmessageType.errorType,
      );
    }
  }
}

// Provider 정의
final nicknameEditViewModelProvider =
    NotifierProvider.autoDispose<NicknameEditViewModel, NicknameEditState>(
      NicknameEditViewModel.new,
    );
