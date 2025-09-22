import 'package:freezed_annotation/freezed_annotation.dart';

part 'wish_search_state.freezed.dart';
part 'wish_search_state.g.dart';

/// 상품 검색 모델
@freezed
abstract class WishSearchState with _$WishSearchState {
  const factory WishSearchState({
    // API 통신 중 로딩 상태
    @Default(false) bool isLoading,
    // 검색 정보
    SearchInfoModel? searchInfo,
    // 검색된 상품 리스트
    @Default([]) List<ProductModel> products,
    // 에러 메시지
    String? errorMessage,
  }) = _WishSearchState;
}

// --- searchInfo 객체 모델 ---
@freezed
abstract class SearchInfoModel with _$SearchInfoModel {
  const factory SearchInfoModel({
    required int totalCount,
    required String query,
    @Default(false) bool useCache,
    @Default(false) bool removeBackground,
  }) = _SearchInfoModel;

  factory SearchInfoModel.fromJson(Map<String, dynamic> json) =>
      _$SearchInfoModelFromJson(json);
}

// --- products 리스트의 개별 상품 모델 ---
@freezed
abstract class ProductModel with _$ProductModel {
  const factory ProductModel({
    required String id,
    required String name,
    required double price,
    required String imageUrl,
    required String url,
    String? maker,
  }) = _ProductModel;

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);
}
