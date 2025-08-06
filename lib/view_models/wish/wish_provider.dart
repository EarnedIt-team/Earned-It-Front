import 'package:dio/dio.dart';
import 'package:earned_it/config/exception.dart';
import 'package:earned_it/models/wish/wish_model.dart';
import 'package:earned_it/models/wish/wish_state.dart';
import 'package:earned_it/services/auth/login_service.dart';
import 'package:earned_it/services/wish_service.dart';
import 'package:earned_it/view_models/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:toastification/toastification.dart';

final wishViewModelProvider = NotifierProvider<WishViewModel, WishState>(
  WishViewModel.new,
);

class WishViewModel extends Notifier<WishState> {
  late final WishService _wishService;
  late final LoginService _loginService;
  final _storage = const FlutterSecureStorage();

  @override
  WishState build() {
    _wishService = ref.read(wishServiceProvider);
    _loginService = ref.read(loginServiceProvider);
    return const WishState(); // isLoading이 false인 초기 상태
  }

  /// 서버 응답 데이터로 위시리스트 상태 전체를 업데이트합니다.
  void updateStarWishesFromServer(Map<String, dynamic> data) {
    final List<dynamic> rawStarWishes = data["starWishes"] ?? [];

    final List<WishModel> starWishesList =
        rawStarWishes
            .map((json) => WishModel.fromJson(json as Map<String, dynamic>))
            .toList();

    state = state.copyWith(starWishes: starWishesList);
    print("Star 위시리스트 업데이트");
  }

  /// 사용자의 Star 위시리스트를 불러옵니다.
  Future<void> loadStarWish() async {
    try {
      final String? accessToken = await _storage.read(key: 'accessToken');

      final wishService = ref.read(wishServiceProvider);
      final response = await wishService.loadStarWish(accessToken!);

      final List<dynamic> rawStarWishes = response.data;

      final List<WishModel> StarWishList =
          rawStarWishes
              .map((json) => WishModel.fromJson(json as Map<String, dynamic>))
              .toList();

      state = state.copyWith(starWishes: StarWishList);
      print("저장 완료");
    } catch (e) {
      print("유저 정보 불러오기 에러 $e");
    }
  }

  /// 사용자의 하이라이트(3개) 위시리스트를 불러옵니다.
  Future<void> loadHighLightWish() async {
    try {
      final String? accessToken = await _storage.read(key: 'accessToken');

      final wishService = ref.read(wishServiceProvider);
      final response = await wishService.loadHighLightWish(accessToken!);

      final currentWishCount = response.data["wishInfo"]["currentWishCount"];
      final List<dynamic> rawHighLightWishes = response.data["wishHighlight"];

      final List<WishModel> highLightWishList =
          rawHighLightWishes
              .map((json) => WishModel.fromJson(json as Map<String, dynamic>))
              .toList();

      state = state.copyWith(
        Wishes3: highLightWishList,
        currentWishCount: currentWishCount,
      );
      print("저장 완료");
    } catch (e) {
      print("유저 정보 불러오기 에러 $e");
    }
  }

  /// 사용자의 전체 위시리스트를 불러옵니다.
  Future<void> loadAllWish() async {
    try {
      final String? accessToken = await _storage.read(key: 'accessToken');

      final wishService = ref.read(wishServiceProvider);
      final response = await wishService.getWishList(
        accessToken: accessToken!,
        page: 0,
        size: 20,
        sort: "name,asc",
      );

      final List<dynamic> rawAllWishes = response.data["content"];

      final List<WishModel> allWishList =
          rawAllWishes
              .map((json) => WishModel.fromJson(json as Map<String, dynamic>))
              .toList();

      state = state.copyWith(totalWishes: allWishList);
      print("저장 완료");
    } catch (e) {
      print("유저 정보 불러오기 에러 $e");
    }
  }

