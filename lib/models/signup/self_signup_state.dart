import 'package:freezed_annotation/freezed_annotation.dart';

part 'self_signup_state.freezed.dart';

@freezed
abstract class SelfSignupState with _$SelfSignupState {
  const factory SelfSignupState({
    // 기본값 지정 시 @Default(false) 사용
    @Default(false) bool isAvailableID,
    @Default(false) bool isRequestAuth,
    @Default(false) bool isAvailableCode,
    @Default(false) bool isSuccessfulCode,
    @Default(true) bool isObscurePassword, // 비밀번호 기본값은 숨김
    @Default(false) bool isAvailablePassword,
    @Default(false) bool isCheckPassword,
    @Default(false) bool isAgreedToTerms,
    @Default(false) bool isProgress, // 서버 통신 유무
    @Default(900) int startTime, // 타이머 시작 시간 (15분)
    // TextEditingController는 Notifier에서 관리되므로 제외 (불변성 유지를 위한)
  }) = _SelfSignupState;
}
