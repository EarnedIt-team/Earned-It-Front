import 'package:dio/dio.dart';
import 'package:earned_it/config/exception.dart';
import 'package:earned_it/config/toastMessage.dart';
import 'package:earned_it/models/setting/set_salary_state.dart';
import 'package:earned_it/services/auth/login_service.dart';
import 'package:earned_it/view_models/user_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:earned_it/services/setting_service.dart';

// NotifierProvider.autoDispose 정의
final setSalaryViewModelProvider =
    NotifierProvider.autoDispose<SetSalaryViewModel, SetSalaryState>(
      SetSalaryViewModel.new,
    );

class SetSalaryViewModel extends AutoDisposeNotifier<SetSalaryState> {
  // 컨트롤러 Notifier 내부 관리
  late final TextEditingController _salaryController;
  late final TextEditingController _paydayController;

  // 서비스 인스턴스
  late final LoginService _loginService;
  late final SettingService _settingService;
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  // 입력 컨트롤러 Getter (UI에서 사용)
  TextEditingController get salaryController => _salaryController;
  TextEditingController get paydayController => _paydayController;

  final NumberFormat _numberFormat = NumberFormat('#,###', 'ko_KR');

  @override
  SetSalaryState build() {
    _loginService = ref.read(loginServiceProvider);
    _settingService = ref.read(settingServiceProvider);

    _salaryController = TextEditingController();
    _paydayController = TextEditingController();

    ref.onDispose(() {
      _salaryController.dispose();
      _paydayController.dispose();
    });

    _salaryController.addListener(_onSalaryControllerChanged);

    final initialState = const SetSalaryState();
    _updateControllersFromState(initialState);
    return initialState;
  }

  void _onSalaryControllerChanged() {
    _formatSalaryInput();
    _validateSalary();
    _updateButtonState();
  }

  void _validateSalary() {
    final cleanText = _salaryController.text.replaceAll(RegExp(r'[^0-9]'), '');
    if (cleanText.isEmpty) {
      state = state.copyWith(salaryErrorText: null);
      return;
    }
    final value = int.tryParse(cleanText) ?? 0;
    if (value < 1000) {
      state = state.copyWith(salaryErrorText: "최소 1000원 이상부터 작성 가능합니다.");
    } else {
      state = state.copyWith(salaryErrorText: null);
    }
  }

  void _updateControllersFromState(SetSalaryState currentState) {
    if (_salaryController.text != currentState.salaryText) {
      _salaryController.value = TextEditingValue(
        text: currentState.salaryText,
        selection: TextSelection.collapsed(
          offset: currentState.salaryText.length,
        ),
      );
    }
    final String paydayDisplayText =
        currentState.selectedDay > 0 ? '매 달 ${currentState.selectedDay}일' : '';
    if (_paydayController.text != paydayDisplayText) {
      _paydayController.text = paydayDisplayText;
    }
  }

  void _formatSalaryInput() {
    final text = _salaryController.text;
    final selection = _salaryController.selection;
    String cleanText = text.replaceAll(RegExp(r'[^0-9]'), '');
    if (cleanText.isEmpty) {
      if (state.salaryText.isNotEmpty) {
        state = state.copyWith(salaryText: '');
      }
      return;
    }
    int? value = int.tryParse(cleanText);
    String formattedText = value != null ? _numberFormat.format(value) : '';
    if (state.salaryText != formattedText) {
      state = state.copyWith(salaryText: formattedText);
    }
    if (_salaryController.text != formattedText) {
      final int newOffset =
          selection.baseOffset + (formattedText.length - text.length);
      _salaryController.value = TextEditingValue(
        text: formattedText,
        selection: TextSelection.collapsed(
          offset: newOffset.clamp(0, formattedText.length),
        ),
      );
    }
  }

  void updateSelectedDay(int day) {
    state = state.copyWith(selectedDay: day);
    _updateControllersFromState(state);
    _updateButtonState();
  }

  void _updateButtonState() {
    final String cleanSalaryText = _salaryController.text.replaceAll(
      RegExp(r'[^0-9]'),
      '',
    );
    final bool isEnabled =
        cleanSalaryText.isNotEmpty &&
        state.selectedDay > 0 &&
        state.salaryErrorText == null;
    if (state.isButtonEnabled != isEnabled) {
      state = state.copyWith(isButtonEnabled: isEnabled);
    }
  }

  // 설정 완료 버튼 클릭 로직
  Future<void> completeSetup(BuildContext context) async {
    state = state.copyWith(isLoading: true, errorMessage: '');
    final String rawSalary = _salaryController.text.replaceAll(
      RegExp(r'[^0-9]'),
      '',
    );
    final int? salaryAmount = int.tryParse(rawSalary);
    final int paydayDay = state.selectedDay;

    try {
      final String? accessToken = await _storage.read(key: 'accessToken');
      final String? userId = await _storage.read(key: 'userId');

      final response = await _settingService.setSalary(
        userId!,
        "Bearer $accessToken",
        salaryAmount!,
        paydayDay,
      );

      print('월 급여 설정 완료: ${response.data}');
      state = state.copyWith(isLoading: false, errorMessage: '');

      // 👇 (핵심 수정) response.data에서 값을 안전하게 추출합니다.
      final int newAmount = response.data['amount'] as int? ?? 0;
      final int newPayday = response.data['payday'] as int? ?? 1;
      final double newAmountPerSec =
          response.data['amountPerSec'] as double? ?? 0.0;

      // 안전하게 추출한 값으로 유저 정보를 업데이트합니다.
      ref
          .read(userProvider.notifier)
          .updateSalaryInfo(
            newMonthlySalary: newAmount,
            newPayday: newPayday,
            newEarningsPerSecond: newAmountPerSec,
          );

      toastMessage(context, '월 수익이 설정되었습니다.');

      context.pop();
    } on DioException catch (e) {
      if (context.mounted) _handleApiError(context, e);
    } catch (e) {
      print('월 급여 설정 중 에러 발생: $e');
      // if (context.mounted) _handleGeneralError(context, e);
    }
  }

  Future<void> _handleApiError(BuildContext context, DioException e) async {
    state = state.copyWith(isLoading: false);
    if (e.response?.data['code'] == "AUTH_REQUIRED") {
      print("토큰이 만료되어 재발급합니다.");
      final String? refreshToken = await _storage.read(key: 'refreshToken');
      try {
        await _loginService.checkToken(refreshToken!);
        toastMessage(
          context,
          '잠시 후, 다시 시도해주세요.',
          type: ToastmessageType.errorType,
        );
      } catch (e) {
        context.go('/login');
        toastMessage(context, '다시 로그인해주세요.', type: ToastmessageType.errorType);
      }
    } else {
      _handleGeneralError(context, e);
    }
  }

  void _handleGeneralError(BuildContext context, Object e) {
    state = state.copyWith(isLoading: false);
    toastMessage(
      context,
      e.toDisplayString(),
      type: ToastmessageType.errorType,
    );
  }
}
