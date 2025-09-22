import 'package:earned_it/models/api_response.dart';
import 'package:earned_it/models/wish/wish_search_state.dart';
import 'package:earned_it/services/wish_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// 상품 검색 provider
final wishSearchViewModelProvider =
    NotifierProvider.autoDispose<WishSearchViewModel, WishSearchState>(
      WishSearchViewModel.new,
    );

class WishSearchViewModel extends AutoDisposeNotifier<WishSearchState> {
  late final WishService _wishService;
  final _storage = const FlutterSecureStorage();
  late final TextEditingController searchController;

  @override
  WishSearchState build() {
    _wishService = ref.read(wishServiceProvider);
    searchController = TextEditingController();

    // Notifier가 소멸될 때 컨트롤러도 함께 dispose 합니다.
    ref.onDispose(() {
      searchController.dispose();
    });

    return const WishSearchState();
  }

  /// 키워드로 상품을 검색하는 함수
  Future<void> searchProducts() async {
    final query = searchController.text.trim();
    // 검색어가 비어있거나, 이미 로딩 중이면 함수를 실행하지 않습니다.
    if (query.isEmpty || state.isLoading) return;

    // 로딩 상태 시작
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final accessToken = await _storage.read(key: 'accessToken');
      if (accessToken == null) throw Exception("로그인이 필요합니다.");

      final ApiResponse response = await _wishService.searchProductsByKeyword(
        accessToken: accessToken,
        query: query,
      );

      final data = response.data;
      final searchInfo = SearchInfoModel.fromJson(data['searchInfo']);
      final products =
          (data['products'] as List)
              .map(
                (item) => ProductModel.fromJson(item as Map<String, dynamic>),
              )
              .toList();

      // 성공 시, 상태 업데이트
      state = state.copyWith(
        isLoading: false,
        searchInfo: searchInfo,
        products: products,
      );
    } catch (e) {
      // 실패 시, 에러 메시지와 함께 상태 업데이트
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
        products: [], // 에러 발생 시 이전 검색 결과 초기화
      );
    }
  }

  /// 검색어와 상태를 초기화하는 함수
  void clearSearch() {
    searchController.clear();
    // state를 초기 상태로 리셋합니다.
    state = const WishSearchState();
  }
}
