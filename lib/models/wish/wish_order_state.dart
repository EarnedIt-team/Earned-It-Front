import 'package:earned_it/models/wish/wish_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'wish_order_state.freezed.dart';
part 'wish_order_state.g.dart';

// 1. 순서 변경 모달의 상태를 정의하는 State 클래스
@freezed
abstract class WishOrderState with _$WishOrderState {
  const factory WishOrderState({
    List<WishModel>? initialList, // 순서 변경 전 원본 리스트
    @Default([]) List<WishModel> currentList, // 현재 순서가 반영된 리스트
    @Default(false) bool canSubmit, // 버튼 활성화 여부
    @Default(false) bool isLoading,
  }) = _WishOrderState;

  factory WishOrderState.fromJson(Map<String, dynamic> json) =>
      _$WishOrderStateFromJson(json);
}
