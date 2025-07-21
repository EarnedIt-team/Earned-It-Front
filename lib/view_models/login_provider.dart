import 'package:earned_it/models/login/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:toastification/toastification.dart';

final loginViewModelProvider = NotifierProvider<LoginViewModel, LoginState>(
  LoginViewModel.new,
);

class LoginViewModel extends Notifier<LoginState> {
  late final TextEditingController _idTextController;
  late final TextEditingController _passwordTextController;

  TextEditingController get idTextController => _idTextController;
  TextEditingController get passwordTextController => _passwordTextController;

  @override
  LoginState build() {
    _idTextController = TextEditingController();
    _passwordTextController = TextEditingController();

    // Notifier가 dispose될 때 컨트롤러도 함께 dispose
    ref.onDispose(() {
      _idTextController.dispose();
      _passwordTextController.dispose();
    });

    return const LoginState(); // 초기 상태 반환
  }

  /// 비밀번호 숨김/보임 상태를 토글합니다.
  void toggleObscurePassword() {
    state = state.copyWith(isObscurePassword: !state.isObscurePassword);
  }

  /// 로그인 버튼 클릭 시 호출됩니다.
  Future<void> login(BuildContext context) async {
    // 로딩 상태 시작
    state = state.copyWith(isLoading: true, errorMessage: null);

    final String id = _idTextController.text;
    final String password = _passwordTextController.text;

    // 실제 로그인 API 호출 로직 (예: HTTP 요청)
    // 여기서는 간단히 2초 지연 후 성공/실패를 가정합니다.
    await Future.delayed(const Duration(seconds: 2));

    if (id == "test@example.com" && password == "Password123!") {
      // 로그인 성공
      state = state.copyWith(isLoading: false, errorMessage: null);
      toastification.show(
        context: context,
        title: const Text("로그인 성공!"),
        type: ToastificationType.success,
        autoCloseDuration: const Duration(seconds: 2),
      );
      // 로그인 성공 후 메인 페이지 등으로 이동 (GoRouter 사용 예시)
      // context.go('/');
      print("로그인 성공: $id");
    } else {
      // 로그인 실패
      state = state.copyWith(
        isLoading: false,
        errorMessage: "아이디 또는 비밀번호가 올바르지 않습니다.",
      );
      print("로그인 실패");
    }
  }

  /// SNS 로그인 (애플)
  void signInWithApple(BuildContext context) {
    // 실제 애플 로그인 로직 구현
    print("애플 로그인");
    // 예: 서버에 인증 요청 후, 로그인 성공 시 state 업데이트 및 페이지 이동
  }

  /// SNS 로그인 (카카오)
  void signInWithKakao(BuildContext context) {
    // 실제 카카오 로그인 로직 구현
    print("카카오 로그인");
    // 예: 서버에 인증 요청 후, 로그인 성공 시 state 업데이트 및 페이지 이동
  }
}
