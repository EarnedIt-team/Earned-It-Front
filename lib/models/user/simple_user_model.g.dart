// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'simple_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SimpleUserModel _$SimpleUserModelFromJson(Map<String, dynamic> json) =>
    _SimpleUserModel(
      userId: (json['userId'] as num).toInt(),
      nickname: json['nickname'] as String,
      profileImage: json['profileImage'] as String?,
    );

Map<String, dynamic> _$SimpleUserModelToJson(_SimpleUserModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'nickname': instance.nickname,
      'profileImage': instance.profileImage,
    };
