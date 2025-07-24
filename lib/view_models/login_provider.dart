import 'package:earned_it/config/exception.dart';
import 'package:earned_it/models/login/login_state.dart';
import 'package:earned_it/services/auth/apple_login_service.dart';
import 'package:earned_it/services/auth/kakao_login_service.dart';
import 'package:earned_it/services/auth/login_service.dart';
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

  // loginService 인스턴스를 저장할 필드
  late final LoginService _loginService;

  TextEditingController get idTextController => _idTextController;
  TextEditingController get passwordTextController => _passwordTextController;

  @override
  LoginState build() {
    _loginService = ref.read(loginServiceProvider);

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

  /// 자체 로그인
  Future<void> login(BuildContext context) async {
    // 로딩 상태 시작
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      // 자체 로그인 API
      final response = await _loginService.selfLogin(
        _idTextController.text,
        _passwordTextController.text,
      );

      state = state.copyWith(isLoading: false);

      print("accessToken : ${response.data['accessToken']}");
      print("refreshToken : ${response.data['refreshToken']}");

      context.go('/home');
    } catch (e) {
      state = state.copyWith(isLoading: false);
      toastification.show(
        alignment: Alignment.topCenter,
        style: ToastificationStyle.simple,
        context: context,
        title: Text(e.toDisplayString()),
        autoCloseDuration: const Duration(seconds: 3),
      );
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
