import 'package:freezed_annotation/freezed_annotation.dart';

part 'piece_info_model.freezed.dart';
part 'piece_info_model.g.dart';

@freezed
abstract class PieceInfoModel with _$PieceInfoModel {
  const factory PieceInfoModel({
    /// 조각 Id
    int? pieceId,

    /// 등급
    String? rarity,

    /// 등록 날짜
    String? collectedAt,

    /// 이미지 URL
    String? image,

    /// 판매자, 회사명
    String? vendor,

    /// 조각 이름
    String? name,

    /// 가격
    int? price,

    /// 상세 설명
    String? description,

    /// 메인 고정 여부
    bool? isMainPiece,
  }) = _PieceInfoModel;

  factory PieceInfoModel.fromJson(Map<String, dynamic> json) =>
      _$PieceInfoModelFromJson(json);
}
