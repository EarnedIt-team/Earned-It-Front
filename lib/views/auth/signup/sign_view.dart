import 'package:earned_it/config/design.dart';
import 'package:earned_it/view_models/self_signup_provider.dart';
import 'package:earned_it/views/loading_overlay_view.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignView extends ConsumerWidget {
  const SignView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signUpState = ref.watch(signUpViewModelProvider);
    final signUpNotifier = ref.read(signUpViewModelProvider.notifier);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Stack(
        children: <Widget>[
          Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              centerTitle: false,
              title: const Text(
                "회원가입",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: context.middlePadding),
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                  top: context.height(0.01),
                  bottom:
                      MediaQuery.of(context).padding.bottom +
                      context.height(0.15),
                ),
                child: Column(
                  children: <Widget>[
                    // 아이디 입력 필드
                    _buildSignTextField(
                      context,
                      "이메일",
                      controller:
                          signUpNotifier.emailController, // Notifier의 컨트롤러 사용
                      onChanged: signUpNotifier.onEmailChanged,
                      readOnly: signUpState.isSuccessfulCode,
                      suffixIcon:
                          signUpNotifier.emailController.text.isNotEmpty &&
                                  signUpState.isAvailableID &&
                                  !signUpState.isSuccessfulCode
                              ? TextButton(
                                onPressed:
                                    () => signUpNotifier.requestEmail(context),
                                child: const Text("인증 요청"),
                              )
                              : null,
                      errorText:
                          signUpNotifier.emailController.text.isNotEmpty &&
                                  !signUpState.isAvailableID
                              ? '유효하지 않은 이메일 형식입니다.'
                              : null,
                      keyboardType: TextInputType.emailAddress,
                      hintText: "ex) email@example.com",
                      helperWidget:
                          signUpState.isSuccessfulCode
                              ? Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.check,
                                    color: context.successColor,
                                  ),
                                  Text(
                                    " 사용 가능한 이메일입니다.",
                                    style: TextStyle(
                                      color: context.successColor,
                                    ),
                                  ),
                                ],
                              )
                              : null,
                    ),
                    SizedBox(height: context.height(0.03)),

                    // 이메일 인증 필드 (요청시에만 표시)
                    signUpState.isRequestAuth
                        ? _buildSignTextField(
                          context,
                          "이메일 인증",
                          controller:
                              signUpNotifier
                                  .agreeCodeController, // Notifier의 컨트롤러 사용
                          onChanged: signUpNotifier.onAuthCodeChanged,
                          readOnly: signUpState.isSuccessfulCode,
                          keyboardType: TextInputType.number,
                          hintText: "전송된 인증코드를 입력해주세요.",
                          helperWidget:
                              signUpState.isSuccessfulCode
                                  ? Row(
                                    children: <Widget>[
                                      Icon(
                                        Icons.check,
                                        color: context.successColor,
                                      ),
                                      Text(
                                        " 이메일 인증이 완료되었습니다.",
                                        style: TextStyle(
                                          color: context.successColor,
                                        ),
                                      ),
                                    ],
                                  )
                                  : Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          const Icon(
                                            Icons.timer_sharp,
                                            color: Colors.red,
                                          ),
                                          Text(
                                            signUpNotifier.timerText,
                                            style: const TextStyle(
                                              color: Colors.red,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          TextButton(
                                            onPressed:
                                                signUpState.startTime <= 895
                                                    ? () => signUpNotifier
                                                        .requestEmail(context)
                                                    : null,
                                            child: const Text("재전송"),
                                          ),
                                          TextButton(
                                            onPressed:
                                                signUpState.isAvailableCode
                                                    ? () => signUpNotifier
                                                        .verifyAuthCode(context)
                                                    : null,
                                            child: const Text("코드 확인"),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                        )
                        : const SizedBox.shrink(),
                    SizedBox(
                      height:
                          signUpState.isRequestAuth ? context.height(0.03) : 0,
                    ),

                    // 비밀번호 입력 필드
                    _buildSignTextField(
                      context,
                      "비밀번호",
                      controller:
                          signUpNotifier
                              .passwordController, // Notifier의 컨트롤러 사용
                      onChanged: signUpNotifier.onPasswordChanged,
                      obscureText: signUpState.isObscurePassword,
                      suffixIcon: IconButton(
                        onPressed: signUpNotifier.toggleObscurePassword,
                        icon: Icon(
                          signUpState.isObscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                      ),
                      hintText: "영문 대문자, 특수문자, 숫자 포함 8~12자",
                      helperWidget:
                          signUpState.isAvailablePassword
                              ? Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.check,
                                    color: context.successColor,
                                  ),
                                  Text(
                                    "사용가능한 비밀번호입니다.",
                                    style: TextStyle(
                                      color: context.successColor,
                                    ),
                                  ),
                                ],
                              )
                              : null,
                      errorText:
                          signUpNotifier.passwordController.text.isNotEmpty &&
                                  !signUpState.isAvailablePassword
                              ? '사용할 수 없는 비밀번호 입니다.'
                              : null,
                    ),
                    SizedBox(height: context.height(0.03)),

                    // 비밀번호 재확인 입력 필드
                    _buildSignTextField(
                      context,
                      "비밀번호 재확인",
                      controller:
                          signUpNotifier
                              .checkPasswordController, // Notifier의 컨트롤러 사용
                      onChanged: signUpNotifier.onCheckPasswordChanged,
                      obscureText: signUpState.isObscurePasswordCheck,
                      suffixIcon: IconButton(
                        onPressed: signUpNotifier.toggleObscurePasswordCheck,
                        icon: Icon(
                          signUpState.isObscurePasswordCheck
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                      ),
                      hintText: "영문 대문자, 특수문자, 숫자 포함 8~12자",
                      helperWidget:
                          signUpNotifier.passwordController.text.isNotEmpty &&
                                  signUpState.isCheckPassword
                              ? Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.check,
                                    color: context.successColor,
                                  ),
                                  Text(
                                    "비밀번호가 일치합니다.",
                                    style: TextStyle(
                                      color: context.successColor,
                                    ),
                                  ),
                                ],
                              )
                              : null,
                      errorText:
                          signUpNotifier
                                      .checkPasswordController
                                      .text
                                      .isNotEmpty &&
                                  !signUpState.isCheckPassword
                              ? "8~12자 이내로, 영문 대문자, 특수문자, 숫자를 포함해야 합니다."
                              : null,
                    ),
                    SizedBox(height: context.height(0.03)),

                    // 서비스 이용 약관 동의 체크박스
                    Row(
                      children: <Widget>[
                        Checkbox(
                          value: signUpState.isAgreedToTerms,
                          onChanged: signUpNotifier.onAgreedToTermsChanged,
                        ),
                        Text.rich(
                          TextSpan(
                            children: <InlineSpan>[
                              TextSpan(
                                text: "서비스 이용 약관",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  decoration: TextDecoration.underline,
                                  decorationColor: Colors.grey,
                                  height: 1.5,
                                ),
                                recognizer:
                                    TapGestureRecognizer()
                                      ..onTap = () {
                                        signUpNotifier.launchTermsUrl();
                                      },
                              ),
                              const TextSpan(
                                text: "에 동의합니다.",
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // 회원가입 버튼
            bottomNavigationBar: SafeArea(
              child: Padding(
                padding: EdgeInsets.only(
                  left: context.middlePadding,
                  right: context.middlePadding,
                  bottom: context.height(0.01),
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed:
                        signUpState.isSuccessfulCode &&
                                signUpState.isAvailablePassword &&
                                signUpState.isCheckPassword &&
                                signUpState.isAgreedToTerms
                            ? () => signUpNotifier.signUp(context)
                            : null,
                    child: const Text("동의하고 회원가입"),
                  ),
                ),
              ),
            ),
          ),

          // 로딩 오버레이
          if (signUpState.isProgress) // 서버 처리중일 때
            overlayView(),
        ],
      ),
    );
  }

  Widget _buildSignTextField(
    BuildContext context,
    String type, {
    required TextEditingController controller,
    required ValueChanged<String> onChanged,
    bool readOnly = false,
    bool obscureText = false,
    TextInputType? keyboardType,
    String? hintText,
    Widget? suffixIcon,
    Widget? helperWidget,
    String? errorText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(type, style: const TextStyle(fontWeight: FontWeight.bold)),
        TextField(
          controller: controller,
          readOnly: readOnly,
          obscureText: obscureText,
          keyboardType: keyboardType,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              color: Colors.grey,
              fontSize: context.regularFont,
            ),
            suffixIcon: suffixIcon,
            helper: helperWidget,
            errorText: errorText,
            errorMaxLines: 2,
          ),
        ),
      ],
    );
  }
}
