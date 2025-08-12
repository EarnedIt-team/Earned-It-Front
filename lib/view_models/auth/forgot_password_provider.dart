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

enum ForgotPasswordStep { enterEmail, verifyCode, resetPassword }

class ForgotPasswordViewModel extends AutoDisposeNotifier<ForgotPasswordState> {
  late final TextEditingController emailController;
  late final TextEditingController codeController;
  late final TextEditingController passwordController;
  late final TextEditingController confirmPasswordController;
  late final ForgotPasswordService _forgotPasswordService;
  late final LoginService _loginService;
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
    _loginService = ref.read(loginServiceProvider);

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

  // --- (핵심 수정) 타이머 시작 로직 변경 ---
  void _startTimer() {
    _timer?.cancel();
    // 1. 15분 후의 정확한 종료 시간을 계산하여 상태에 저장합니다.
    final endTime = DateTime.now().add(const Duration(minutes: 15));
    state = state.copyWith(timerEndTime: endTime);

    // 2. 1초마다 UI를 갱신하기 위한 타이머를 시작합니다.
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.timerEndTime == null) {
        timer.cancel();
        return;
      }
      // 3. 현재 시간과 목표 시간의 차이를 계산하여 남은 시간을 구합니다.
      final remaining = state.timerEndTime!.difference(DateTime.now());

      if (remaining.isNegative) {
        // 시간이 다 되면 타이머를 멈추고 0초로 설정합니다.
        state = state.copyWith(timerSeconds: 0);
        timer.cancel();
      } else {
        // 남은 시간을 초 단위로 상태에 업데이트합니다.
        state = state.copyWith(timerSeconds: remaining.inSeconds);
      }
    });
  }

  // --- API 호출 메서드들 (내부 로직은 동일) ---
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
      _startTimer(); // 수정된 타이머 시작 함수 호출
    } on DioException catch (e) {
      if (context.mounted) _handleApiError(context, e);
    } catch (e) {
      if (context.mounted) _handleGeneralError(context, e);
    } finally {
      if (context.mounted) state = state.copyWith(isLoading: false);
    }
  }

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
      _startTimer(); // 수정된 타이머 시작 함수 호출
    } on DioException catch (e) {
      if (context.mounted) _handleApiError(context, e);
    } catch (e) {
      if (context.mounted) _handleGeneralError(context, e);
    } finally {
      if (context.mounted) state = state.copyWith(isLoading: false);
    }
  }

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

  void toggleObscurePassword() =>
      state = state.copyWith(isObscurePassword: !state.isObscurePassword);
  void toggleObscurePasswordConfirm() =>
      state = state.copyWith(
        isObscurePasswordConfirm: !state.isObscurePasswordConfirm,
      );

  Future<void> _handleApiError(BuildContext context, DioException e) async {
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
