import 'package:earned_it/view_models/auth/forgot_password_provider.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'forgot_password_state.freezed.dart';

// 2. 화면의 상태를 정의하는 State 클래스
@freezed
abstract class ForgotPasswordState with _$ForgotPasswordState {
  const factory ForgotPasswordState({
    @Default(ForgotPasswordStep.enterEmail) ForgotPasswordStep currentStep,
    @Default(false) bool isEmailValid,
    @Default(false) bool isCodeVerified,
    @Default(false) bool isPasswordValid,
    @Default(false) bool isPasswordConfirmed,
    @Default(true) bool isObscurePassword,
    @Default(true) bool isObscurePasswordConfirm,
    @Default(900) int timerSeconds, // 15분 = 900초
    DateTime? timerEndTime,
    String? errorMessage,
    @Default(false) bool isLoading,
  }) = _ForgotPasswordState;
}
