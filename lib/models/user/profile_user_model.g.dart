// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProfileUserModel _$ProfileUserModelFromJson(Map<String, dynamic> json) =>
    _ProfileUserModel(
      userId: (json['userId'] as num?)?.toInt() ?? 0,
      profileImage: json['profileImage'] as String?,
      nickname: json['nickname'] as String,
      monthlySalary: (json['monthlySalary'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$ProfileUserModelToJson(_ProfileUserModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'profileImage': instance.profileImage,
      'nickname': instance.nickname,
      'monthlySalary': instance.monthlySalary,
    };
