import 'package:earned_it/models/checkedIn/checkedIn_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'checkedIn_state.freezed.dart';

/// 출석체크 모달의 상태를 정의하는 State 클래스
@freezed
abstract class CheckedInState with _$CheckedInState {
  const factory CheckedInState({
    @Default(false) bool isLoading,

    /// 사용자가 선택한 상자 인덱스
    int? selectedIndex,

    /// 획득한 보상
    String? reward,

    /// 보상 요청 인증 토큰
    String? rewardToken,

    /// 보상 후보
    @Default([]) List<CheckedinModel> candidatesCheckedInList,
  }) = _CheckedInState;
}
