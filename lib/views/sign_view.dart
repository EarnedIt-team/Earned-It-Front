import 'package:earned_it/config/design.dart';
import 'package:flutter/material.dart';

class SignView extends StatefulWidget {
  const SignView({super.key});

  @override
  State<SignView> createState() => _SignViewState();
}

class _SignViewState extends State<SignView> {
  bool _isAvailableID = false; // 사용가능한 아이디 (이메일)
  bool _isRequestAuth = false; // 이메일 인증 요청 여부
  bool _isAvailableCode = false; // 사용가능한 인증 코드
  bool _isSuccessfulCode = false; // 인증 코드 확인
  bool _isObscurePassword = true; // 비밀번호 숨기기

  final RegExp emailRegExp = RegExp(r'^[a-zA-Z0-9@.]+$'); // 이메일 정규식
  final TextEditingController _emailController =
      TextEditingController(); // 이메일 컨트롤러
  final TextEditingController _agreeCodeController =
      TextEditingController(); // 인증 컨트롤러

  @override
  void dispose() {
    _emailController.dispose();
    _agreeCodeController.dispose();
    super.dispose();
  }

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
                _isRequestAuth
                    ? signTextField("이메일 인증")
                    : const SizedBox.shrink(),
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
              controller: _emailController,
              keyboardType: TextInputType.emailAddress, // 이메일 타입 키보드
              onChanged: (String value) {
                setState(() {
                  if (value.isNotEmpty && value.contains("@")) {
                    _isAvailableID = emailRegExp.hasMatch(value);
                  } else {
                    _isAvailableID = false;
                  }
                });
              },
              decoration: InputDecoration(
                hintText: "ex) email@example.com",
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: context.regularFont,
                ),
                suffixIcon:
                    _emailController.text.isNotEmpty && _isAvailableID
                        ? TextButton(
                          onPressed: () {
                            setState(() {
                              FocusScope.of(context).unfocus(); // 키보드 내리기
                              // _emailController.selection.isCollapsed;

                              // 이메일 인증 관련 초기화
                              _isSuccessfulCode = false;
                              _agreeCodeController.clear();
                              _isAvailableCode = false;

                              // 인증 요청
                              _isRequestAuth = true;
                            });
                          },
                          child: const Text("인증 요청"),
                        )
                        : null,
                errorText:
                    _emailController.text.isNotEmpty && !_isAvailableID
                        ? '유효하지 않은 이메일 형식입니다.'
                        : null,
              ),
            )
            // 이메일 인증
            : type == "이메일 인증"
            ? TextField(
              controller: _agreeCodeController,
              keyboardType: TextInputType.number, // 넘버 타입 키패드 (인증 코드 - 숫자)
              obscureText: _isObscurePassword,
              onChanged: (String value) {
                setState(() {
                  if (value.isNotEmpty) {
                    _isAvailableCode = true;
                  } else {
                    _isAvailableCode = false;
                  }
                });
              },
              decoration: InputDecoration(
                hintText: "전송된 인증코드를 입력해주세요.",
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: context.regularFont,
                ),
                helper:
                    _isSuccessfulCode
                        ? Row(
                          spacing: context.width(0.01),
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Icon(Icons.check, color: context.successColor),
                            Text(
                              "이메일 인증이 완료되었습니다.",
                              style: TextStyle(color: context.successColor),
                            ),
                          ],
                        )
                        : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            // 인증 타이머
                            Row(
                              spacing: context.width(0.015),
                              children: const <Widget>[
                                Icon(Icons.timer_sharp),
                                Text("14:59"),
                              ],
                            ),
                            // 재전송 & 코드 확인 버튼
                            Row(
                              spacing: context.width(0.015),
                              children: <Widget>[
                                TextButton(
                                  onPressed: () {},
                                  child: const Text("재전송"),
                                ),
                                TextButton(
                                  onPressed:
                                      _isAvailableCode
                                          ? () {
                                            setState(() {
                                              FocusScope.of(
                                                context,
                                              ).unfocus(); // 키보드 내리기

                                              _isSuccessfulCode = true;
                                            });
                                          }
                                          : null,
                                  child: const Text("코드 확인"),
                                ),
                              ],
                            ),
                          ],
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
