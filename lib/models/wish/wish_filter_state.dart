import 'package:freezed_annotation/freezed_annotation.dart';

part 'wish_filter_state.freezed.dart';

// 1. 정렬 기준을 나타내는 Enum
enum SortKey { name, createdAt, price }

// 2. 정렬 방향을 나타내는 Enum
enum SortDirection { asc, desc }

// 3. 필터 및 정렬 상태를 관리하는 State 클래스
@freezed
abstract class WishFilterState with _$WishFilterState {
  const factory WishFilterState({
    SortKey? sortKey, // 현재 선택된 정렬 기준
    SortDirection? sortDirection, // 현재 정렬 방향
    @Default(false) bool filterByStarred, // Star 필터 활성화 여부
    @Default(false) bool filterByBought, // 구매 필터 활성화 여부
  }) = _WishFilterState;
}

extension WishFilterStateX on WishFilterState {
  // Star 또는 구매 여부 필터가 활성화되었는지 확인하는 getter
  bool get isFiltered => filterByStarred || filterByBought;

  // API 요청에 사용할 정렬 파라미터 문자열을 생성하는 getter
  String get sortParameter {
    if (sortKey == null) {
      return "name,asc"; // 기본값은 빈 문자열
    }
    final keyString = sortKey!.name;
    final directionString = sortDirection == SortDirection.asc ? "asc" : "desc";
    return "$keyString,$directionString";
  }
}
