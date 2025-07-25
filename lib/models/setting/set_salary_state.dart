import 'package:freezed_annotation/freezed_annotation.dart';

part 'set_salary_state.freezed.dart';

@freezed
abstract class SetSalaryState with _$SetSalaryState {
  const factory SetSalaryState({
    @Default('') String salaryText,
    @Default(1) int selectedDay,
    @Default(false) bool isButtonEnabled,
    @Default(false) bool isLoading, // API 호출 중 로딩 상태
    @Default('') String errorMessage, // API 에러 메시지
  }) = _SetSalaryState;
}
