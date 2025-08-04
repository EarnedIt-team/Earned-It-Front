import 'package:earned_it/config/exception.dart';
import 'package:earned_it/models/login/login_state.dart';
import 'package:earned_it/services/auth/apple_login_service.dart';
import 'package:earned_it/services/auth/kakao_login_service.dart';
import 'package:earned_it/services/auth/login_service.dart';
import 'package:earned_it/view_models/user_provider.dart';
import 'package:earned_it/views/auth/agreement_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:toastification/toastification.dart';

final loginViewModelProvider = NotifierProvider<LoginViewModel, LoginState>(
  LoginViewModel.new,
);

class LoginViewModel extends Notifier<LoginState> {
  late final TextEditingController _idTextController;
  late final TextEditingController _passwordTextController;
  late final LoginService _loginService;
  final _storage = const FlutterSecureStorage();

  TextEditingController get idTextController => _idTextController;
  TextEditingController get passwordTextController => _passwordTextController;
  bool get isLoginButtonEnabled =>
      _idTextController.text.isNotEmpty &&
      _passwordTextController.text.isNotEmpty;

  @override
  LoginState build() {
    _loginService = ref.read(loginServiceProvider);
    _idTextController = TextEditingController();
    _passwordTextController = TextEditingController();

    _idTextController.addListener(_updateLoginButtonState);
    _passwordTextController.addListener(_updateLoginButtonState);

    ref.onDispose(() {
      _idTextController.removeListener(_updateLoginButtonState);
      _passwordTextController.removeListener(_updateLoginButtonState);
      _idTextController.dispose();
      _passwordTextController.dispose();
    });

    return const LoginState();
  }

  void _updateLoginButtonState() {
    state = state.copyWith(
      isIdValid: _idTextController.text.isNotEmpty,
      isPasswordValid: _passwordTextController.text.isNotEmpty,
    );
  }

  void toggleObscurePassword() {
    state = state.copyWith(isObscurePassword: !state.isObscurePassword);
  }

  // Public Login Methods
  Future<void> login(BuildContext context) async {
    await _executeLogin(
      context,
      loginFunction:
          () => _loginService.selfLogin(
            _idTextController.text,
            _passwordTextController.text,
          ),
    );
  }

  Future<void> signInWithApple(BuildContext context) async {
    await _executeLogin(
      context,
      loginFunction: () => ref.read(appleloginServiceProvider).login(),
      errorTitle: "애플 로그인 실패",
      isSocialLogin: true,
    );
  }

  Future<void> signInWithKakao(BuildContext context) async {
    await _executeLogin(
      context,
      loginFunction: () => ref.read(kakaologinServiceProvider).login(),
      errorTitle: "카카오 로그인 실패",
      isSocialLogin: true,
    );
  }

  Future<void> autoLogin(BuildContext context, String token) async {
    try {
      final response = await _loginService.checkToken(token);
      await _saveTokens(
        accessToken: response.data['accessToken'] as String,
        refreshToken: response.data['refreshToken'] as String,
      );

      // 👇 1. 자동 로그인 성공 시 유저 정보 불러오기 + 하이라이트
      await ref.read(userProvider.notifier).loadUser();
      await ref.read(userProvider.notifier).loadHighLightWish();

      if (context.mounted) context.go("/home");
    } catch (e) {
      await _clearLoginData();
      if (context.mounted) {
        context.go('/login');
        _handleLoginFailure(context, e);
      }
    }
  }

  // Private Helper Methods
  Future<void> _executeLogin(
    BuildContext context, {
    required Future<dynamic> Function() loginFunction,
    String? errorTitle,
    bool isSocialLogin = false,
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final response = await loginFunction();
      final data = response.data as Map<String, dynamic>;

      final bool hasAgreed =
          data.containsKey('hasAgreedTerm')
              ? data['hasAgreedTerm'] as bool
              : true;

      if (isSocialLogin && !hasAgreed) {
        if (context.mounted) {
          await _promptAgreementAndFinalize(context, data);
        }
      } else {
        await _handleLoginSuccess(context, data);
      }
    } catch (e) {
      _handleLoginFailure(context, e, title: errorTitle);
    } finally {
      // 로딩 상태를 항상 false로 되돌려놓습니다.
      if (context.mounted) {
        state = state.copyWith(isLoading: false);
      }
    }
  }

  Future<void> _promptAgreementAndFinalize(
    BuildContext context,
    Map<String, dynamic> data,
  ) async {
    // agreementModal이 null을 반환할 수 있으므로 bool?로 타입을 명시합니다.
    final bool? agreed = await agreementModal(
      context,
      data['accessToken'] as String,
    );

    if (agreed == true && context.mounted) {
      await _handleLoginSuccess(context, data);
    }
  }

  Future<void> _handleLoginSuccess(
    BuildContext context,
    Map<String, dynamic> data,
  ) async {
    await _saveLoginData(
      accessToken: data['accessToken'] as String,
      refreshToken: data['refreshToken'] as String,
      userId: (data['userId'] as int).toString(),
    );

    // 👇 2. 자체/소셜 로그인 성공 시 유저 정보 불러오기 + 하이라이트 정보
    await ref.read(userProvider.notifier).loadUser();
    await ref.read(userProvider.notifier).loadHighLightWish();

    if (context.mounted) context.go('/home');
  }

  void _handleLoginFailure(BuildContext context, Object e, {String? title}) {
    if (context.mounted) {
      toastification.show(
        alignment: Alignment.topCenter,
        style: ToastificationStyle.simple,
        context: context,
        title: Text(title ?? e.toDisplayString()),
        autoCloseDuration: const Duration(seconds: 3),
      );
    }
  }

  Future<void> _saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    await _storage.write(key: 'accessToken', value: accessToken);
    await _storage.write(key: 'refreshToken', value: refreshToken);
  }

  Future<void> _saveLoginData({
    required String accessToken,
    required String refreshToken,
    required String userId,
  }) async {
    await _saveTokens(accessToken: accessToken, refreshToken: refreshToken);
    await _storage.write(key: 'userId', value: userId);
  }

  Future<void> _clearLoginData() async {
    await _storage.delete(key: 'accessToken');
    await _storage.delete(key: 'refreshToken');
    await _storage.delete(key: 'userId');
  }
}
