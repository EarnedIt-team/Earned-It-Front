// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserState _$UserStateFromJson(Map<String, dynamic> json) => _UserState(
  name: json['name'] as String? ?? '',
  profileImage: json['profileImage'] as String? ?? '',
  isearningsPerSecond: json['hasSalary'] as bool? ?? false,
  monthlySalary: (json['amount'] as num?)?.toInt() ?? 0,
  payday: (json['payday'] as num?)?.toInt() ?? 0,
  earningsPerSecond: (json['amountPerSec'] as num?)?.toDouble() ?? 0.0,
  hasAgreedTerm: json['hasAgreedTerm'] as bool? ?? true,
  isCheckedIn: json['isCheckedIn'] as bool? ?? false,
);

Map<String, dynamic> _$UserStateToJson(_UserState instance) =>
    <String, dynamic>{
      'name': instance.name,
      'profileImage': instance.profileImage,
      'hasSalary': instance.isearningsPerSecond,
      'amount': instance.monthlySalary,
      'payday': instance.payday,
      'amountPerSec': instance.earningsPerSecond,
      'hasAgreedTerm': instance.hasAgreedTerm,
      'isCheckedIn': instance.isCheckedIn,
    };
