import 'dart:async';
import 'package:earned_it/models/user/forgot_password_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 1. 비밀번호 찾기 단계를 정의하는 Enum
enum ForgotPasswordStep { enterEmail, verifyCode, resetPassword }

// 3. 로직을 처리하는 Notifier(ViewModel) 클래스
class ForgotPasswordViewModel extends AutoDisposeNotifier<ForgotPasswordState> {
  late final TextEditingController emailController;
  late final TextEditingController codeController;
  late final TextEditingController passwordController;
  late final TextEditingController confirmPasswordController;
  Timer? _timer;

  String get timerText {
    final minutes = (state.timerSeconds / 60).floor().toString().padLeft(
      2,
      '0',
    );
    final seconds = (state.timerSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  ForgotPasswordState build() {
    emailController = TextEditingController()..addListener(_validateForms);
    codeController = TextEditingController()..addListener(_validateForms);
    passwordController = TextEditingController()..addListener(_validateForms);
    confirmPasswordController =
        TextEditingController()..addListener(_validateForms);

    ref.onDispose(() {
      _timer?.cancel();
      emailController.dispose();
      codeController.dispose();
      passwordController.dispose();
      confirmPasswordController.dispose();
    });

    return const ForgotPasswordState();
  }

  void _validateForms() {
    final isEmailValid = RegExp(
      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
    ).hasMatch(emailController.text);
    final isPasswordValid = RegExp(
      r'^(?=.*[A-Z])(?=.*[!@#$%^&*(),.?":{}|<>])(?=.*[0-9]).{8,12}$',
    ).hasMatch(passwordController.text);
    final isPasswordConfirmed =
        passwordController.text == confirmPasswordController.text;

    state = state.copyWith(
      isEmailValid: isEmailValid,
      isPasswordValid: isPasswordValid,
      isPasswordConfirmed: isPasswordConfirmed,
    );
  }

  /// 1. 이메일 인증 요청
  Future<void> requestVerificationCode(BuildContext context) async {
    if (!state.isEmailValid) return;
    state = state.copyWith(isLoading: true);
    // TODO: 실제 이메일 인증 요청 API 호출
    await Future.delayed(const Duration(seconds: 1));
    state = state.copyWith(
      isLoading: false,
      currentStep: ForgotPasswordStep.verifyCode,
    );
    _startTimer();
  }

  // 👇 (핵심 수정) 재전송 로직을 처리하는 메서드 추가
  /// 2. 인증 코드 재전송
  Future<void> resendVerificationCode(BuildContext context) async {
    state = state.copyWith(isLoading: true);
    codeController.clear(); // 인증 코드 필드 초기화

    // TODO: 실제 이메일 인증 재전송 API 호출
    await Future.delayed(const Duration(seconds: 1));

    state = state.copyWith(isLoading: false);
    _startTimer(); // 타이머 초기화 및 재시작
  }

  /// 3. 인증 코드 확인
  Future<void> verifyCode(BuildContext context) async {
    state = state.copyWith(isLoading: true);
    // TODO: 실제 인증 코드 확인 API 호출
    await Future.delayed(const Duration(seconds: 1));
    _timer?.cancel();
    state = state.copyWith(
      isLoading: false,
      isCodeVerified: true,
      currentStep: ForgotPasswordStep.resetPassword,
    );
  }

  /// 4. 비밀번호 변경 요청
  Future<void> resetPassword(BuildContext context) async {
    if (!state.isPasswordValid || !state.isPasswordConfirmed) return;
    state = state.copyWith(isLoading: true);
    // TODO: 실제 비밀번호 변경 API 호출
    await Future.delayed(const Duration(seconds: 1));
    state = state.copyWith(isLoading: false);
    if (context.mounted) Navigator.of(context).pop();
  }

  void _startTimer() {
    _timer?.cancel();
    state = state.copyWith(timerSeconds: 900);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.timerSeconds > 0) {
        state = state.copyWith(timerSeconds: state.timerSeconds - 1);
      } else {
        timer.cancel();
      }
    });
  }

  void toggleObscurePassword() =>
      state = state.copyWith(isObscurePassword: !state.isObscurePassword);
  void toggleObscurePasswordConfirm() =>
      state = state.copyWith(
        isObscurePasswordConfirm: !state.isObscurePasswordConfirm,
      );
}

final forgotPasswordViewModelProvider =
    NotifierProvider.autoDispose<ForgotPasswordViewModel, ForgotPasswordState>(
      ForgotPasswordViewModel.new,
    );
