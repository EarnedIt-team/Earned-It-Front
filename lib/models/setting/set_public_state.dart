import 'package:freezed_annotation/freezed_annotation.dart';

part 'set_public_state.freezed.dart';

@freezed
abstract class SetPublicState with _$SetPublicState {
  const factory SetPublicState({
    // 현재 사용자의 공개 설정 여부 (true: 공개)
    @Default(true) bool isPublic,
    // API 통신 중 로딩 상태
    @Default(false) bool isLoading,
  }) = _SetPublicState;
}
