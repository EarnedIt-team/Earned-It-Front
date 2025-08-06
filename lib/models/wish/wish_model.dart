import 'package:earned_it/models/piece/piece_info_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'wish_model.freezed.dart';
part 'wish_model.g.dart';

@freezed
abstract class WishModel with _$WishModel {
  const factory WishModel({
    @Default(0) int wishId,
    @Default(0) int userId,
    @Default('') String name,
    @Default(0) int price,
    @Default('') String itemImage,
    @Default('') String vendor,
    @Default('') String createdAt,
    @Default('') String url,
    @Default(false) bool bought,
    @Default(false) bool starred,
  }) = _WishModel;

  factory WishModel.fromJson(Map<String, dynamic> json) =>
      _$WishModelFromJson(json);
}
