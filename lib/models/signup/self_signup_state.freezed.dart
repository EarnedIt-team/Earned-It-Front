// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'self_signup_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SelfSignupState {

// 기본값 지정 시 @Default(false) 사용
 bool get isAvailableID; bool get isRequestAuth; bool get isAvailableCode; bool get isSuccessfulCode; bool get isObscurePassword;// 비밀번호 기본값은 숨김
 bool get isAvailablePassword; bool get isCheckPassword; bool get isAgreedToTerms; bool get isProgress;// 서버 통신 유무
 int get startTime;
/// Create a copy of SelfSignupState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SelfSignupStateCopyWith<SelfSignupState> get copyWith => _$SelfSignupStateCopyWithImpl<SelfSignupState>(this as SelfSignupState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SelfSignupState&&(identical(other.isAvailableID, isAvailableID) || other.isAvailableID == isAvailableID)&&(identical(other.isRequestAuth, isRequestAuth) || other.isRequestAuth == isRequestAuth)&&(identical(other.isAvailableCode, isAvailableCode) || other.isAvailableCode == isAvailableCode)&&(identical(other.isSuccessfulCode, isSuccessfulCode) || other.isSuccessfulCode == isSuccessfulCode)&&(identical(other.isObscurePassword, isObscurePassword) || other.isObscurePassword == isObscurePassword)&&(identical(other.isAvailablePassword, isAvailablePassword) || other.isAvailablePassword == isAvailablePassword)&&(identical(other.isCheckPassword, isCheckPassword) || other.isCheckPassword == isCheckPassword)&&(identical(other.isAgreedToTerms, isAgreedToTerms) || other.isAgreedToTerms == isAgreedToTerms)&&(identical(other.isProgress, isProgress) || other.isProgress == isProgress)&&(identical(other.startTime, startTime) || other.startTime == startTime));
}


@override
int get hashCode => Object.hash(runtimeType,isAvailableID,isRequestAuth,isAvailableCode,isSuccessfulCode,isObscurePassword,isAvailablePassword,isCheckPassword,isAgreedToTerms,isProgress,startTime);

@override
String toString() {
  return 'SelfSignupState(isAvailableID: $isAvailableID, isRequestAuth: $isRequestAuth, isAvailableCode: $isAvailableCode, isSuccessfulCode: $isSuccessfulCode, isObscurePassword: $isObscurePassword, isAvailablePassword: $isAvailablePassword, isCheckPassword: $isCheckPassword, isAgreedToTerms: $isAgreedToTerms, isProgress: $isProgress, startTime: $startTime)';
}


}

