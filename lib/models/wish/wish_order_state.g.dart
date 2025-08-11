// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wish_order_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WishOrderState _$WishOrderStateFromJson(Map<String, dynamic> json) =>
    _WishOrderState(
      initialList:
          (json['initialList'] as List<dynamic>?)
              ?.map((e) => WishModel.fromJson(e as Map<String, dynamic>))
              .toList(),
      currentList:
          (json['currentList'] as List<dynamic>?)
              ?.map((e) => WishModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      canSubmit: json['canSubmit'] as bool? ?? false,
      isLoading: json['isLoading'] as bool? ?? false,
    );

Map<String, dynamic> _$WishOrderStateToJson(_WishOrderState instance) =>
    <String, dynamic>{
      'initialList': instance.initialList,
      'currentList': instance.currentList,
      'canSubmit': instance.canSubmit,
      'isLoading': instance.isLoading,
    };
