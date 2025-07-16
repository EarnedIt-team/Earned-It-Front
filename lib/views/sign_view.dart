import 'package:earned_it/config/design.dart';
import 'package:flutter/material.dart';

class SignView extends StatefulWidget {
  const SignView({super.key});

  @override
  State<SignView> createState() => _SignViewState();
}

class _SignViewState extends State<SignView> {
  bool _isObscurePassword = true; // 비밀번호 가리기
  bool _isRequestAuth = false; // 인증 요청

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // 공백을 터치했을 시, 키보드가 내려감
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
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
            child: Column(
              spacing: context.height(0.03),
              children: <Widget>[
                signTextField("아이디"),
                // _isRequestAuth ? const TextField() : Container(),
                signTextField("비밀번호"),
                signTextField("비밀번호 재확인"),
              ],
            ),
          ),
        ),
        // 회원가입 버튼
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: context.middlePadding),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text("동의하고 회원가입"),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // 회원가입 입력 필드
  Widget signTextField(String type) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(type, style: const TextStyle(fontWeight: FontWeight.bold)),
        type == "아이디"
            // 아이디 입력
            ? TextField(
              decoration: InputDecoration(
                hintText: "ex) email@example.com",
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: context.regularFont,
                ),
                suffixIcon: TextButton(
                  onPressed: () {
                    setState(() {
                      _isRequestAuth = true;
                    });
                  },
                  child: const Text("인증 요청"),
                ),
              ),
            )
            // 비밀번호 입력
            : type == "비밀번호"
            ? TextField(
              obscureText: _isObscurePassword,
              decoration: InputDecoration(
                hintText: "영대문자, 특수문자, 숫자 포함 8~12자",
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: context.regularFont,
                ),
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
            )
            // 비밀번호 재확인 입력
            : TextField(
              obscureText: true, // 재확인은 보여주지 않는게 맞다고 판단
              decoration: InputDecoration(
                hintText: "영대문자, 특수문자, 숫자 포함 8~12자",
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: context.regularFont,
                ),
              ),
            ),
      ],
    );
  }
}
