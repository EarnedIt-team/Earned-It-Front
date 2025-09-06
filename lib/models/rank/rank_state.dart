import 'package:earned_it/models/rank/rank_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'rank_state.freezed.dart';

/// 랭킹 뷰의 전체 상태를 관리하는 모델
@freezed
abstract class RankState with _$RankState {
  const factory RankState({
    /// 데이터 통신 중 로딩 상태
    @Default(false) bool isLoading,

    /// 내 랭킹 정보
    RankModel? myRank,

    /// 상위 10명 랭킹 리스트
    @Default([]) List<RankModel> top10,
  }) = _RankState;
}
