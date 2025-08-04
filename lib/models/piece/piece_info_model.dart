import 'package:freezed_annotation/freezed_annotation.dart';

part 'piece_info_model.freezed.dart';
part 'piece_info_model.g.dart';

@freezed
abstract class PieceInfoModel with _$PieceInfoModel {
  const factory PieceInfoModel({
    required int pieceId,
    required String rarity,
    required String collectedAt,
    required String image,
    required String vendor,
    required String name,
    required int price,
    required String description,
  }) = _PieceInfoModel;

  factory PieceInfoModel.fromJson(Map<String, dynamic> json) =>
      _$PieceInfoModelFromJson(json);
}