  /// 위시리스트 아이템 삭제 로직
  Future<void> deleteWishItem(BuildContext context, int wishId) async {
    // 👇 2. 로딩 상태 시작
    state = state.copyWith(isLoading: true);
    try {
      final accessToken = await _storage.read(key: 'accessToken');
      if (accessToken == null) {
        throw Exception("로그인이 필요합니다.");
      }

      await _wishService.deleteWishItem(
        accessToken: accessToken,
        wishId: wishId,
      );

      // 로컬에서 동일한 정보 삭제
      ref.read(wishViewModelProvider.notifier).removeWishItemLocally(wishId);

      await ref.read(wishViewModelProvider.notifier).loadStarWish();
      await ref.read(wishViewModelProvider.notifier).loadHighLightWish();

      toastification.show(
        context: context,
        type: ToastificationType.success,
        title: const Text('위시 아이템이 삭제되었습니다.'),
        autoCloseDuration: const Duration(seconds: 3),
      );
    } on DioException catch (e) {
      if (context.mounted) _handleApiError(context, e);
    } catch (e) {
      if (context.mounted) _handleGeneralError(context, e);
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  /// 로컬 상태에서 특정 위시 아이템을 즉시 제거합니다.
  void removeWishItemLocally(int wishId) {
    // 기존 리스트를 복사하여 불변성을 유지
    final newStarWishes = List<WishModel>.from(state.starWishes)
      ..removeWhere((item) => item.wishId == wishId);

    final newHighLightWishes = List<WishModel>.from(state.Wishes3)
      ..removeWhere((item) => item.wishId == wishId);

    final newTotalWishes = List<WishModel>.from(state.totalWishes)
      ..removeWhere((item) => item.wishId == wishId);

    // 제거된 새 리스트로 상태를 업데이트
    state = state.copyWith(
      starWishes: newStarWishes,
      Wishes3: newHighLightWishes,
      totalWishes: newTotalWishes,
    );
  }

  /// 로컬 상태에서 전체 위시리스트에서 해당 아이템을 찾아 수정된 내용으로 교체
  void updateWishItemLocally(WishModel updatedItem) {
    final newTotalWishes =
        state.totalWishes.map((item) {
          return item.wishId == updatedItem.wishId ? updatedItem : item;
        }).toList();

    final newStarWishes =
        state.starWishes.map((item) {
          return item.wishId == updatedItem.wishId ? updatedItem : item;
        }).toList();

    final newHighLightWishes =
        state.Wishes3.map((item) {
          return item.wishId == updatedItem.wishId ? updatedItem : item;
        }).toList();

    // 업데이트된 두 리스트로 상태를 갱신
    state = state.copyWith(
      totalWishes: newTotalWishes,
      starWishes: newStarWishes,
      Wishes3: newHighLightWishes,
    );
  }

  /// 위시아이템 구매 수정 로직
  Future<void> editBoughtWishItem(BuildContext context, int wishId) async {
    state = state.copyWith(isLoading: true);
    try {
      final accessToken = await _storage.read(key: 'accessToken');
      if (accessToken == null) {
        throw Exception("로그인이 필요합니다.");
      }

      await _wishService.editBoughtWishItem(
        accessToken: accessToken,
        wishId: wishId,
      );

      // 서버 성공 후, 로컬 상태에서 즉시 구매 상태를 토글
      toggleBoughtStatusLocally(wishId);

      await ref.read(wishViewModelProvider.notifier).loadStarWish();
      await ref.read(wishViewModelProvider.notifier).loadHighLightWish();

      toastification.show(
        context: context,
        type: ToastificationType.success,
        title: const Text('아이템 정보를 수정했습니다.'),
        autoCloseDuration: const Duration(seconds: 3),
      );
    } on DioException catch (e) {
      if (context.mounted) _handleApiError(context, e);
    } catch (e) {
      if (context.mounted) _handleGeneralError(context, e);
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  /// 로컬 상태에서 특정 위시 아이템의 구매 상태를 토글합니다.
  void toggleBoughtStatusLocally(int wishId) {
    // 해당 아이템을 찾아 starred 상태를 토글합니다.

    final newStarWishes =
        state.starWishes.map((item) {
          if (item.wishId == wishId) {
            // freezed의 copyWith를 사용하여 bought 값만 변경
            return item.copyWith(bought: !item.bought);
          }
          return item;
        }).toList();

    final newTotalWishes =
        state.totalWishes.map((item) {
          if (item.wishId == wishId) {
            // freezed의 copyWith를 사용하여 bought 값만 변경
            return item.copyWith(bought: !item.bought);
          }
          return item;
        }).toList();

    final newHighLightWishes =
        state.Wishes3.map((item) {
          if (item.wishId == wishId) {
            // freezed의 copyWith를 사용하여 bought 값만 변경
            return item.copyWith(bought: !item.bought);
          }
          return item;
        }).toList();

    // 3. 업데이트된 두 리스트로 상태를 갱신합니다.
    state = state.copyWith(
      starWishes: newStarWishes,
      Wishes3: newHighLightWishes,
      totalWishes: newTotalWishes,
    );
  }

  /// 위시아이템 Star 수정 로직
  Future<void> editStarWishItem(BuildContext context, int wishId) async {
    state = state.copyWith(isLoading: true);
    try {
      final accessToken = await _storage.read(key: 'accessToken');
      if (accessToken == null) {
        throw Exception("로그인이 필요합니다.");
      }

      await _wishService.editStarWishItem(
        accessToken: accessToken,
        wishId: wishId,
      );

      // 서버 성공 후, 로컬 상태에서 즉시 Star 상태를 토글
      toggleStarStatusLocally(wishId);

      await ref.read(wishViewModelProvider.notifier).loadStarWish();
      await ref.read(wishViewModelProvider.notifier).loadHighLightWish();

      toastification.show(
        context: context,
        type: ToastificationType.success,
        title: const Text('아이템 정보를 수정했습니다.'),
        autoCloseDuration: const Duration(seconds: 3),
      );
    } on DioException catch (e) {
      if (context.mounted) _handleApiError(context, e);
    } catch (e) {
      if (context.mounted) _handleGeneralError(context, e);
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  /// 로컬 상태에서 특정 위시 아이템의 Star 상태를 토글합니다.
  void toggleStarStatusLocally(int wishId) {
    // 해당 아이템을 찾아 starred 상태를 토글합니다.

    final newStarWishes =
        state.starWishes.map((item) {
          if (item.wishId == wishId) {
            // freezed의 copyWith를 사용하여 starred 값만 변경
            return item.copyWith(starred: !item.starred);
          }
          return item;
        }).toList();

    final newTotalWishes =
        state.totalWishes.map((item) {
          if (item.wishId == wishId) {
            // freezed의 copyWith를 사용하여 starred 값만 변경
            return item.copyWith(starred: !item.starred);
          }
          return item;
        }).toList();

    final newHighLightWishes =
        state.Wishes3.map((item) {
          if (item.wishId == wishId) {
            // freezed의 copyWith를 사용하여 starred 값만 변경
            return item.copyWith(starred: !item.starred);
          }
          return item;
        }).toList();

    // 3. 업데이트된 두 리스트로 상태를 갱신합니다.
    state = state.copyWith(
      starWishes: newStarWishes,
      Wishes3: newHighLightWishes,
      totalWishes: newTotalWishes,
    );
  }

  // --- 에러 처리 헬퍼 메서드 ---
  Future<void> _handleApiError(BuildContext context, DioException e) async {
    if (e.response?.data['code'] == "AUTH_REQUIRED") {
      toastification.show(
        context: context,
        title: const Text("토큰이 만료되어 재발급합니다. 잠시 후 다시 시도해주세요."),
        autoCloseDuration: const Duration(seconds: 3),
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
    toastification.show(
      context: context,
      title: Text(e.toDisplayString()),
      autoCloseDuration: const Duration(seconds: 3),
    );
  }
}
