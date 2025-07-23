import 'dart:async';
import 'package:earned_it/config/exception.dart';
import 'package:earned_it/models/signup/self_signup_state.dart';
import 'package:earned_it/services/auth/signup_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:toastification/toastification.dart';
import 'package:url_launcher/url_launcher.dart';

// SignUpState를 관리하는 NotifierProvider
final signUpViewModelProvider =
    NotifierProvider.autoDispose<SignUpViewModel, SelfSignupState>(
      SignUpViewModel.new,
    );

// 회원가입 (서버)
class SignUpViewModel extends AutoDisposeNotifier<SelfSignupState> {
  Timer? _codeTimer;
  final RegExp emailRegExp = RegExp(r'^[a-zA-Z0-9@.]+$'); // 이메일 유효성
  final RegExp passwordRegExp = RegExp(
    r'^(?=.*[A-Z])(?=.*[!@#$%^&*()_+={}\[\]|;:"<>,.?/~`])(?=.*\d)[a-zA-Z\d!@#$%^&*()_+={}\[\]|;:"<>,.?/~`]{8,12}$',
  ); // 비밀번호 유효성

  // 컨트롤러 Notifier 내부 관리
  late final TextEditingController _emailController;
  late final TextEditingController _agreeCodeController;
  late final TextEditingController _passwordController;
  late final TextEditingController _checkPasswordController;

  // SignUpService 인스턴스를 저장할 필드
  late final SignUpService _signUpService;

  // 입력 컨트롤러
  TextEditingController get emailController => _emailController;
  TextEditingController get agreeCodeController => _agreeCodeController;
  TextEditingController get passwordController => _passwordController;
  TextEditingController get checkPasswordController => _checkPasswordController;

  @override
  SelfSignupState build() {
    _signUpService = ref.read(signUpServiceProvider);

    // 컨트롤러 초기화
    _emailController = TextEditingController();
    _agreeCodeController = TextEditingController();
    _passwordController = TextEditingController();
    _checkPasswordController = TextEditingController();

    // Notifier가 dispose될 때 컨트롤러도 함께 dispose
    ref.onDispose(() {
      _emailController.dispose();
      _agreeCodeController.dispose();
      _passwordController.dispose();
      _checkPasswordController.dispose();
      _codeTimer?.cancel();
    });

    // freezed 모델의 초기 상태 반환
    return const SelfSignupState();
  }

