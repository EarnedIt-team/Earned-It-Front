// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'forgot_password_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ForgotPasswordState {

 ForgotPasswordStep get currentStep; bool get isEmailValid; bool get isCodeVerified; bool get isPasswordValid; bool get isPasswordConfirmed; bool get isObscurePassword; bool get isObscurePasswordConfirm; int get timerSeconds;// 15분 = 900초
 String? get errorMessage; bool get isLoading;
/// Create a copy of ForgotPasswordState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ForgotPasswordStateCopyWith<ForgotPasswordState> get copyWith => _$ForgotPasswordStateCopyWithImpl<ForgotPasswordState>(this as ForgotPasswordState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ForgotPasswordState&&(identical(other.currentStep, currentStep) || other.currentStep == currentStep)&&(identical(other.isEmailValid, isEmailValid) || other.isEmailValid == isEmailValid)&&(identical(other.isCodeVerified, isCodeVerified) || other.isCodeVerified == isCodeVerified)&&(identical(other.isPasswordValid, isPasswordValid) || other.isPasswordValid == isPasswordValid)&&(identical(other.isPasswordConfirmed, isPasswordConfirmed) || other.isPasswordConfirmed == isPasswordConfirmed)&&(identical(other.isObscurePassword, isObscurePassword) || other.isObscurePassword == isObscurePassword)&&(identical(other.isObscurePasswordConfirm, isObscurePasswordConfirm) || other.isObscurePasswordConfirm == isObscurePasswordConfirm)&&(identical(other.timerSeconds, timerSeconds) || other.timerSeconds == timerSeconds)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading));
}


@override
int get hashCode => Object.hash(runtimeType,currentStep,isEmailValid,isCodeVerified,isPasswordValid,isPasswordConfirmed,isObscurePassword,isObscurePasswordConfirm,timerSeconds,errorMessage,isLoading);

@override
String toString() {
  return 'ForgotPasswordState(currentStep: $currentStep, isEmailValid: $isEmailValid, isCodeVerified: $isCodeVerified, isPasswordValid: $isPasswordValid, isPasswordConfirmed: $isPasswordConfirmed, isObscurePassword: $isObscurePassword, isObscurePasswordConfirm: $isObscurePasswordConfirm, timerSeconds: $timerSeconds, errorMessage: $errorMessage, isLoading: $isLoading)';
}


}

