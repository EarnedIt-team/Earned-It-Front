import 'package:collection/collection.dart';
import 'package:earned_it/models/wish/wish_model.dart';
import 'package:earned_it/models/wish/wish_order_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WishOrderViewModel extends Notifier<WishOrderState> {
  @override
  WishOrderState build() {
    return const WishOrderState();
  }

  void initialize(List<WishModel> wishList) {
    state = state.copyWith(
      initialList: List.from(wishList),
      currentList: List.from(wishList),
      canSubmit: false,
    );
  }

  void reorderList(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }
    final reorderedList = List<WishModel>.from(state.currentList);
    final movedItem = reorderedList.removeAt(oldIndex);
    reorderedList.insert(newIndex, movedItem);

    final hasChanges =
        !const ListEquality().equals(state.initialList, reorderedList);
    state = state.copyWith(currentList: reorderedList, canSubmit: hasChanges);
  }

  void resetOrder() {
    state = state.copyWith(
      currentList: List.from(state.initialList!),
      canSubmit: false,
    );
  }

  /// 모달이 닫힐 때 Provider의 상태를 완전히 초기화하는 메서드
  void reset() {
    state = const WishOrderState();
  }

  Future<void> submitOrder(BuildContext context) async {
    if (!state.canSubmit) return;
    state = state.copyWith(isLoading: true);
    try {
      // TODO: 실제 서버로 변경된 순서를 전송하는 API 호출 로직 추가
      final orderedIds = state.currentList.map((item) => item.wishId).toList();
      print("새로운 순서 ID: $orderedIds");
      await Future.delayed(const Duration(seconds: 1));

      // ref.read(wishProvider.notifier).updateStarWishesLocally(state.currentList);

      if (context.mounted) Navigator.of(context).pop();
    } catch (e) {
      // TODO: 에러 처리
    } finally {
      if (context.mounted) {
        state = state.copyWith(isLoading: false);
      }
    }
  }
}

// 👇 (핵심 수정) .autoDispose를 제거합니다.
final wishOrderViewModelProvider =
    NotifierProvider<WishOrderViewModel, WishOrderState>(
      WishOrderViewModel.new,
    );
