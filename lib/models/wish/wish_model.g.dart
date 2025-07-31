// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wish_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WishModel _$WishModelFromJson(Map<String, dynamic> json) => _WishModel(
  id: (json['id'] as num).toInt(),
  userId: (json['userId'] as num).toInt(),
  name: json['name'] as String,
  price: (json['price'] as num).toInt(),
  itemImage: json['itemImage'] as String,
  vendor: json['vendor'] as String,
  createdAt: json['createdAt'] as String,
  bought: json['bought'] as bool,
  starred: json['starred'] as bool,
);

Map<String, dynamic> _$WishModelToJson(_WishModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'name': instance.name,
      'price': instance.price,
      'itemImage': instance.itemImage,
      'vendor': instance.vendor,
      'createdAt': instance.createdAt,
      'bought': instance.bought,
      'starred': instance.starred,
    };
