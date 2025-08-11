import 'package:earned_it/config/design.dart';
import 'package:earned_it/models/user/forgot_password_state.dart';
import 'package:earned_it/view_models/auth/forgot_password_provider.dart';
import 'package:earned_it/views/loading_overlay_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ForgotPasswordView extends ConsumerWidget {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(forgotPasswordViewModelProvider);
    final notifier = ref.read(forgotPasswordViewModelProvider.notifier);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              title: const Text(
                "비밀번호 찾기",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              centerTitle: false,
            ),
            body: SingleChildScrollView(
              padding: EdgeInsets.all(context.middlePadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- 1단계: 이메일 입력 ---
                  _buildTextField(
                    context,
                    "이메일",
                    controller: notifier.emailController,
                    errorText:
                        notifier.emailController.text.isNotEmpty &&
                                !state.isEmailValid &&
                                state.currentStep ==
                                    ForgotPasswordStep.enterEmail
                            ? '유효하지 않은 이메일 형식입니다.'
                            : null,
                    hintText: "ex) email@example.com",
                    readOnly:
                        state.currentStep != ForgotPasswordStep.enterEmail,
                  ),
                  SizedBox(height: context.height(0.03)),

                  // --- 2단계: 인증번호 입력 ---
                  if (state.currentStep == ForgotPasswordStep.verifyCode)
                    _buildTextField(
                      context,
                      "인증번호",
                      controller: notifier.codeController,
                      hintText: "전송된 인증번호를 입력해주세요.",
                      keyboardType: TextInputType.number,
                      helperWidget: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            notifier.timerText,
                            style: const TextStyle(color: Colors.red),
                          ),
                          TextButton(
                            onPressed:
                                () => notifier.resendVerificationCode(context),
                            child: const Text("재전송"),
                          ),
                        ],
                      ),
                    ),
                  if (state.currentStep == ForgotPasswordStep.verifyCode)
                    SizedBox(height: context.height(0.03)),

                  // --- 3단계: 새 비밀번호 입력 ---
                  if (state.currentStep ==
                      ForgotPasswordStep.resetPassword) ...[
                    _buildTextField(
                      context,
                      "새 비밀번호",
                      controller: notifier.passwordController,
                      hintText: "영문 대문자, 특수문자, 숫자 포함 8~12자",
                      obscureText: state.isObscurePassword,
                      errorText:
                          !state.isPasswordValid &&
                                  notifier.passwordController.text.isNotEmpty
                              ? "비밀번호 형식이 올바르지 않습니다."
                              : null,
                      suffixIcon: IconButton(
                        icon: Icon(
                          state.isObscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: notifier.toggleObscurePassword,
                      ),
                    ),
                    SizedBox(height: context.height(0.03)),
                    _buildTextField(
                      context,
                      "새 비밀번호 확인",
                      controller: notifier.confirmPasswordController,
                      hintText: "비밀번호를 다시 한번 입력해주세요.",
                      obscureText: state.isObscurePasswordConfirm,
                      errorText:
                          !state.isPasswordConfirmed &&
                                  notifier
                                      .confirmPasswordController
                                      .text
                                      .isNotEmpty
                              ? "비밀번호가 일치하지 않습니다."
                              : null,
                      suffixIcon: IconButton(
                        icon: Icon(
                          state.isObscurePasswordConfirm
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: notifier.toggleObscurePasswordConfirm,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            bottomNavigationBar: SafeArea(
              child: Padding(
                padding: EdgeInsets.all(context.middlePadding),
                child: SizedBox(
                  width: double.infinity,
                  height: context.height(0.06),
                  child: _buildBottomButton(context, state, notifier),
                ),
              ),
            ),
          ),
          if (state.isLoading) overlayView(),
        ],
      ),
    );
  }

  // --- 현재 단계에 맞는 하단 버튼을 반환하는 헬퍼 위젯 ---
  Widget _buildBottomButton(
    BuildContext context,
    ForgotPasswordState state,
    ForgotPasswordViewModel notifier,
  ) {
    Widget buildButtonChild(String text) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.black),
        ],
      );
    }

    switch (state.currentStep) {
      case ForgotPasswordStep.enterEmail:
        return ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
          onPressed:
              state.isEmailValid
                  ? () => notifier.requestVerificationCode(context)
                  : null,
          child: buildButtonChild("인증 요청"),
        );
      case ForgotPasswordStep.verifyCode:
        return ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
          onPressed:
              notifier.codeController.text.isNotEmpty
                  ? () => notifier.verifyCode(context)
                  : null,
          child: buildButtonChild("인증 확인"),
        );
      case ForgotPasswordStep.resetPassword:
        return ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
          onPressed:
              state.isPasswordValid && state.isPasswordConfirmed
                  ? () => notifier.resetPassword(context)
                  : null,
          child: const Text("변경 완료"),
        );
    }
  }

  // --- 공통 TextField 위젯 ---
  Widget _buildTextField(
    BuildContext context,
    String label, {
    required TextEditingController controller,
    String? hintText,
    bool readOnly = false,
    bool obscureText = false,
    TextInputType? keyboardType,
    Widget? suffixIcon,
    Widget? helperWidget,
    String? errorText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: context.width(0.04),
          ),
        ),
        TextField(
          controller: controller,
          readOnly: readOnly,
          obscureText: obscureText,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hintText,
            suffixIcon: suffixIcon,
            helper: helperWidget,
            errorText: errorText,
          ),
        ),
      ],
    );
  }
}
