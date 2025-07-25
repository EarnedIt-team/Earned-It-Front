import 'package:freezed_annotation/freezed_annotation.dart';

part 'set_salary_state.freezed.dart';

@freezed
abstract class SetSalaryState with _$SetSalaryState {
  const factory SetSalaryState({
    @Default('') String salaryText, // 실제 TextField에 표시되는 텍스트 (예: "2,000,000원")
    @Default(1) int selectedDay, // 선택된 월급날짜 (일)
    @Default(false) bool isButtonEnabled, // 버튼 활성화 여부
  }) = _SetSalaryState;
}
