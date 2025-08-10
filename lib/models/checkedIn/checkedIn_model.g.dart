// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checkedIn_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CheckedinModel _$CheckedinModelFromJson(Map<String, dynamic> json) =>
    _CheckedinModel(
      itemId: (json['itemId'] as num?)?.toInt(),
      name: json['name'] as String?,
      image: json['image'] as String?,
      price: (json['price'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CheckedinModelToJson(_CheckedinModel instance) =>
    <String, dynamic>{
      'itemId': instance.itemId,
      'name': instance.name,
      'image': instance.image,
      'price': instance.price,
    };
