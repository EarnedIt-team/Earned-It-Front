// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wish_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WishModel _$WishModelFromJson(Map<String, dynamic> json) => _WishModel(
  id: (json['id'] as num?)?.toInt() ?? 0,
  userId: (json['userId'] as num?)?.toInt() ?? 0,
  name: json['name'] as String? ?? '',
  price: (json['price'] as num?)?.toInt() ?? 0,
  itemImage: json['itemImage'] as String? ?? '',
  vendor: json['vendor'] as String? ?? '',
  createdAt: json['createdAt'] as String? ?? '',
  url: json['url'] as String? ?? '',
  bought: json['bought'] as bool? ?? false,
  starred: json['starred'] as bool? ?? false,
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
      'url': instance.url,
      'bought': instance.bought,
      'starred': instance.starred,
    };
