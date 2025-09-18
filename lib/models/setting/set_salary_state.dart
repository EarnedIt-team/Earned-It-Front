import 'package:freezed_annotation/freezed_annotation.dart';

part 'set_salary_state.freezed.dart';

@freezed
abstract class SetSalaryState with _$SetSalaryState {
  const factory SetSalaryState({
    @Default('') String salaryText,
    @Default(1) int selectedDay,
    @Default(false) bool isButtonEnabled,
    @Default(false) bool isLoading,
    @Default('') String errorMessage,
    String? salaryErrorText, // 유효성 검사 에러 메시지 필드
  }) = _SetSalaryState;
}
