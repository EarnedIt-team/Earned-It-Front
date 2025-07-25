// lib/viewmodels/set_salary_viewmodel.dart
import 'package:earned_it/models/setting/set_salary_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart'; // TextEditingController를 위해 임포트
import 'package:intl/intl.dart';

// StateNotifierProvider 정의
final setSalaryViewModelProvider =
    StateNotifierProvider.autoDispose<SetSalaryViewModel, SetSalaryState>((
      ref,
    ) {
      final viewModel = SetSalaryViewModel();
      // ViewModel이 생성될 때 컨트롤러 리스너 설정
      viewModel._salaryController.addListener(() {
        viewModel._formatSalaryInput(); // 월 급여 포맷팅
        viewModel._updateButtonState(); // 버튼 활성화 상태 업데이트
      });
      // ViewModel이 dispose될 때 컨트롤러도 dispose되도록 설정
      ref.onDispose(() {
        viewModel._salaryController.dispose();
        viewModel._paydayController.dispose();
      });
      return viewModel;
    });

class SetSalaryViewModel extends StateNotifier<SetSalaryState> {
  SetSalaryViewModel() : super(const SetSalaryState()) {
    // 초기화 시 컨트롤러에 초기 값 반영
    _salaryController.text = state.salaryText;
    _paydayController.text =
        state.selectedDay > 0 ? '매 달 ${state.selectedDay}일' : '';
    _updateButtonState(); // 초기 버튼 상태 설정
  }

  // TextEditingController 인스턴스들을 ViewModel 내에서 관리
  final TextEditingController _salaryController = TextEditingController();
  final TextEditingController _paydayController = TextEditingController();

  // 외부에서 컨트롤러에 접근할 수 있도록 Getter 제공
  TextEditingController get salaryController => _salaryController;
  TextEditingController get paydayController => _paydayController;

  final NumberFormat _numberFormat = NumberFormat('#,###', 'ko_KR');

  // 월 급여 텍스트 업데이트 및 포맷팅
  void _formatSalaryInput() {
    String text = _salaryController.text;
    if (text.isEmpty) {
      // 텍스트가 비어있으면 상태도 초기화
      if (state.salaryText.isNotEmpty) {
        // 불필요한 setState 방지
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

    // 포맷팅된 텍스트가 현재 컨트롤러 텍스트와 다를 경우에만 업데이트
    // 이렇게 하지 않으면 무한 루프에 빠질 수 있습니다.
    if (_salaryController.text != formattedText) {
      _salaryController.value = TextEditingValue(
        text: formattedText,
        selection: TextSelection.collapsed(
          offset: formattedText.length - (formattedText.endsWith('원') ? 1 : 0),
        ),
      );
    }
    // 상태 업데이트: TextField의 텍스트가 이미 ViewModel의 상태가 됩니다.
    // 여기서는 굳이 state.copyWith(salaryText: _salaryController.text);를 할 필요가 없습니다.
    // 왜냐하면 _salaryController.text 자체가 formattedText이기 때문입니다.
    // 하지만, _updateButtonState를 호출하기 위해 필요할 수 있습니다.
    if (state.salaryText != _salaryController.text) {
      // 상태가 실제 컨트롤러 텍스트와 다를 경우만 업데이트
      state = state.copyWith(salaryText: _salaryController.text);
    }
  }

  // 월급날짜 업데이트
  void updateSelectedDay(int day) {
    state = state.copyWith(selectedDay: day);
    _paydayController.text = '매 달 ${state.selectedDay}일'; // 컨트롤러 텍스트 업데이트
    _updateButtonState(); // 상태 업데이트 후 버튼 활성화 상태 갱신
  }

  // 버튼 활성화 상태 업데이트 (내부 로직)
  void _updateButtonState() {
    final String cleanSalaryText = _salaryController.text
        .replaceAll('원', '')
        .replaceAll(RegExp(r'[^0-9]'), '');
    final bool isEnabled = cleanSalaryText.isNotEmpty && state.selectedDay > 0;
    if (state.isButtonEnabled != isEnabled) {
      // 불필요한 setState 방지
      state = state.copyWith(isButtonEnabled: isEnabled);
    }
  }

  // 설정 완료 버튼 클릭 로직
  void completeSetup() {
    final String rawSalary = _salaryController.text.replaceAll(
      RegExp(r'[^0-9]'),
      '',
    );
    final int? salary = int.tryParse(rawSalary);
    final int paydayDay = state.selectedDay;

    print('최종 월 급여: $salary, 최종 월급날짜 (일): $paydayDay');

    // TODO: 실제 저장 로직 구현
  }
}