/// @nodoc
abstract mixin class $SelfSignupStateCopyWith<$Res>  {
  factory $SelfSignupStateCopyWith(SelfSignupState value, $Res Function(SelfSignupState) _then) = _$SelfSignupStateCopyWithImpl;
@useResult
$Res call({
 bool isAvailableID, bool isRequestAuth, bool isAvailableCode, bool isSuccessfulCode, bool isObscurePassword, bool isAvailablePassword, bool isCheckPassword, bool isAgreedToTerms, bool isProgress, int startTime
});




}
/// @nodoc
class _$SelfSignupStateCopyWithImpl<$Res>
    implements $SelfSignupStateCopyWith<$Res> {
  _$SelfSignupStateCopyWithImpl(this._self, this._then);

  final SelfSignupState _self;
  final $Res Function(SelfSignupState) _then;

/// Create a copy of SelfSignupState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isAvailableID = null,Object? isRequestAuth = null,Object? isAvailableCode = null,Object? isSuccessfulCode = null,Object? isObscurePassword = null,Object? isAvailablePassword = null,Object? isCheckPassword = null,Object? isAgreedToTerms = null,Object? isProgress = null,Object? startTime = null,}) {
  return _then(_self.copyWith(
isAvailableID: null == isAvailableID ? _self.isAvailableID : isAvailableID // ignore: cast_nullable_to_non_nullable
as bool,isRequestAuth: null == isRequestAuth ? _self.isRequestAuth : isRequestAuth // ignore: cast_nullable_to_non_nullable
as bool,isAvailableCode: null == isAvailableCode ? _self.isAvailableCode : isAvailableCode // ignore: cast_nullable_to_non_nullable
as bool,isSuccessfulCode: null == isSuccessfulCode ? _self.isSuccessfulCode : isSuccessfulCode // ignore: cast_nullable_to_non_nullable
as bool,isObscurePassword: null == isObscurePassword ? _self.isObscurePassword : isObscurePassword // ignore: cast_nullable_to_non_nullable
as bool,isAvailablePassword: null == isAvailablePassword ? _self.isAvailablePassword : isAvailablePassword // ignore: cast_nullable_to_non_nullable
as bool,isCheckPassword: null == isCheckPassword ? _self.isCheckPassword : isCheckPassword // ignore: cast_nullable_to_non_nullable
as bool,isAgreedToTerms: null == isAgreedToTerms ? _self.isAgreedToTerms : isAgreedToTerms // ignore: cast_nullable_to_non_nullable
as bool,isProgress: null == isProgress ? _self.isProgress : isProgress // ignore: cast_nullable_to_non_nullable
as bool,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [SelfSignupState].
extension SelfSignupStatePatterns on SelfSignupState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SelfSignupState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SelfSignupState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SelfSignupState value)  $default,){
final _that = this;
switch (_that) {
case _SelfSignupState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SelfSignupState value)?  $default,){
final _that = this;
switch (_that) {
case _SelfSignupState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isAvailableID,  bool isRequestAuth,  bool isAvailableCode,  bool isSuccessfulCode,  bool isObscurePassword,  bool isAvailablePassword,  bool isCheckPassword,  bool isAgreedToTerms,  bool isProgress,  int startTime)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SelfSignupState() when $default != null:
return $default(_that.isAvailableID,_that.isRequestAuth,_that.isAvailableCode,_that.isSuccessfulCode,_that.isObscurePassword,_that.isAvailablePassword,_that.isCheckPassword,_that.isAgreedToTerms,_that.isProgress,_that.startTime);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isAvailableID,  bool isRequestAuth,  bool isAvailableCode,  bool isSuccessfulCode,  bool isObscurePassword,  bool isAvailablePassword,  bool isCheckPassword,  bool isAgreedToTerms,  bool isProgress,  int startTime)  $default,) {final _that = this;
switch (_that) {
case _SelfSignupState():
return $default(_that.isAvailableID,_that.isRequestAuth,_that.isAvailableCode,_that.isSuccessfulCode,_that.isObscurePassword,_that.isAvailablePassword,_that.isCheckPassword,_that.isAgreedToTerms,_that.isProgress,_that.startTime);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isAvailableID,  bool isRequestAuth,  bool isAvailableCode,  bool isSuccessfulCode,  bool isObscurePassword,  bool isAvailablePassword,  bool isCheckPassword,  bool isAgreedToTerms,  bool isProgress,  int startTime)?  $default,) {final _that = this;
switch (_that) {
case _SelfSignupState() when $default != null:
return $default(_that.isAvailableID,_that.isRequestAuth,_that.isAvailableCode,_that.isSuccessfulCode,_that.isObscurePassword,_that.isAvailablePassword,_that.isCheckPassword,_that.isAgreedToTerms,_that.isProgress,_that.startTime);case _:
  return null;

}
}

}

/// @nodoc


class _SelfSignupState implements SelfSignupState {
  const _SelfSignupState({this.isAvailableID = false, this.isRequestAuth = false, this.isAvailableCode = false, this.isSuccessfulCode = false, this.isObscurePassword = true, this.isAvailablePassword = false, this.isCheckPassword = false, this.isAgreedToTerms = false, this.isProgress = false, this.startTime = 900});
  

// 기본값 지정 시 @Default(false) 사용
@override@JsonKey() final  bool isAvailableID;
@override@JsonKey() final  bool isRequestAuth;
@override@JsonKey() final  bool isAvailableCode;
@override@JsonKey() final  bool isSuccessfulCode;
@override@JsonKey() final  bool isObscurePassword;
// 비밀번호 기본값은 숨김
@override@JsonKey() final  bool isAvailablePassword;
@override@JsonKey() final  bool isCheckPassword;
@override@JsonKey() final  bool isAgreedToTerms;
@override@JsonKey() final  bool isProgress;
// 서버 통신 유무
@override@JsonKey() final  int startTime;

/// Create a copy of SelfSignupState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SelfSignupStateCopyWith<_SelfSignupState> get copyWith => __$SelfSignupStateCopyWithImpl<_SelfSignupState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SelfSignupState&&(identical(other.isAvailableID, isAvailableID) || other.isAvailableID == isAvailableID)&&(identical(other.isRequestAuth, isRequestAuth) || other.isRequestAuth == isRequestAuth)&&(identical(other.isAvailableCode, isAvailableCode) || other.isAvailableCode == isAvailableCode)&&(identical(other.isSuccessfulCode, isSuccessfulCode) || other.isSuccessfulCode == isSuccessfulCode)&&(identical(other.isObscurePassword, isObscurePassword) || other.isObscurePassword == isObscurePassword)&&(identical(other.isAvailablePassword, isAvailablePassword) || other.isAvailablePassword == isAvailablePassword)&&(identical(other.isCheckPassword, isCheckPassword) || other.isCheckPassword == isCheckPassword)&&(identical(other.isAgreedToTerms, isAgreedToTerms) || other.isAgreedToTerms == isAgreedToTerms)&&(identical(other.isProgress, isProgress) || other.isProgress == isProgress)&&(identical(other.startTime, startTime) || other.startTime == startTime));
}


