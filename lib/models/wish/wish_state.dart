import 'package:earned_it/models/wish/wish_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';

part 'wish_state.freezed.dart';

@freezed
abstract class WishState with _$WishState {
  const factory WishState({
    // 기존 상태들
    @Default(false) bool isLoading,
    @Default([]) List<WishModel> starWishes,
    @Default([]) List<WishModel> Wishes3,
    @Default([]) List<WishModel> totalWishes,

    // --- 전체 리스트 기능을 위한 상태 추가 ---
    @Default(0) int currentWishCount,
    @Default(0) int page,
    @Default(true) bool hasMore,

    // --- 검색 기능을 위한 상태 추가 ---
    /// 검색 API 호출 중 로딩 상태
    @Default(false) bool isSearching,

    /// 검색 결과 리스트
    @Default([]) List<WishModel> searchResults,

    /// 다음에 불러올 검색 결과 페이지 번호
    @Default(0) int searchPage,

    /// 더 불러올 검색 결과가 남았는지 여부
    @Default(true) bool searchHasMore,
  }) = _WishState;
}
