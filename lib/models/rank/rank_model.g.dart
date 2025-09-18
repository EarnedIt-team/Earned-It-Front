// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rank_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RankModel _$RankModelFromJson(Map<String, dynamic> json) => _RankModel(
  userId: (json['userId'] as num).toInt(),
  rank: (json['rank'] as num).toInt(),
  nickname: json['nickname'] as String,
  score: (json['score'] as num).toInt(),
  public: json['public'] as bool? ?? false,
  profileImage: json['profileImage'] as String?,
);

Map<String, dynamic> _$RankModelToJson(_RankModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'rank': instance.rank,
      'nickname': instance.nickname,
      'score': instance.score,
      'public': instance.public,
      'profileImage': instance.profileImage,
    };
