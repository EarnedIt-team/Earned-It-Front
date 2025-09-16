import 'package:earned_it/models/user/profile_user_model.dart';
import 'package:earned_it/models/wish/wish_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_state.freezed.dart';

@freezed
abstract class ProfileState with _$ProfileState {
  const factory ProfileState({
    /// 데이터 통신 중 로딩 상태
    @Default(false) bool isLoading,

    /// 유저 프로필 정보
    ProfileUserModel? userInfo,

    /// 찜한 아이템 리스트 (starList)
    @Default([]) List<WishModel> starList,
  }) = _ProfileState;
}
