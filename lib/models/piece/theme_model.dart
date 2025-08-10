import 'package:freezed_annotation/freezed_annotation.dart';

part 'theme_model.freezed.dart';
part 'theme_model.g.dart';

// 각 테마("SWEET_AND_SOUR" 등) 내부의 데이터 구조
@freezed
abstract class ThemeModel with _$ThemeModel {
  const factory ThemeModel({
    // 1. JSON 필드명과 Dart 필드명이 다른 경우 @JsonKey를 사용합니다.
    @JsonKey(name: 'themeName') required String themeName,
    @JsonKey(name: 'collectedCount') required int collectedCount,
    @JsonKey(name: 'totalCount') required int totalCount,
    @JsonKey(name: 'totalValue') required int totalValue,
    // 2. JSON의 'slots' 키를 'slots' 필드에 매핑합니다.
    @JsonKey(name: 'slots') required List<SlotModel> slots,
  }) = _ThemeModel;

  factory ThemeModel.fromJson(Map<String, dynamic> json) =>
      _$ThemeModelFromJson(json);
}

// 각 퍼즐 조각(slot)의 데이터 구조
@freezed
abstract class SlotModel with _$SlotModel {
  const factory SlotModel({
    required int slotIndex,
    int? itemId,
    String? itemName,
    String? image,
    int? value,
    String? collectedAt,
    // 3. JSON의 'collected' 키를 'isCollected' 필드에 매핑합니다.
    @JsonKey(name: 'collected') required bool isCollected,
  }) = _SlotModel;

  factory SlotModel.fromJson(Map<String, dynamic> json) =>
      _$SlotModelFromJson(json);
}
