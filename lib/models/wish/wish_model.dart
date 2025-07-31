import 'package:earned_it/models/wish/piece_info_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'wish_model.freezed.dart';
part 'wish_model.g.dart';

@freezed
abstract class WishModel with _$WishModel {
  const factory WishModel({
    required int id,
    required int userId,
    required String name,
    required int price,
    required String itemImage,
    required String vendor,
    required String createdAt,
    required bool bought,
    required bool starred,
    // required PieceInfoModel pieceInfo,
  }) = _WishModel;

  factory WishModel.fromJson(Map<String, dynamic> json) =>
      _$WishModelFromJson(json);
}