/// @nodoc
abstract mixin class $ForgotPasswordStateCopyWith<$Res>  {
  factory $ForgotPasswordStateCopyWith(ForgotPasswordState value, $Res Function(ForgotPasswordState) _then) = _$ForgotPasswordStateCopyWithImpl;
@useResult
$Res call({
 ForgotPasswordStep currentStep, bool isEmailValid, bool isCodeVerified, bool isPasswordValid, bool isPasswordConfirmed, bool isObscurePassword, bool isObscurePasswordConfirm, int timerSeconds, String? errorMessage, bool isLoading
});




}
/// @nodoc
class _$ForgotPasswordStateCopyWithImpl<$Res>
    implements $ForgotPasswordStateCopyWith<$Res> {
  _$ForgotPasswordStateCopyWithImpl(this._self, this._then);

  final ForgotPasswordState _self;
  final $Res Function(ForgotPasswordState) _then;

/// Create a copy of ForgotPasswordState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? currentStep = null,Object? isEmailValid = null,Object? isCodeVerified = null,Object? isPasswordValid = null,Object? isPasswordConfirmed = null,Object? isObscurePassword = null,Object? isObscurePasswordConfirm = null,Object? timerSeconds = null,Object? errorMessage = freezed,Object? isLoading = null,}) {
  return _then(_self.copyWith(
currentStep: null == currentStep ? _self.currentStep : currentStep // ignore: cast_nullable_to_non_nullable
as ForgotPasswordStep,isEmailValid: null == isEmailValid ? _self.isEmailValid : isEmailValid // ignore: cast_nullable_to_non_nullable
as bool,isCodeVerified: null == isCodeVerified ? _self.isCodeVerified : isCodeVerified // ignore: cast_nullable_to_non_nullable
as bool,isPasswordValid: null == isPasswordValid ? _self.isPasswordValid : isPasswordValid // ignore: cast_nullable_to_non_nullable
as bool,isPasswordConfirmed: null == isPasswordConfirmed ? _self.isPasswordConfirmed : isPasswordConfirmed // ignore: cast_nullable_to_non_nullable
as bool,isObscurePassword: null == isObscurePassword ? _self.isObscurePassword : isObscurePassword // ignore: cast_nullable_to_non_nullable
as bool,isObscurePasswordConfirm: null == isObscurePasswordConfirm ? _self.isObscurePasswordConfirm : isObscurePasswordConfirm // ignore: cast_nullable_to_non_nullable
as bool,timerSeconds: null == timerSeconds ? _self.timerSeconds : timerSeconds // ignore: cast_nullable_to_non_nullable
as int,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ForgotPasswordState].
extension ForgotPasswordStatePatterns on ForgotPasswordState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ForgotPasswordState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ForgotPasswordState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ForgotPasswordState value)  $default,){
final _that = this;
switch (_that) {
case _ForgotPasswordState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ForgotPasswordState value)?  $default,){
final _that = this;
switch (_that) {
case _ForgotPasswordState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ForgotPasswordStep currentStep,  bool isEmailValid,  bool isCodeVerified,  bool isPasswordValid,  bool isPasswordConfirmed,  bool isObscurePassword,  bool isObscurePasswordConfirm,  int timerSeconds,  String? errorMessage,  bool isLoading)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ForgotPasswordState() when $default != null:
return $default(_that.currentStep,_that.isEmailValid,_that.isCodeVerified,_that.isPasswordValid,_that.isPasswordConfirmed,_that.isObscurePassword,_that.isObscurePasswordConfirm,_that.timerSeconds,_that.errorMessage,_that.isLoading);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ForgotPasswordStep currentStep,  bool isEmailValid,  bool isCodeVerified,  bool isPasswordValid,  bool isPasswordConfirmed,  bool isObscurePassword,  bool isObscurePasswordConfirm,  int timerSeconds,  String? errorMessage,  bool isLoading)  $default,) {final _that = this;
switch (_that) {
case _ForgotPasswordState():
return $default(_that.currentStep,_that.isEmailValid,_that.isCodeVerified,_that.isPasswordValid,_that.isPasswordConfirmed,_that.isObscurePassword,_that.isObscurePasswordConfirm,_that.timerSeconds,_that.errorMessage,_that.isLoading);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ForgotPasswordStep currentStep,  bool isEmailValid,  bool isCodeVerified,  bool isPasswordValid,  bool isPasswordConfirmed,  bool isObscurePassword,  bool isObscurePasswordConfirm,  int timerSeconds,  String? errorMessage,  bool isLoading)?  $default,) {final _that = this;
switch (_that) {
case _ForgotPasswordState() when $default != null:
return $default(_that.currentStep,_that.isEmailValid,_that.isCodeVerified,_that.isPasswordValid,_that.isPasswordConfirmed,_that.isObscurePassword,_that.isObscurePasswordConfirm,_that.timerSeconds,_that.errorMessage,_that.isLoading);case _:
  return null;

}
}

}

/// @nodoc


class _ForgotPasswordState implements ForgotPasswordState {
  const _ForgotPasswordState({this.currentStep = ForgotPasswordStep.enterEmail, this.isEmailValid = false, this.isCodeVerified = false, this.isPasswordValid = false, this.isPasswordConfirmed = false, this.isObscurePassword = true, this.isObscurePasswordConfirm = true, this.timerSeconds = 900, this.errorMessage, this.isLoading = false});
  

@override@JsonKey() final  ForgotPasswordStep currentStep;
@override@JsonKey() final  bool isEmailValid;
@override@JsonKey() final  bool isCodeVerified;
@override@JsonKey() final  bool isPasswordValid;
@override@JsonKey() final  bool isPasswordConfirmed;
@override@JsonKey() final  bool isObscurePassword;
@override@JsonKey() final  bool isObscurePasswordConfirm;
@override@JsonKey() final  int timerSeconds;
// 15분 = 900초
@override final  String? errorMessage;
@override@JsonKey() final  bool isLoading;

/// Create a copy of ForgotPasswordState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ForgotPasswordStateCopyWith<_ForgotPasswordState> get copyWith => __$ForgotPasswordStateCopyWithImpl<_ForgotPasswordState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ForgotPasswordState&&(identical(other.currentStep, currentStep) || other.currentStep == currentStep)&&(identical(other.isEmailValid, isEmailValid) || other.isEmailValid == isEmailValid)&&(identical(other.isCodeVerified, isCodeVerified) || other.isCodeVerified == isCodeVerified)&&(identical(other.isPasswordValid, isPasswordValid) || other.isPasswordValid == isPasswordValid)&&(identical(other.isPasswordConfirmed, isPasswordConfirmed) || other.isPasswordConfirmed == isPasswordConfirmed)&&(identical(other.isObscurePassword, isObscurePassword) || other.isObscurePassword == isObscurePassword)&&(identical(other.isObscurePasswordConfirm, isObscurePasswordConfirm) || other.isObscurePasswordConfirm == isObscurePasswordConfirm)&&(identical(other.timerSeconds, timerSeconds) || other.timerSeconds == timerSeconds)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading));
}


