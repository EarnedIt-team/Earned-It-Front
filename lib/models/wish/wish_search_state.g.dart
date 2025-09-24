// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wish_search_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SearchInfoModel _$SearchInfoModelFromJson(Map<String, dynamic> json) =>
    _SearchInfoModel(
      totalCount: (json['totalCount'] as num).toInt(),
      query: json['query'] as String,
      useCache: json['useCache'] as bool? ?? false,
      removeBackground: json['removeBackground'] as bool? ?? false,
    );

Map<String, dynamic> _$SearchInfoModelToJson(_SearchInfoModel instance) =>
    <String, dynamic>{
      'totalCount': instance.totalCount,
      'query': instance.query,
      'useCache': instance.useCache,
      'removeBackground': instance.removeBackground,
    };

_ProductModel _$ProductModelFromJson(Map<String, dynamic> json) =>
    _ProductModel(
      id: json['id'] as String,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      imageUrl: json['imageUrl'] as String,
      url: json['url'] as String,
      maker: json['maker'] as String?,
    );

Map<String, dynamic> _$ProductModelToJson(_ProductModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'imageUrl': instance.imageUrl,
      'url': instance.url,
      'maker': instance.maker,
    };
