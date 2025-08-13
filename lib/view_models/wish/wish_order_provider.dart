import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:earned_it/config/exception.dart';
import 'package:earned_it/config/toastMessage.dart';
import 'package:earned_it/models/wish/wish_model.dart';
import 'package:earned_it/models/wish/wish_order_state.dart';
import 'package:earned_it/services/auth/login_service.dart';
import 'package:earned_it/services/wish_service.dart';
import 'package:earned_it/view_models/wish/wish_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';

class WishOrderViewModel extends Notifier<WishOrderState> {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  late final WishService _wishService;
  late final LoginService _loginService;

  @override
  WishOrderState build() {
    _wishService = ref.read(wishServiceProvider);
    _loginService = ref.read(loginServiceProvider);
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

  void reset() {
    state = const WishOrderState();
  }

  Future<void> submitOrder(BuildContext context) async {
    if (!state.canSubmit) return;
    state = state.copyWith(isLoading: true);
    try {
      final accessToken = await _storage.read(key: 'accessToken');
      if (accessToken == null) throw Exception("로그인이 필요합니다.");

      // 1. 변경된 순서의 ID 리스트를 추출합니다.
      final orderedIds = state.currentList.map((item) => item.wishId).toList();

      // 2. WishService의 메서드를 호출하여 API 요청을 보냅니다.
      await _wishService.updateStarWishOrder(
        accessToken: accessToken,
        orderedWishIds: orderedIds,
      );

      // 3. 성공 시, 로컬 상태를 즉시 업데이트하여 UI에 반영합니다.
      ref
          .read(wishViewModelProvider.notifier)
          .updateStarWishesLocally(state.currentList);

      if (context.mounted) {
        toastMessage(context, '리스트 순서가 저장되었습니다.');
        context.pop();
      }
    } on DioException catch (e) {
      if (context.mounted) _handleApiError(context, e);
    } catch (e) {
      if (context.mounted) _handleGeneralError(context, e);
    } finally {
      if (context.mounted) {
        state = state.copyWith(isLoading: false);
      }
    }
  }

  // --- 에러 처리 헬퍼 메서드 ---
  Future<void> _handleApiError(BuildContext context, DioException e) async {
    state = state.copyWith(isLoading: false);
    if (e.response?.data['code'] == "AUTH_REQUIRED") {
      toastMessage(
        context,
        '잠시 후 다시 시도해주세요.',
        type: ToastmessageType.errorType,
      );
      try {
        final refreshToken = await _storage.read(key: 'refreshToken');
        await _loginService.checkToken(refreshToken!);
      } catch (_) {
        if (context.mounted) context.go('/login');
      }
    } else {
      _handleGeneralError(context, e);
    }
  }

  void _handleGeneralError(BuildContext context, Object e) {
    state = state.copyWith(isLoading: false);
    toastMessage(
      context,
      e.toDisplayString(),
      type: ToastmessageType.errorType,
    );
  }
}

final wishOrderViewModelProvider =
    NotifierProvider<WishOrderViewModel, WishOrderState>(
      WishOrderViewModel.new,
    );