@override
int get hashCode => Object.hash(runtimeType,currentStep,isEmailValid,isCodeVerified,isPasswordValid,isPasswordConfirmed,isObscurePassword,isObscurePasswordConfirm,timerSeconds,errorMessage,isLoading);

@override
String toString() {
  return 'ForgotPasswordState(currentStep: $currentStep, isEmailValid: $isEmailValid, isCodeVerified: $isCodeVerified, isPasswordValid: $isPasswordValid, isPasswordConfirmed: $isPasswordConfirmed, isObscurePassword: $isObscurePassword, isObscurePasswordConfirm: $isObscurePasswordConfirm, timerSeconds: $timerSeconds, errorMessage: $errorMessage, isLoading: $isLoading)';
}


}

/// @nodoc
abstract mixin class _$ForgotPasswordStateCopyWith<$Res> implements $ForgotPasswordStateCopyWith<$Res> {
  factory _$ForgotPasswordStateCopyWith(_ForgotPasswordState value, $Res Function(_ForgotPasswordState) _then) = __$ForgotPasswordStateCopyWithImpl;
@override @useResult
$Res call({
 ForgotPasswordStep currentStep, bool isEmailValid, bool isCodeVerified, bool isPasswordValid, bool isPasswordConfirmed, bool isObscurePassword, bool isObscurePasswordConfirm, int timerSeconds, String? errorMessage, bool isLoading
});




}
/// @nodoc
class __$ForgotPasswordStateCopyWithImpl<$Res>
    implements _$ForgotPasswordStateCopyWith<$Res> {
  __$ForgotPasswordStateCopyWithImpl(this._self, this._then);

  final _ForgotPasswordState _self;
  final $Res Function(_ForgotPasswordState) _then;

/// Create a copy of ForgotPasswordState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? currentStep = null,Object? isEmailValid = null,Object? isCodeVerified = null,Object? isPasswordValid = null,Object? isPasswordConfirmed = null,Object? isObscurePassword = null,Object? isObscurePasswordConfirm = null,Object? timerSeconds = null,Object? errorMessage = freezed,Object? isLoading = null,}) {
  return _then(_ForgotPasswordState(
currentStep: null == currentStep ? _self.currentStep : currentStep // ignore: cast_nullable_to_non_nullable
as ForgotPasswordStep,isEmailValid: null == isEmailValid ? _self.isEmailValid : isEmailValid // ignore: cast_nullable_to_non_nullable
as bool,isCodeVerified: null == isCodeVerified ? _self.isCodeVerified : isCodeVerified // ignore: cast_nullable_to_non_nullable
as bool,isPasswordValid: null == isPasswordValid ? _self.isPasswordValid : isPasswordValid // ignore: cast_nullable_to_non_nullable
as bool,isPasswordConfirmed: null == isPasswordConfirmed ? _self.isPasswordConfirmed : isPasswordConfirmed // ignore: cast_nullable_to_non_nullable
as bool,isObscurePassword: null == isObscurePassword ? _self.isObscurePassword : isObscurePassword // ignore: cast_nullable_to_non_nullable
as bool,isObscurePasswordConfirm: null == isObscurePasswordConfirm ? _self.isObscurePasswordConfirm : isObscurePasswordConfirm // ignore: cast_nullable_to_non_nullable
as bool,timerSeconds: null == timerSeconds ? _self.timerSeconds : timerSeconds // ignore: cast_nullable_to_non_nullable
as int,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
