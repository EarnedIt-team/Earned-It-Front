import 'package:freezed_annotation/freezed_annotation.dart';

part 'rank_model.freezed.dart';
part 'rank_model.g.dart';

/// 개별 사용자의 랭킹 정보를 담는 모델
@freezed
abstract class RankModel with _$RankModel {
  const factory RankModel({
    required int userId,
    required int rank,
    required String nickname,
    required int score,
    @Default(false) bool? public,
    String? profileImage,
  }) = _RankModel;

  factory RankModel.fromJson(Map<String, dynamic> json) =>
      _$RankModelFromJson(json);
}
