import 'package:dio/dio.dart';
import 'package:earned_it/config/exception.dart';
import 'package:earned_it/models/setting/set_salary_state.dart';
import 'package:earned_it/services/auth/login_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:earned_it/services/setting_service.dart';
import 'package:toastification/toastification.dart';

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

    // 컨트롤러 초기화 (여기서는 아직 state의 초기값이 사용되지 않음)
    _salaryController = TextEditingController();
    _paydayController = TextEditingController();

    // Notifier가 dispose될 때 컨트롤러도 함께 dispose
    ref.onDispose(() {
      _salaryController.dispose();
      _paydayController.dispose();
    });

    // 컨트롤러 리스너 설정
    _salaryController.addListener(_onSalaryControllerChanged);

    // 초기 상태 반환.
    final initialState = const SetSalaryState();

    // 초기 상태를 컨트롤러에 반영 (state가 초기화된 후)
    _updateControllersFromState(initialState);

    // 초기 버튼 상태 설정 (initialState를 기반으로)
    _updateButtonState(initialState);

    return initialState;
  }

  // _salaryController의 text 변화를 감지하는 리스너
  void _onSalaryControllerChanged() {
    _formatSalaryInput(); // 월 급여 포맷팅
    _updateButtonState(state); // 버튼 활성화 상태 업데이트
  }

  // ViewModel의 상태를 기반으로 컨트롤러 텍스트를 업데이트하는 내부 도우미 함수
  void _updateControllersFromState(SetSalaryState currentState) {
    if (_salaryController.text != currentState.salaryText) {
      _salaryController.value = TextEditingValue(
        text: currentState.salaryText,
        selection: TextSelection.collapsed(
          offset:
              currentState.salaryText.length -
              (currentState.salaryText.endsWith('원') ? 1 : 0),
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
    String text = _salaryController.text;
    if (text.isEmpty) {
      if (state.salaryText.isNotEmpty) {
        state = state.copyWith(salaryText: '');
      }
      return;
    }

    String cleanText = text
        .replaceAll('원', '')
        .replaceAll(RegExp(r'[^0-9]'), '');
    if (cleanText.isEmpty) {
      if (state.salaryText.isNotEmpty) {
        state = state.copyWith(salaryText: '');
      }
      return;
    }

    int? value = int.tryParse(cleanText);

    String formattedText;
    if (value != null) {
      formattedText = '${_numberFormat.format(value)}원';
    } else {
      formattedText = '';
    }

    // 컨트롤러 텍스트를 직접 업데이트할 때 무한 루프 방지
    if (_salaryController.text != formattedText) {
      _salaryController.value = TextEditingValue(
        text: formattedText,
        selection: TextSelection.collapsed(
          offset: formattedText.length - (formattedText.endsWith('원') ? 1 : 0),
        ),
      );
    }
    // 상태 업데이트: TextField의 텍스트가 ViewModel의 상태가 됩니다.
    // 불필요한 state 업데이트 방지
    if (state.salaryText != _salaryController.text) {
      state = state.copyWith(salaryText: _salaryController.text);
    }
  }

  // 월급날짜 업데이트
  void updateSelectedDay(int day) {
    state = state.copyWith(selectedDay: day);
    // 상태가 업데이트되면 컨트롤러 텍스트도 업데이트
    _updateControllersFromState(state);
    _updateButtonState(state); // 상태 업데이트 후 버튼 활성화 상태 갱신
  }

  // 버튼 활성화 상태 업데이트 (내부 로직)
  void _updateButtonState(SetSalaryState currentState) {
    final String cleanSalaryText = _salaryController.text
        .replaceAll('원', '')
        .replaceAll(RegExp(r'[^0-9]'), '');
    final bool isEnabled =
        cleanSalaryText.isNotEmpty && currentState.selectedDay > 0;
    if (currentState.isButtonEnabled != isEnabled) {
      state = currentState.copyWith(isButtonEnabled: isEnabled);
    }
  }

  // 설정 완료 버튼 클릭 로직
  Future<void> completeSetup(BuildContext context) async {
    // 로딩 상태 시작 및 에러 메시지 초기화
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

      // 월 급여 설정 API
      final response = await _settingService.setSalary(
        userId!,
        "Bearer $accessToken",
        salaryAmount!,
        paydayDay,
      );

      print('월 급여 설정 완료: ${response.data}');
      state = state.copyWith(isLoading: false, errorMessage: '');

      toastification.show(
        alignment: Alignment.topCenter,
        style: ToastificationStyle.simple,
        context: context,
        title: Text("초당 수익 : ${response.data['amountPerSec']}"),
        autoCloseDuration: const Duration(seconds: 3),
      );

      context.pop();
    } on DioException catch (e) {
      state = state.copyWith(isLoading: false); // 로딩 상태 해제

      if (e.response?.data['code'] == "AUTH_REQUIRED") {
        print("토큰이 만료되어 재발급합니다.");
        final String? refreshToken = await _storage.read(key: 'refreshToken');
        try {
          await _loginService.checkToken(refreshToken!);
          toastification.show(
            alignment: Alignment.topCenter,
            style: ToastificationStyle.simple,
            context: context,
            title: const Text("잠시 후, 다시 시도해주세요."),
            autoCloseDuration: const Duration(seconds: 3),
          );
        } catch (e) {
          context.go('/login');
          toastification.show(
            alignment: Alignment.topCenter,
            style: ToastificationStyle.simple,
            context: context,
            title: const Text("다시 로그인해주세요."),
            autoCloseDuration: const Duration(seconds: 3),
          );
        }
      }
    } catch (e) {
      print('월 급여 설정 중 에러 발생: $e');
      state = state.copyWith(isLoading: false);
      toastification.show(
        alignment: Alignment.topCenter,
        style: ToastificationStyle.simple,
        context: context,
        title: Text(e.toDisplayString()),
        autoCloseDuration: const Duration(seconds: 3),
      );
    }
  }
}
