import 'package:earned_it/models/wish/wish_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_state.freezed.dart';
part 'user_state.g.dart';

@freezed
abstract class UserState with _$UserState {
  const factory UserState({
    /// 로그인 처리 여부
    @Default(false) bool isLogin,

    /// 사용자 닉네임
    @Default('') String name,

    /// 프로필 이미지
    @Default('') String profileImage,

    /// 월 수익 설정 여부
    @JsonKey(name: 'hasSalary') @Default(false) bool isearningsPerSecond,

    /// 월 급여
    @JsonKey(name: 'amount') @Default(0) int monthlySalary,

    /// 월급날
    @Default(0) int payday,

    /// 초당 수익
    @JsonKey(name: 'amountPerSec') @Default(0.0) double earningsPerSecond,

    /// 약관 동의 여부 (Default = true)
    @Default(true) bool hasAgreedTerm,

    /// 출석 체크 여부 (Default = false)
    @Default(false) bool isCheckedIn,

    /// 공개 여부 (Default = false)
    @Default(false) bool isPublic,
  }) = _UserState;

  // JSON 직렬화를 위한 fromJson 팩토리 생성자 추가
  factory UserState.fromJson(Map<String, dynamic> json) =>
      _$UserStateFromJson(json);
}
