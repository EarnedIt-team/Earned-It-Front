import 'dart:io';
import 'package:earned_it/config/design.dart';
import 'package:earned_it/view_models/auth/login_provider.dart';
import 'package:earned_it/views/loading_overlay_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LoginView extends ConsumerWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginState = ref.watch(loginViewModelProvider);
    final loginNotifier = ref.read(loginViewModelProvider.notifier);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Stack(
          children: <Widget>[
            SafeArea(
              // 👇 1. (핵심 수정) SingleChildScrollView로 전체를 감쌉니다.
              child: SingleChildScrollView(
                // 👇 2. ConstrainedBox를 사용하여 자식의 최소 높이를 화면 높이로 강제합니다.
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    // 키보드가 올라올 때 줄어드는 화면 높이를 반영합니다.
                    minHeight:
                        MediaQuery.of(context).size.height -
                        MediaQuery.of(context).padding.top -
                        kToolbarHeight, // AppBar가 있다면 높이를 빼줍니다.
                  ),
                  // 👇 3. IntrinsicHeight와 Center를 사용하여 콘텐츠를 세로 중앙에 배치합니다.
                  child: IntrinsicHeight(
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.all(context.loginPadding),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            // 메인 로고
                            Image.asset(
                              Theme.of(context).brightness == Brightness.dark
                                  ? "assets/images/logo_no_color.png"
                                  : "assets/images/logo_color.png",
                              width: context.width(0.5),
                            ),
                            SizedBox(height: context.height(0.07)),
                            // 이메일 & 비밀번호
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                TextField(
                                  controller: loginNotifier.idTextController,
                                  decoration: const InputDecoration(
                                    labelText: "이메일",
                                    labelStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                TextField(
                                  controller:
                                      loginNotifier.passwordTextController,
                                  obscureText: loginState.isObscurePassword,
                                  decoration: InputDecoration(
                                    labelText: "비밀번호",
                                    labelStyle: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                    suffixIcon: IconButton(
                                      onPressed:
                                          loginNotifier.toggleObscurePassword,
                                      icon: Icon(
                                        loginState.isObscurePassword
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                      ),
                                    ),
                                  ),
                                ),
                                if (loginState.errorMessage != null)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Text(
                                      loginState.errorMessage!,
                                      style: const TextStyle(color: Colors.red),
                                    ),
                                  ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    TextButton(
                                      onPressed: () => context.push("/sign"),
                                      child: const Text(
                                        "회원가입",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed:
                                          () =>
                                              context.push("/forgot_password"),
                                      child: const Text(
                                        "비밀번호 찾기",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: context.height(0.02)),
                            // 로그인 버튼
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed:
                                    loginState.isIdValid &&
                                            loginState.isPasswordValid
                                        ? () {
                                          FocusScope.of(context).unfocus();
                                          loginNotifier.login(context);
                                        }
                                        : null,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: primaryGradientEnd,
                                  padding: EdgeInsets.symmetric(
                                    vertical: context.buttonPadding,
                                  ),
                                ),
                                child: Text(
                                  "로그인",
                                  style: TextStyle(
                                    fontSize: context.regularFont,
                                    color:
                                        loginState.isIdValid &&
                                                loginState.isPasswordValid
                                            ? Colors.black
                                            : Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: context.height(0.08)),
                            // SNS 로그인
                            Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    const Expanded(child: Divider()),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0,
                                      ),
                                      child: Text(
                                        "소셜 계정으로 간편 로그인",
                                        style: TextStyle(
                                          fontSize: context.width(0.035),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    const Expanded(child: Divider()),
                                  ],
                                ),
                                SizedBox(height: context.height(0.025)),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    if (Platform.isIOS)
                                      ElevatedButton(
                                        onPressed:
                                            () => loginNotifier.signInWithApple(
                                              context,
                                            ),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.white,
                                          foregroundColor: Colors.black,
                                          elevation: 0,
                                          shape: const CircleBorder(),
                                          padding: EdgeInsets.zero,
                                          minimumSize: Size.fromRadius(
                                            context.height(0.025),
                                          ),
                                        ),
                                        child: ClipOval(
                                          child: Image.asset(
                                            Theme.of(context).brightness ==
                                                    Brightness.dark
                                                ? 'assets/images/login/apple_login_dark.png'
                                                : 'assets/images/login/apple_login_light.png',
                                            fit: BoxFit.cover,
                                            scale: context.height(0.006),
                                          ),
                                        ),
                                      ),
                                    if (Platform.isIOS)
                                      SizedBox(width: context.height(0.025)),
                                    ElevatedButton(
                                      onPressed:
                                          () => loginNotifier.signInWithKakao(
                                            context,
                                          ),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        foregroundColor: Colors.black,
                                        elevation: 0,
                                        shape: const CircleBorder(),
                                        padding: EdgeInsets.zero,
                                        minimumSize: Size.fromRadius(
                                          context.height(0.025),
                                        ),
                                      ),
                                      child: ClipOval(
                                        child: Image.asset(
                                          'assets/images/login/kakao_login.png',
                                          fit: BoxFit.cover,
                                          scale: context.height(0.006),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            if (loginState.isLoading) overlayView(),
          ],
        ),
      ),
    );
  }
}
