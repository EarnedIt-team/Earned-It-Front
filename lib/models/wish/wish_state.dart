import 'package:earned_it/models/wish/wish_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';

part 'wish_state.freezed.dart';

@freezed
abstract class WishState with _$WishState {
  const factory WishState({
    // API 호출 중 로딩 상태
    @Default(false) bool isLoading,

    /// 즐겨찾기 위시리스트 (Top5)
    @Default([]) List<WishModel> starWishes,

    /// 위시리스트 상위 노출 3개
    @Default([]) List<WishModel> Wishes3,

    /// 전체 위시리스트 (페이지네이션으로 불러옴)
    @Default([]) List<WishModel> totalWishes,

    /// 등록된 위시아이템 개수
    @Default(0) int currentWishCount,

    // --- 페이지네이션을 위한 상태 ---
    /// 다음에 불러올 페이지 번호
    @Default(0) int page,

    /// 더 불러올 페이지가 남았는지 여부
    @Default(true) bool hasMore,
  }) = _WishState;
}
