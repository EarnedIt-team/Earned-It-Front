import 'package:freezed_annotation/freezed_annotation.dart';

part 'nickname_edit_state.freezed.dart';

// 1. 닉네임 수정 화면의 상태를 정의하는 State 클래스
@freezed
abstract class NicknameEditState with _$NicknameEditState {
  const factory NicknameEditState({
    String? initialNickname, // 수정 전 원본 닉네임
    String? validationError, // 유효성 검사 에러 메시지
    @Default(false) bool canSubmit, // 버튼 활성화 여부
    @Default(false) bool isLoading,
  }) = _NicknameEditState;
}
