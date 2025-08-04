import 'package:earned_it/models/wish/wish_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_state.freezed.dart';
part 'user_state.g.dart';

@freezed
abstract class UserState with _$UserState {
  const factory UserState({
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

    /// 즐겨찾기 위시리스트 (Top5)
    @Default([]) List<WishModel> starWishes,

    /// 위시리스트 상위 노출 3개
    @Default([]) List<WishModel> Wishes3,

    /// 전체 위시리스트
    @Default([]) List<WishModel> totalWishes,
  }) = _UserState;

  // JSON 직렬화를 위한 fromJson 팩토리 생성자 추가
  factory UserState.fromJson(Map<String, dynamic> json) =>
      _$UserStateFromJson(json);
}
