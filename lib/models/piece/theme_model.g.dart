// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ThemeModel _$ThemeModelFromJson(Map<String, dynamic> json) => _ThemeModel(
  themeName: json['themeName'] as String,
  collectedCount: (json['collectedCount'] as num).toInt(),
  totalCount: (json['totalCount'] as num).toInt(),
  totalValue: (json['totalValue'] as num).toInt(),
  slots:
      (json['slots'] as List<dynamic>)
          .map((e) => SlotModel.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$ThemeModelToJson(_ThemeModel instance) =>
    <String, dynamic>{
      'themeName': instance.themeName,
      'collectedCount': instance.collectedCount,
      'totalCount': instance.totalCount,
      'totalValue': instance.totalValue,
      'slots': instance.slots,
    };

_SlotModel _$SlotModelFromJson(Map<String, dynamic> json) => _SlotModel(
  slotIndex: (json['slotIndex'] as num).toInt(),
  pieceId: (json['pieceId'] as num?)?.toInt(),
  itemId: (json['itemId'] as num?)?.toInt(),
  itemName: json['itemName'] as String?,
  image: json['image'] as String?,
  value: (json['value'] as num?)?.toInt(),
  collectedAt: json['collectedAt'] as String?,
  isCollected: json['collected'] as bool,
);

Map<String, dynamic> _$SlotModelToJson(_SlotModel instance) =>
    <String, dynamic>{
      'slotIndex': instance.slotIndex,
      'pieceId': instance.pieceId,
      'itemId': instance.itemId,
      'itemName': instance.itemName,
      'image': instance.image,
      'value': instance.value,
      'collectedAt': instance.collectedAt,
      'collected': instance.isCollected,
    };
