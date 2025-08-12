// 4. 로직을 처리하는 Notifier(ViewModel) 클래스
import 'package:earned_it/models/wish/wish_filter_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WishFilterViewModel extends Notifier<WishFilterState> {
  @override
  WishFilterState build() {
    return const WishFilterState();
  }

  /// 이름, 생성순, 가격 버튼을 눌렀을 때 호출되는 메서드
  void selectSort(SortKey key) {
    // 이미 선택된 키를 다시 누른 경우
    if (state.sortKey == key) {
      // 오름차순 -> 내림차순 -> 해제 순서로 토글
      if (state.sortDirection == SortDirection.asc) {
        state = state.copyWith(sortDirection: SortDirection.desc);
      } else if (state.sortDirection == SortDirection.desc) {
        state = state.copyWith(sortKey: null, sortDirection: null);
      }
    } else {
      // 새로운 키를 선택한 경우, 오름차순으로 설정
      state = state.copyWith(sortKey: key, sortDirection: SortDirection.asc);
    }
  }

  /// Star 필터 버튼을 토글하는 메서드
  void toggleStarFilter() {
    state = state.copyWith(filterByStarred: !state.filterByStarred);
  }

  /// 구매 여부 필터 버튼을 토글하는 메서드
  void toggleBoughtFilter() {
    state = state.copyWith(filterByBought: !state.filterByBought);
  }
}

// Provider 정의
final wishFilterViewModelProvider =
    NotifierProvider<WishFilterViewModel, WishFilterState>(
      WishFilterViewModel.new,
    );
