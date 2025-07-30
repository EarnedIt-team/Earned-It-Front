import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_state.freezed.dart';

@freezed
abstract class UserState with _$UserState {
  const factory UserState({
    /// 월 수익 설정 여부
    @Default(false) bool isearningsPerSecond,

    /// 월 급여
    @Default(0) int monthlySalary,

    /// 월급날
    @Default(0) int payday,

    /// 초당 수익
    @Default(0.0) double earningsPerSecond,

    /// 약관 동의 여부 (Default = true)
    /// 정보가 없는 경우 모달이 뜨지 않도록 하는 안전장치
    @Default(true) bool hasAgreedTerm,
  }) = _UserState;
}
