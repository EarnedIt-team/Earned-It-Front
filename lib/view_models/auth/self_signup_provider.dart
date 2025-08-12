import 'dart:async';
import 'package:earned_it/config/exception.dart';
import 'package:earned_it/models/signup/self_signup_state.dart';
import 'package:earned_it/services/auth/signup_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:toastification/toastification.dart';
import 'package:url_launcher/url_launcher.dart';

final signUpViewModelProvider =
    NotifierProvider.autoDispose<SignUpViewModel, SelfSignupState>(
      SignUpViewModel.new,
    );

class SignUpViewModel extends AutoDisposeNotifier<SelfSignupState> {
  Timer? _codeTimer;
  final RegExp emailRegExp = RegExp(r'^[a-zA-Z0-9@.]+$');
  final RegExp passwordRegExp = RegExp(
    r'^(?=.*[A-Z])(?=.*[!@#$%^&*()_+={}\[\]|;:"<>,.?/~`])(?=.*\d)[a-zA-Z\d!@#$%^&*()_+={}\[\]|;:"<>,.?/~`]{8,12}$',
  );

  late final TextEditingController _emailController;
  late final TextEditingController _agreeCodeController;
  late final TextEditingController _passwordController;
  late final TextEditingController _checkPasswordController;
  late final SignUpService _signUpService;

  TextEditingController get emailController => _emailController;
  TextEditingController get agreeCodeController => _agreeCodeController;
  TextEditingController get passwordController => _passwordController;
  TextEditingController get checkPasswordController => _checkPasswordController;

  @override
  SelfSignupState build() {
    _signUpService = ref.read(signUpServiceProvider);
    _emailController = TextEditingController();
    _agreeCodeController = TextEditingController();
    _passwordController = TextEditingController();
    _checkPasswordController = TextEditingController();

    ref.onDispose(() {
      _emailController.dispose();
      _agreeCodeController.dispose();
      _passwordController.dispose();
      _checkPasswordController.dispose();
      _codeTimer?.cancel();
    });

    return const SelfSignupState();
  }

  String get timerText {
    int minutes = state.startTime ~/ 60;
    int seconds = state.startTime % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  void onEmailChanged(String value) {
    state = state.copyWith(
      isAvailableID:
          value.isNotEmpty &&
          value.contains("@") &&
          emailRegExp.hasMatch(value),
    );
  }

  Future<void> requestEmail(BuildContext context) async {
    _codeTimer?.cancel();
    FocusScope.of(context).unfocus();
    state = state.copyWith(isProgress: true);

    try {
      await _signUpService.sendEmailAuthCode(_emailController.text);
      state = state.copyWith(isRequestAuth: true, isProgress: false);
      _agreeCodeController.clear();
      startTimer();
      toastification.show(
        context: context,
        title: const Text("해당 이메일로 인증 코드를 전송했습니다."),
      );
    } catch (e) {
      state = state.copyWith(isRequestAuth: false, isProgress: false);
      toastification.show(context: context, title: Text(e.toDisplayString()));
    }
  }

  void onAuthCodeChanged(String value) {
    state = state.copyWith(isAvailableCode: value.isNotEmpty);
  }

  Future<void> verifyAuthCode(BuildContext context) async {
    FocusScope.of(context).unfocus();
    state = state.copyWith(isProgress: true);
    try {
      await _signUpService.verifyEmail(
        _emailController.text,
        _agreeCodeController.text,
      );
      _codeTimer?.cancel();
      state = state.copyWith(isSuccessfulCode: true, isProgress: false);
    } catch (e) {
      state = state.copyWith(isSuccessfulCode: false, isProgress: false);
      toastification.show(context: context, title: Text(e.toDisplayString()));
    }
  }

  void onPasswordChanged(String value) {
    state = state.copyWith(
      isAvailablePassword: value.isNotEmpty && passwordRegExp.hasMatch(value),
    );
    onCheckPasswordChanged(_checkPasswordController.text);
  }

  void onCheckPasswordChanged(String value) {
    state = state.copyWith(isCheckPassword: value == _passwordController.text);
  }

  void toggleObscurePassword() {
    state = state.copyWith(isObscurePassword: !state.isObscurePassword);
  }

  void toggleObscurePasswordCheck() {
    state = state.copyWith(
      isObscurePasswordCheck: !state.isObscurePasswordCheck,
    );
  }

  void onAgreedToTermsChanged(bool? value) {
    state = state.copyWith(isAgreedToTerms: value ?? false);
  }

  Future<void> signUp(BuildContext context) async {
    if (state.isSuccessfulCode &&
        state.isAvailablePassword &&
        state.isCheckPassword &&
        state.isAgreedToTerms) {
      try {
        state = state.copyWith(isProgress: true);
        await _signUpService.signUp(
          _emailController.text,
          _passwordController.text,
        );
        state = state.copyWith(isProgress: false);
        toastification.show(context: context, title: const Text("회원가입 성공!"));
        context.go("/login");
      } catch (e) {
        state = state.copyWith(isProgress: false);
        toastification.show(context: context, title: Text(e.toDisplayString()));
      }
    } else {
      toastification.show(
        context: context,
        title: const Text("모든 필수 항목을 확인해주세요."),
      );
    }
  }

  Future<void> launchTermsUrl() async {
    String urls = dotenv.env['TERMS_URL']!;
    final Uri url = Uri.parse(urls);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  // --- (핵심 수정) 타이머 시작 로직 변경 ---
  void startTimer() {
    _codeTimer?.cancel();
    _agreeCodeController.clear();

    // 1. 15분 후의 정확한 종료 시간을 계산하여 상태에 저장합니다.
    final endTime = DateTime.now().add(const Duration(minutes: 15));
    state = state.copyWith(timerEndTime: endTime);

    // 2. 1초마다 UI를 갱신하기 위한 타이머를 시작합니다.
    _codeTimer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (state.timerEndTime == null) {
        timer.cancel();
        return;
      }
      // 3. 현재 시간과 목표 시간의 차이를 계산하여 남은 시간을 구합니다.
      final remaining = state.timerEndTime!.difference(DateTime.now());

      if (remaining.isNegative) {
        // 시간이 다 되면 타이머를 멈추고 0초로 설정합니다.
        state = state.copyWith(startTime: 0, isSuccessfulCode: false);
        timer.cancel();
      } else {
        // 남은 시간을 초 단위로 상태에 업데이트합니다.
        state = state.copyWith(startTime: remaining.inSeconds);
      }
    });
  }

  void cancelTimer() {
    _codeTimer?.cancel();
  }
}