@override
int get hashCode => Object.hash(runtimeType,isAvailableID,isRequestAuth,isAvailableCode,isSuccessfulCode,isObscurePassword,isAvailablePassword,isCheckPassword,isAgreedToTerms,isProgress,startTime);

@override
String toString() {
  return 'SelfSignupState(isAvailableID: $isAvailableID, isRequestAuth: $isRequestAuth, isAvailableCode: $isAvailableCode, isSuccessfulCode: $isSuccessfulCode, isObscurePassword: $isObscurePassword, isAvailablePassword: $isAvailablePassword, isCheckPassword: $isCheckPassword, isAgreedToTerms: $isAgreedToTerms, isProgress: $isProgress, startTime: $startTime)';
}


}

/// @nodoc
abstract mixin class _$SelfSignupStateCopyWith<$Res> implements $SelfSignupStateCopyWith<$Res> {
  factory _$SelfSignupStateCopyWith(_SelfSignupState value, $Res Function(_SelfSignupState) _then) = __$SelfSignupStateCopyWithImpl;
@override @useResult
$Res call({
 bool isAvailableID, bool isRequestAuth, bool isAvailableCode, bool isSuccessfulCode, bool isObscurePassword, bool isAvailablePassword, bool isCheckPassword, bool isAgreedToTerms, bool isProgress, int startTime
});




}
/// @nodoc
class __$SelfSignupStateCopyWithImpl<$Res>
    implements _$SelfSignupStateCopyWith<$Res> {
  __$SelfSignupStateCopyWithImpl(this._self, this._then);

  final _SelfSignupState _self;
  final $Res Function(_SelfSignupState) _then;

/// Create a copy of SelfSignupState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isAvailableID = null,Object? isRequestAuth = null,Object? isAvailableCode = null,Object? isSuccessfulCode = null,Object? isObscurePassword = null,Object? isAvailablePassword = null,Object? isCheckPassword = null,Object? isAgreedToTerms = null,Object? isProgress = null,Object? startTime = null,}) {
  return _then(_SelfSignupState(
isAvailableID: null == isAvailableID ? _self.isAvailableID : isAvailableID // ignore: cast_nullable_to_non_nullable
as bool,isRequestAuth: null == isRequestAuth ? _self.isRequestAuth : isRequestAuth // ignore: cast_nullable_to_non_nullable
as bool,isAvailableCode: null == isAvailableCode ? _self.isAvailableCode : isAvailableCode // ignore: cast_nullable_to_non_nullable
as bool,isSuccessfulCode: null == isSuccessfulCode ? _self.isSuccessfulCode : isSuccessfulCode // ignore: cast_nullable_to_non_nullable
as bool,isObscurePassword: null == isObscurePassword ? _self.isObscurePassword : isObscurePassword // ignore: cast_nullable_to_non_nullable
as bool,isAvailablePassword: null == isAvailablePassword ? _self.isAvailablePassword : isAvailablePassword // ignore: cast_nullable_to_non_nullable
as bool,isCheckPassword: null == isCheckPassword ? _self.isCheckPassword : isCheckPassword // ignore: cast_nullable_to_non_nullable
as bool,isAgreedToTerms: null == isAgreedToTerms ? _self.isAgreedToTerms : isAgreedToTerms // ignore: cast_nullable_to_non_nullable
as bool,isProgress: null == isProgress ? _self.isProgress : isProgress // ignore: cast_nullable_to_non_nullable
as bool,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