  String get timerText {
    int minutes = state.startTime ~/ 60;
    int seconds = state.startTime % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  // 이메일 입력 변경 시
  void onEmailChanged(String value) {
    state = state.copyWith(
      isAvailableID:
          value.isNotEmpty &&
          value.contains("@") &&
          emailRegExp.hasMatch(value),
    );
  }

  // 이메일 인증 요청
  Future<void> requestEmail(BuildContext context) async {
    _codeTimer?.cancel(); // 타이머 초기화
    FocusScope.of(context).unfocus(); // 키보드 내리기
    state = state.copyWith(
      isSuccessfulCode: false,
      isAvailableCode: false,
      isRequestAuth: false, // 인증 요청 상태 초기화
    );

    try {
      // 이메일 인증 코드 요청 API
      await _signUpService.sendEmailAuthCode(_emailController.text);

      state = state.copyWith(
        isSuccessfulCode: false,
        isAvailableCode: false,
        isRequestAuth: true, // 인증 요청 상태로 변경
      );
      _agreeCodeController.clear(); // 인증 코드 textfield 초기화

      startTimer(); // 타이머 시작

      // 이메일 인증 번호 전송 toastMessage
      toastification.show(
        alignment: Alignment.topCenter,
        style: ToastificationStyle.simple,
        context: context,
        title: const Text("해당 이메일로 인증 코드를 전송했습니다."),
        autoCloseDuration: const Duration(seconds: 3),
      );
    } catch (e) {
      _codeTimer?.cancel(); // 타이머 초기화
      state = state.copyWith(
        isSuccessfulCode: false,
        isAvailableCode: false,
        isRequestAuth: false, // 인증 요청 상태 초기화
      );
      toastification.show(
        alignment: Alignment.topCenter,
        style: ToastificationStyle.simple,
        context: context,
        title: Text(e.toDisplayString()),
        autoCloseDuration: const Duration(seconds: 3),
      );
    }
  }

  // 인증 코드 입력 변경 시
  void onAuthCodeChanged(String value) {
    state = state.copyWith(isAvailableCode: value.isNotEmpty);
  }

  // 인증 코드 확인
  Future<void> verifyAuthCode(BuildContext context) async {
    FocusScope.of(context).unfocus(); // 키보드 내리기

    try {
      // 인증 코드 확인 API
      await _signUpService.verifyEmail(
        _emailController.text,
        _agreeCodeController.text,
      );
      _codeTimer?.cancel(); // 타이머 취소
      state = state.copyWith(isSuccessfulCode: true);
    } catch (e) {
      state = state.copyWith(isSuccessfulCode: false);
      toastification.show(
        alignment: Alignment.topCenter,
        style: ToastificationStyle.simple,
        context: context,
        title: Text(e.toDisplayString()),
        autoCloseDuration: const Duration(seconds: 3),
      );
    }
  }

  // 비밀번호 입력 변경 시
  void onPasswordChanged(String value) {
    state = state.copyWith(
      isAvailablePassword: value.isNotEmpty && passwordRegExp.hasMatch(value),
    );
    // 비밀번호 변경 시 재확인도 다시 검사하도록 트리거
    onCheckPasswordChanged(_checkPasswordController.text);
  }

  // 비밀번호 재확인 입력 변경 시
  void onCheckPasswordChanged(String value) {
    state = state.copyWith(
      isCheckPassword: value == _passwordController.text, // 컨트롤러 직접 접근
    );
  }

  // 비밀번호 숨기기/보이기 토글
  void toggleObscurePassword() {
    state = state.copyWith(isObscurePassword: !state.isObscurePassword);
  }

  // 서비스 이용 약관 동의 변경 시
  void onAgreedToTermsChanged(bool? value) {
    state = state.copyWith(isAgreedToTerms: value ?? false);
  }

  // 회원가입 버튼 클릭 시
  void signUp(BuildContext context) {
    // 모든 유효성 검사가 통과되었을 때
    if (state.isSuccessfulCode &&
        state.isAvailablePassword &&
        state.isCheckPassword &&
        state.isAgreedToTerms) {
      // 실제 회원가입 API 호출 로직 (예: Dio, http 사용)
      print("회원가입 정보:");
      print("이메일: ${_emailController.text}");
      print("비밀번호: ${_passwordController.text}");
      // 성공/실패에 따른 UI 처리 (예: 네비게이션, 토스트 메시지)
      toastification.show(
        alignment: Alignment.topCenter,
        style: ToastificationStyle.simple,
        context: context,
        title: const Text("회원가입 성공!"),
        autoCloseDuration: const Duration(seconds: 3),
      );
    } else {
      toastification.show(
        alignment: Alignment.topCenter,
        style: ToastificationStyle.simple,
        context: context,
        title: const Text("모든 필수 항목을 확인해주세요."),
        autoCloseDuration: const Duration(seconds: 3),
      );
    }
  }

  // 사용자 약관 동의 web
  Future<void> launchTermsUrl() async {
    final Uri url = Uri.parse(
      'https://github.com/EarnedIt-team',
    ); // 실제 약관 URL로 변경
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  // 인증 코드 타이머 시작
  void startTimer() {
    _codeTimer?.cancel(); // 기존 타이머 취소
    _agreeCodeController.clear(); // 인증 컨트롤러 초기화

    state = state.copyWith(startTime: 900); // 타이머 15분 재설정

    _codeTimer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (state.startTime == 0) {
        timer.cancel(); // 타이머 중지
        // 타이머 만료 시 상태 처리 (예: isSuccessfulCode = false)
        state = state.copyWith(isSuccessfulCode: false);
      } else {
        state = state.copyWith(startTime: state.startTime - 1); // 1초씩 감소
      }
    });
  }

  // 인증 코드 타이머 중지
  void cancelTimer() {
    if (_codeTimer != null) {
      _codeTimer!.cancel();
    }
  }
}
