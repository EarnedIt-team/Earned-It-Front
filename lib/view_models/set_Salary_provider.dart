import 'package:dio/dio.dart';
import 'package:earned_it/config/exception.dart';
import 'package:earned_it/models/setting/set_salary_state.dart';
import 'package:earned_it/services/auth/login_service.dart';
import 'package:earned_it/view_models/user_provider.dart';
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

    // 컨트롤러 초기화
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

    // 초기 상태를 컨트롤러에 반영
    _updateControllersFromState(initialState);

    return initialState;
  }

  // _salaryController의 text 변화를 감지하는 리스너
  void _onSalaryControllerChanged() {
    _formatSalaryInput(); // 월 급여 포맷팅
    _validateSalary(); // 유효성 검사 함수 호출
    _updateButtonState();
  }

  // 월급 유효성 검사 로직 추가
  void _validateSalary() {
    final cleanText = _salaryController.text.replaceAll(RegExp(r'[^0-9]'), '');

    if (cleanText.isEmpty) {
      // 텍스트가 비어있으면 에러 없음
      state = state.copyWith(salaryErrorText: null);
      return;
    }

    final value = int.tryParse(cleanText) ?? 0;

    if (value < 1000) {
      // 입력값이 0이면 에러 메시지 설정
      state = state.copyWith(salaryErrorText: "최소 1000원 이상부터 작성 가능합니다.");
    } else {
      // 유효한 값이면 에러 메시지 제거
      state = state.copyWith(salaryErrorText: null);
    }
  }

  // ViewModel의 상태를 기반으로 컨트롤러 텍스트를 업데이트하는 내부 도우미 함수
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
    String formattedText;

    if (value != null) {
      formattedText = _numberFormat.format(value);
    } else {
      formattedText = '';
    }

    if (state.salaryText != formattedText) {
      state = state.copyWith(salaryText: formattedText);
    }

    if (_salaryController.text != formattedText) {
      // 포매팅으로 인해 쉼표(,)가 추가/삭제되면서 텍스트 길이가 변하므로
      // 변경된 길이만큼 커서 위치를 보정해줍니다.
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

  // 월급날짜 업데이트
  void updateSelectedDay(int day) {
    state = state.copyWith(selectedDay: day);
    // 상태가 업데이트되면 컨트롤러 텍스트도 업데이트
    _updateControllersFromState(state);
    _updateButtonState(); // 상태 업데이트 후 버튼 활성화 상태 갱신
  }

  // 버튼 활성화 상태 업데이트 (내부 로직)
  void _updateButtonState() {
    final String cleanSalaryText = _salaryController.text.replaceAll(
      RegExp(r'[^0-9]'),
      '',
    );
    // 에러가 없고 모든 값이 입력되었을 때만 버튼 활성화
    final bool isEnabled =
        cleanSalaryText.isNotEmpty &&
        state.selectedDay > 0 &&
        state.salaryErrorText == null; // 에러 상태 확인

    if (state.isButtonEnabled != isEnabled) {
      state = state.copyWith(isButtonEnabled: isEnabled);
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

      // 유저 정보 업데이트
      ref
          .read(userProvider.notifier)
          .updateSalaryInfo(
            newMonthlySalary: response.data['amount'], // 월 급여
            newPayday: response.data['payday'], // 월급날
            newEarningsPerSecond: response.data['amountPerSec'], // 초당 수익
          );

      toastification.show(
        alignment: Alignment.topCenter,
        style: ToastificationStyle.simple,
        type: ToastificationType.success,
        context: context,
        title: const Text("월 수익이 설정되었습니다."),
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
