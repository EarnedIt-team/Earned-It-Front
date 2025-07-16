import 'package:earned_it/config/design.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  final TextEditingController _idTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  bool _isObscurePassword = true;

  @override
  void dispose() {
    _idTextController.dispose();
    _passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // 공백을 터치했을 시, 키보드가 내려감
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                // 전체 화면 크기에서, 노치/상단바를 제외한 값
                minHeight:
                    MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top,
              ),
              // 자식의 최소 높이 고정
              child: IntrinsicHeight(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(context.loginPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // 앱 타이틀
                        Text(
                          "Earned !t",
                          style: TextStyle(
                            fontSize: context.middleFont,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: context.height(0.07)),

                        // 아이디, 비밀번호 입력
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            // 아이디
                            TextField(
                              controller: _idTextController,
                              decoration: const InputDecoration(
                                labelText: "아이디",
                              ),
                            ),
                            // 비밀번호
                            TextField(
                              controller: _passwordTextController,
                              obscureText: _isObscurePassword,
                              decoration: InputDecoration(
                                labelText: "비밀번호",
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _isObscurePassword = !_isObscurePassword;
                                    });
                                  },
                                  icon: Icon(
                                    _isObscurePassword
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                ),
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

                        // 로그인 버튼
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {},
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

                        // 소셜 로그인
                        Column(
                          spacing: context.height(0.015),
                          children: [
                            Row(
                              children: [
                                const Expanded(child: Divider()),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0,
                                  ),
                                  child: Text(
                                    "소셜 계정으로 간편하게 로그인",
                                    style: TextStyle(
                                      fontSize: context.smallFont,
                                    ),
                                  ),
                                ),
                                const Expanded(child: Divider()),
                              ],
                            ),
                            Row(
                              spacing: context.height(0.015),
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  onPressed: () {},
                                  child: const Text("애플"),
                                ),
                                ElevatedButton(
                                  onPressed: () {},
                                  child: const Text("카카오"),
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
      ),
    );
  }
}
