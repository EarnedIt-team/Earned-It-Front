import 'package:earned_it/config/exception.dart';
import 'package:earned_it/models/login/login_state.dart';
import 'package:earned_it/services/auth/apple_login_service.dart';
import 'package:earned_it/services/auth/kakao_login_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:toastification/toastification.dart';

// appleLogin provider
final appleLoginServiceProvider = Provider((ref) => AppleLoginService());
// kakaoLogin provider
final kakaoLoginServiceProvider = Provider((ref) => KakaoLoginService());

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

    // 컨트롤러에 리스너 추가하여 텍스트 변경 시 상태 업데이트
    _idTextController.addListener(_updateLoginButtonState);
    _passwordTextController.addListener(_updateLoginButtonState);

    ref.onDispose(() {
      _idTextController.removeListener(_updateLoginButtonState); // 리스너 제거
      _passwordTextController.removeListener(_updateLoginButtonState); // 리스너 제거
      _idTextController.dispose();
      _passwordTextController.dispose();
    });

    return const LoginState();
  }

  // 로그인 버튼 활성화 상태를 결정하는 게터
  bool get isLoginButtonEnabled {
    return _idTextController.text.isNotEmpty &&
        _passwordTextController.text.isNotEmpty;
  }

  // 텍스트 필드 변경 시 호출될 내부 메서드
  void _updateLoginButtonState() {
    state = state.copyWith(
      isIdValid: _idTextController.text.isNotEmpty,
      isPasswordValid: _passwordTextController.text.isNotEmpty,
    );
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
  Future<void> signInWithApple(BuildContext context) async {
    print("애플 로그인");
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final appleService = ref.read(appleLoginServiceProvider);
      await appleService.login();

      // 로그인 성공 처리 (예: 서버에서 토큰을 받아오고 사용자 상태 업데이트)
      state = state.copyWith(isLoading: false, errorMessage: null);
      toastification.show(
        context: context,
        title: const Text("애플 로그인 성공!"),
        type: ToastificationType.success,
        autoCloseDuration: const Duration(seconds: 2),
      );
      // 성공 후 다음 화면으로 이동
      context.go('/home');
    } catch (e) {
      state = state.copyWith(isLoading: false);
      toastification.show(
        context: context,
        title: const Text("애플 로그인 실패"),
        description: Text(e.toDisplayString()),
        type: ToastificationType.error,
        autoCloseDuration: const Duration(seconds: 3),
      );
    }
  }

  /// SNS 로그인 (카카오)
  Future<void> signInWithKakao(BuildContext context) async {
    print("카카오 로그인");
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final kakaoService = ref.read(kakaoLoginServiceProvider);
      await kakaoService.login();

      // 로그인 성공 처리 (예: 서버에서 토큰을 받아오고 사용자 상태 업데이트)
      state = state.copyWith(isLoading: false, errorMessage: null);
      toastification.show(
        context: context,
        title: const Text("카카오 로그인 성공!"),
        type: ToastificationType.success,
        autoCloseDuration: const Duration(seconds: 2),
      );
      // 성공 후 다음 화면으로 이동
      context.go('/home');
    } catch (e) {
      // Exception 문구 제거
      String errorMessage = e.toString();
      if (errorMessage.startsWith('Exception: ')) {
        errorMessage = errorMessage.substring('Exception: '.length);
      }
      state = state.copyWith(isLoading: false);
      toastification.show(
        context: context,
        title: const Text("카카오 로그인 실패"),
        description: Text(errorMessage),
        type: ToastificationType.error,
        autoCloseDuration: const Duration(seconds: 3),
      );
    }
  }
}
