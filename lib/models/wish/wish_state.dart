import 'package:earned_it/models/wish/wish_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';

part 'wish_state.freezed.dart';

@freezed
abstract class WishState with _$WishState {
  const factory WishState({
    // 처리 여부
    @Default(false) bool isLoading,

    /// 즐겨찾기 위시리스트 (Top5)
    @Default([]) List<WishModel> starWishes,

    /// 위시리스트 상위 노출 3개
    @Default([]) List<WishModel> Wishes3,

    /// 전체 위시리스트
    @Default([]) List<WishModel> totalWishes,

    /// 등록된 위시아이템 개수
    @Default(0) int currentWishCount,
  }) = _WishState;
}
