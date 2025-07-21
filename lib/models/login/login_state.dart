import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_state.freezed.dart';

@freezed
abstract class LoginState with _$LoginState {
  const factory LoginState({
    @Default(true) bool isObscurePassword, // 비밀번호 숨김 여부
    @Default(false) bool isLoading, // 로그인 진행 중 상태
    @Default(null) String? errorMessage, // 에러 메시지
  }) = _LoginState;
}
