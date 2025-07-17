import 'dart:async';

import 'package:earned_it/config/design.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SignView extends StatefulWidget {
  const SignView({super.key});

  @override
  State<SignView> createState() => _SignViewState();
}

class _SignViewState extends State<SignView> {
  bool _isAvailableID = false; // 사용가능한 아이디 (이메일)
  bool _isRequestAuth = false; // 이메일 인증 요청 여부
  bool _isAvailableCode = false; // 인증 코드 (유효성)
  bool _isSuccessfulCode = false; // 인증 코드 통과 여부
  bool _isObscurePassword = true; // 비밀번호 숨기기
  bool _isAvailablePassword = false; // 사용가능한 비밀 번호
  bool _isChechPassword = false; // 비밀번호 재확인 여부
  bool _isAgreedToTerms = false; // 서비스 이용 약관 동의 여부

  Timer? _codeTimer; // 인증 코드 타이머
  int startTime = 900; // 시작 시간 (15분)

  String get timerText {
    int minutes = startTime ~/ 60; // 분 계산
    int seconds = startTime % 60; // 초 계산
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  final RegExp emailRegExp = RegExp(r'^[a-zA-Z0-9@.]+$'); // 이메일 정규식
  final RegExp passwordRegExp = RegExp(
    r'^(?=.*[A-Z])(?=.*[!@#$%^&*()_+={}\[\]|;:"<>,.?/~`])(?=.*\d)[a-zA-Z\d!@#$%^&*()_+={}\[\]|;:"<>,.?/~`]{8,12}$',
  ); // 비밀번호 정규식
  final TextEditingController _emailController =
      TextEditingController(); // 이메일 컨트롤러
  final TextEditingController _agreeCodeController =
      TextEditingController(); // 인증 컨트롤러
  final TextEditingController _passwordController =
      TextEditingController(); // 비밀번호 컨트롤러
  final TextEditingController _checkPasswordController =
      TextEditingController(); // 비밀번호 재확인 컨트롤러

  // 인증 코드 타이머 시작
  void startTimer() {
    setState(() {
      startTime = 900; // 타이머 15분 재설정
    });

    _codeTimer?.cancel(); // 기존에 실행 중인 타이머 취소 (중복 실행 방지)

    _codeTimer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (startTime == 0) {
        // 타이머가 0초가 되면
        setState(() {
          timer.cancel(); // 타이머 중지
        });
      } else {
        setState(() {
          startTime--; // 1초씩 감소
        });
      }
    });
  }

  // 인증 코드 타이머 중지
  void cancelTimer() {
    if (_codeTimer != null) {
      _codeTimer!.cancel(); // 타이머 중지
    }
  }

  // 사용자 약관 동의 web
  Future<void> _launchUrl() async {
    final Uri url = Uri.parse('https://github.com/EarnedIt-team');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _agreeCodeController.dispose();
    _codeTimer?.cancel();
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
            padding: EdgeInsets.only(
              // 스크롤이 되었을 때, 하단의 여백을 주기 위함
              bottom:
                  MediaQuery.of(context).padding.bottom + context.height(0.15),
            ),
            child: Column(
              spacing: context.height(0.03),
              children: <Widget>[
                signTextField("아이디"),
                // 인증 요청시,
                _isRequestAuth
                    ? signTextField("이메일 인증")
                    : const SizedBox.shrink(),
                signTextField("비밀번호"),
                signTextField("비밀번호 재확인"),
                Row(
                  children: <Widget>[
                    Checkbox(
                      value: _isAgreedToTerms,
                      onChanged: (bool? value) {
                        setState(() {
                          _isAgreedToTerms = value ?? false;
                        });
                      },
                    ),
                    // 서비스 이용 약관 체크
                    Text.rich(
                      TextSpan(
                        children: <InlineSpan>[
                          TextSpan(
                            text: "서비스 이용 약관",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              decoration: TextDecoration.underline, // 밑줄 추가
                              decorationColor: Colors.grey,
                              height: 1.5,
                            ),
                            recognizer:
                                TapGestureRecognizer()
                                  ..onTap = () {
                                    _launchUrl(); // 사용자 약관 동의 web
                                  },
                          ),
                          const TextSpan(
                            text: "에 동의합니다.",
                            style: TextStyle(
                              color: Colors.black, // 일반 텍스트 색상
                            ),
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
            padding: EdgeInsets.symmetric(horizontal: context.middlePadding),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed:
                    _isSuccessfulCode &&
                            _isAvailablePassword &&
                            _isChechPassword &&
                            _isAgreedToTerms
                        ? () {}
                        : null,
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

                              // 이메일 인증 관련 초기화
                              _isSuccessfulCode = false;
                              _agreeCodeController.clear();
                              _isAvailableCode = false;

                              _isRequestAuth = true; // 인증 요청

                              startTimer(); // 타이머 시작
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
              readOnly: _isSuccessfulCode, // 인증 성공시, 읽기모드 전환 (입력 비활성화)
              controller: _agreeCodeController,
              keyboardType: TextInputType.number, // 넘버 타입 키패드 (인증 코드 - 숫자)
              // 인증 코드 입력시,
              onChanged: (String value) {
                setState(() {
                  if (value.isNotEmpty) {
                    _isAvailableCode = true; // 코드 확인 버튼 활성화
                  } else {
                    _isAvailableCode = false; // 코드 확인 버튼 비활성화
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
                              children: <Widget>[
                                const Icon(
                                  Icons.timer_sharp,
                                  color: Colors.red,
                                ),
                                Text(
                                  timerText,
                                  style: const TextStyle(color: Colors.red),
                                ),
                              ],
                            ),
                            // 재전송 & 코드 확인 버튼
                            Row(
                              spacing: context.width(0.015),
                              children: <Widget>[
                                TextButton(
                                  onPressed:
                                      startTime <= 895
                                          ? () {
                                            startTimer(); // 타이머 시작

                                            _isAvailableCode =
                                                false; // 인증 코드 (유효성) 초기화

                                            _agreeCodeController
                                                .clear(); // 인증 코드 비우기
                                          }
                                          : null,
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

                                              _isSuccessfulCode =
                                                  true; // 인증 코드 통과 여부 초기화

                                              _codeTimer?.cancel(); // 타이머 취소
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
              controller: _passwordController,
              obscureText: _isObscurePassword,
              onChanged: (String value) {
                setState(() {
                  if (value.isNotEmpty) {
                    _isAvailablePassword = passwordRegExp.hasMatch(value);
                  } else {
                    _isAvailablePassword = false;
                  }
                });
              },
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
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                ),
                helper:
                    _isAvailablePassword
                        ? Row(
                          spacing: context.width(0.01),
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Icon(Icons.check, color: context.successColor),
                            Text(
                              "사용가능한 비밀번호입니다.",
                              style: TextStyle(color: context.successColor),
                            ),
                          ],
                        )
                        : null,
                errorText:
                    _passwordController.text.isNotEmpty && !_isAvailablePassword
                        ? '사용할 수 없는 비밀번호 입니다.'
                        : null,
              ),
            )
            // 비밀번호 재확인 입력
            : TextField(
              controller: _checkPasswordController,
              obscureText: true, // 재확인은 보여주지 않는게 맞다고 판단
              onChanged: (String value) {
                setState(() {
                  if (value == _passwordController.text) {
                    _isChechPassword = true;
                  } else {
                    _isChechPassword = false;
                  }
                });
              },
              decoration: InputDecoration(
                hintText: "영대문자, 특수문자, 숫자 포함 8~12자",
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: context.regularFont,
                ),
                helper:
                    _isChechPassword
                        ? Row(
                          spacing: context.width(0.01),
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Icon(Icons.check, color: context.successColor),
                            Text(
                              "비밀번호가 일치합니다.",
                              style: TextStyle(color: context.successColor),
                            ),
                          ],
                        )
                        : null,
                errorText:
                    _checkPasswordController.text.isNotEmpty &&
                            (_checkPasswordController.text !=
                                _passwordController.text)
                        ? "비밀번호가 다릅니다."
                        : null,
              ),
            ),
      ],
    );
  }
}
