// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'piece_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PieceInfoModel _$PieceInfoModelFromJson(Map<String, dynamic> json) =>
    _PieceInfoModel(
      pieceId: (json['pieceId'] as num?)?.toInt(),
      rarity: json['rarity'] as String?,
      collectedAt: json['collectedAt'] as String?,
      image: json['image'] as String?,
      vendor: json['vendor'] as String?,
      name: json['name'] as String?,
      price: (json['price'] as num?)?.toInt(),
      description: json['description'] as String?,
      isMainPiece: json['isMainPiece'] as bool?,
    );

Map<String, dynamic> _$PieceInfoModelToJson(_PieceInfoModel instance) =>
    <String, dynamic>{
      'pieceId': instance.pieceId,
      'rarity': instance.rarity,
      'collectedAt': instance.collectedAt,
      'image': instance.image,
      'vendor': instance.vendor,
      'name': instance.name,
      'price': instance.price,
      'description': instance.description,
      'isMainPiece': instance.isMainPiece,
    };
