import 'dart:io';

import 'package:earned_it/config/design.dart';
import 'package:earned_it/view_models/login_provider.dart'; // import 경로 확인
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
          children: [
            SafeArea(
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight:
                        MediaQuery.of(context).size.height -
                        MediaQuery.of(context).padding.top,
                  ),
                  child: IntrinsicHeight(
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.all(context.loginPadding),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            // 메인 로고
                            Text(
                              "Earned !t",
                              style: TextStyle(
                                fontSize: context.middleFont,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: context.height(0.07)),
                            // 아이디 & 비밀번호
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                TextField(
                                  controller: loginNotifier.idTextController,
                                  decoration: const InputDecoration(
                                    labelText: "아이디",
                                  ),
                                ),
                                TextField(
                                  controller:
                                      loginNotifier.passwordTextController,
                                  obscureText: loginState.isObscurePassword,
                                  decoration: InputDecoration(
                                    labelText: "비밀번호",
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
                                // 에러 메시지
                                if (loginState.errorMessage != null)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Text(
                                      loginState.errorMessage!,
                                      style: const TextStyle(color: Colors.red),
                                    ),
                                  ),
                                // 비밀번호 찾기
                                TextButton(
                                  onPressed: () {
                                    context.push("/forgot_password");
                                  },
                                  child: const Text("비밀번호 찾기"),
                                ),
                              ],
                            ),
                            SizedBox(height: context.height(0.02)),
                            // 로그인
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed:
                                    loginState.isIdValid &&
                                            loginState.isPasswordValid
                                        ? () => loginNotifier.login(context)
                                        : null,
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(
                                    vertical: context.buttonPadding,
                                  ),
                                  textStyle: TextStyle(
                                    fontSize: context.regularFont,
                                  ),
                                ),
                                child: const Text("로그인"),
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
                                        "소셜 계정으로 간편하게 로그인",
                                        style: TextStyle(
                                          fontSize: context.smallFont,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    const Expanded(child: Divider()),
                                  ],
                                ),
                                SizedBox(height: context.height(0.025)),
                                // apple, kakao button
                                Row(
                                  spacing: context.height(0.025),
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    // apple button
                                    // 25.07.21 애플 로그인은 IOS 한정
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
                                            'assets/images/apple_login_light.png',
                                            fit: BoxFit.cover,
                                            scale: context.height(0.006),
                                          ),
                                        ),
                                      ),
                                    // kakao button
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
                                          'assets/images/kakao_login.png',
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

            // 로딩 오버레이 (로그인 시도)
            if (loginState.isLoading) // isLoading이 true일 때만 표시
              Positioned.fill(
                child: Container(
                  color: Colors.black.withValues(alpha: 0.5), // 불투명도 50% 검은색 배경
                  child: const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
