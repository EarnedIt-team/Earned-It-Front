import 'dart:async';
import 'package:dio/dio.dart';
import 'package:earned_it/config/exception.dart';
import 'package:earned_it/models/user/forgot_password_state.dart';
import 'package:earned_it/services/auth/forgot_password_service.dart';
import 'package:earned_it/services/auth/login_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:toastification/toastification.dart';

// 1. 비밀번호 찾기 단계를 정의하는 Enum
enum ForgotPasswordStep { enterEmail, verifyCode, resetPassword }

class ForgotPasswordViewModel extends AutoDisposeNotifier<ForgotPasswordState> {
  late final TextEditingController emailController;
  late final TextEditingController codeController;
  late final TextEditingController passwordController;
  late final TextEditingController confirmPasswordController;
  late final ForgotPasswordService _forgotPasswordService;
  late final LoginService _loginService; //  LoginService 변수 추가
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
    _forgotPasswordService = ref.read(forgotPasswordServiceProvider);
    _loginService = ref.read(loginServiceProvider); //  LoginService 초기화

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
    try {
      await _forgotPasswordService.sendpasswordEmail(emailController.text);

      toastification.show(
        context: context,
        type: ToastificationType.success,
        title: const Text('인증번호가 발송되었습니다.'),
      );

      state = state.copyWith(currentStep: ForgotPasswordStep.verifyCode);
      _startTimer();
    } on DioException catch (e) {
      // 👈 4. DioException 별도 처리
      if (context.mounted) _handleApiError(context, e);
    } catch (e) {
      if (context.mounted) _handleGeneralError(context, e);
    } finally {
      if (context.mounted) state = state.copyWith(isLoading: false);
    }
  }

  /// 2. 인증 코드 재전송
  Future<void> resendVerificationCode(BuildContext context) async {
    state = state.copyWith(isLoading: true);
    codeController.clear();
    try {
      await _forgotPasswordService.sendpasswordEmail(emailController.text);

      toastification.show(
        context: context,
        type: ToastificationType.info,
        title: const Text('인증번호가 재전송되었습니다.'),
      );
      _startTimer();
    } on DioException catch (e) {
      if (context.mounted) _handleApiError(context, e);
    } catch (e) {
      if (context.mounted) _handleGeneralError(context, e);
    } finally {
      if (context.mounted) state = state.copyWith(isLoading: false);
    }
  }

  /// 3. 인증 코드 확인
  Future<void> verifyCode(BuildContext context) async {
    state = state.copyWith(isLoading: true);
    try {
      await _forgotPasswordService.verifyPasswordEmail(
        emailController.text,
        codeController.text,
      );
      _timer?.cancel();

      toastification.show(
        context: context,
        type: ToastificationType.success,
        title: const Text('인증이 완료되었습니다.'),
      );

      state = state.copyWith(
        isCodeVerified: true,
        currentStep: ForgotPasswordStep.resetPassword,
      );
    } on DioException catch (e) {
      if (context.mounted) _handleApiError(context, e);
    } catch (e) {
      if (context.mounted) _handleGeneralError(context, e);
    } finally {
      if (context.mounted) state = state.copyWith(isLoading: false);
    }
  }

  /// 4. 비밀번호 변경 요청
  Future<void> resetPassword(BuildContext context) async {
    if (!state.isPasswordValid || !state.isPasswordConfirmed) return;
    state = state.copyWith(isLoading: true);
    try {
      await _forgotPasswordService.resetPassword(
        emailController.text,
        passwordController.text,
      );

      toastification.show(
        context: context,
        type: ToastificationType.success,
        title: const Text('비밀번호가 성공적으로 변경되었습니다.'),
      );

      if (context.mounted) context.go('/login');
    } on DioException catch (e) {
      if (context.mounted) _handleApiError(context, e);
    } catch (e) {
      if (context.mounted) _handleGeneralError(context, e);
    } finally {
      if (context.mounted) state = state.copyWith(isLoading: false);
    }
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

  // --- 에러 처리 헬퍼 메서드 ---
  // 👇 5. _handleApiError 메서드 추가
  Future<void> _handleApiError(BuildContext context, DioException e) async {
    // 비밀번호 찾기 흐름에서는 토큰 만료 에러가 발생할 가능성이 낮지만,
    // 다른 ViewModel과의 일관성을 위해 구조를 유지합니다.
    if (e.response?.data['code'] == "AUTH_REQUIRED") {
      _handleGeneralError(context, "인증 정보가 유효하지 않습니다. 다시 시도해주세요.");
    } else {
      _handleGeneralError(context, e);
    }
  }

  void _handleGeneralError(BuildContext context, Object e) {
    state = state.copyWith(isLoading: false);
    toastification.show(
      context: context,
      type: ToastificationType.error,
      style: ToastificationStyle.flat,
      title: Text(e.toDisplayString()),
      autoCloseDuration: const Duration(seconds: 3),
    );
  }
}

final forgotPasswordViewModelProvider =
    NotifierProvider.autoDispose<ForgotPasswordViewModel, ForgotPasswordState>(
      ForgotPasswordViewModel.new,
    );
