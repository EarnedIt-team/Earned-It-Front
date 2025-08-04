// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserState _$UserStateFromJson(Map<String, dynamic> json) => _UserState(
  isearningsPerSecond: json['hasSalary'] as bool? ?? false,
  monthlySalary: (json['amount'] as num?)?.toInt() ?? 0,
  payday: (json['payday'] as num?)?.toInt() ?? 0,
  earningsPerSecond: (json['amountPerSec'] as num?)?.toDouble() ?? 0.0,
  hasAgreedTerm: json['hasAgreedTerm'] as bool? ?? true,
  starWishes:
      (json['starWishes'] as List<dynamic>?)
          ?.map((e) => WishModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  Wishes3:
      (json['Wishes3'] as List<dynamic>?)
          ?.map((e) => WishModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  totalWishes:
      (json['totalWishes'] as List<dynamic>?)
          ?.map((e) => WishModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$UserStateToJson(_UserState instance) =>
    <String, dynamic>{
      'hasSalary': instance.isearningsPerSecond,
      'amount': instance.monthlySalary,
      'payday': instance.payday,
      'amountPerSec': instance.earningsPerSecond,
      'hasAgreedTerm': instance.hasAgreedTerm,
      'starWishes': instance.starWishes,
      'Wishes3': instance.Wishes3,
      'totalWishes': instance.totalWishes,
    };
