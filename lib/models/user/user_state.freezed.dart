// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserState {

/// 로그인 처리 여부
 bool get isLogin;/// 사용자 닉네임
 String get name;/// 프로필 이미지
 String get profileImage;/// 월 수익 설정 여부
@JsonKey(name: 'hasSalary') bool get isearningsPerSecond;/// 월 급여
@JsonKey(name: 'amount') int get monthlySalary;/// 월급날
 int get payday;/// 초당 수익
@JsonKey(name: 'amountPerSec') double get earningsPerSecond;/// 약관 동의 여부 (Default = true)
 bool get hasAgreedTerm;/// 출석 체크 여부 (Default = false)
 bool get isCheckedIn;
/// Create a copy of UserState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserStateCopyWith<UserState> get copyWith => _$UserStateCopyWithImpl<UserState>(this as UserState, _$identity);

  /// Serializes this UserState to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserState&&(identical(other.isLogin, isLogin) || other.isLogin == isLogin)&&(identical(other.name, name) || other.name == name)&&(identical(other.profileImage, profileImage) || other.profileImage == profileImage)&&(identical(other.isearningsPerSecond, isearningsPerSecond) || other.isearningsPerSecond == isearningsPerSecond)&&(identical(other.monthlySalary, monthlySalary) || other.monthlySalary == monthlySalary)&&(identical(other.payday, payday) || other.payday == payday)&&(identical(other.earningsPerSecond, earningsPerSecond) || other.earningsPerSecond == earningsPerSecond)&&(identical(other.hasAgreedTerm, hasAgreedTerm) || other.hasAgreedTerm == hasAgreedTerm)&&(identical(other.isCheckedIn, isCheckedIn) || other.isCheckedIn == isCheckedIn));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,isLogin,name,profileImage,isearningsPerSecond,monthlySalary,payday,earningsPerSecond,hasAgreedTerm,isCheckedIn);

@override
String toString() {
  return 'UserState(isLogin: $isLogin, name: $name, profileImage: $profileImage, isearningsPerSecond: $isearningsPerSecond, monthlySalary: $monthlySalary, payday: $payday, earningsPerSecond: $earningsPerSecond, hasAgreedTerm: $hasAgreedTerm, isCheckedIn: $isCheckedIn)';
}


}

/// @nodoc
abstract mixin class $UserStateCopyWith<$Res>  {
  factory $UserStateCopyWith(UserState value, $Res Function(UserState) _then) = _$UserStateCopyWithImpl;
@useResult
$Res call({
 bool isLogin, String name, String profileImage,@JsonKey(name: 'hasSalary') bool isearningsPerSecond,@JsonKey(name: 'amount') int monthlySalary, int payday,@JsonKey(name: 'amountPerSec') double earningsPerSecond, bool hasAgreedTerm, bool isCheckedIn
});




}
/// @nodoc
class _$UserStateCopyWithImpl<$Res>
    implements $UserStateCopyWith<$Res> {
  _$UserStateCopyWithImpl(this._self, this._then);

  final UserState _self;
  final $Res Function(UserState) _then;

/// Create a copy of UserState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLogin = null,Object? name = null,Object? profileImage = null,Object? isearningsPerSecond = null,Object? monthlySalary = null,Object? payday = null,Object? earningsPerSecond = null,Object? hasAgreedTerm = null,Object? isCheckedIn = null,}) {
  return _then(_self.copyWith(
isLogin: null == isLogin ? _self.isLogin : isLogin // ignore: cast_nullable_to_non_nullable
as bool,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,profileImage: null == profileImage ? _self.profileImage : profileImage // ignore: cast_nullable_to_non_nullable
as String,isearningsPerSecond: null == isearningsPerSecond ? _self.isearningsPerSecond : isearningsPerSecond // ignore: cast_nullable_to_non_nullable
as bool,monthlySalary: null == monthlySalary ? _self.monthlySalary : monthlySalary // ignore: cast_nullable_to_non_nullable
as int,payday: null == payday ? _self.payday : payday // ignore: cast_nullable_to_non_nullable
as int,earningsPerSecond: null == earningsPerSecond ? _self.earningsPerSecond : earningsPerSecond // ignore: cast_nullable_to_non_nullable
as double,hasAgreedTerm: null == hasAgreedTerm ? _self.hasAgreedTerm : hasAgreedTerm // ignore: cast_nullable_to_non_nullable
as bool,isCheckedIn: null == isCheckedIn ? _self.isCheckedIn : isCheckedIn // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [UserState].
extension UserStatePatterns on UserState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserState value)  $default,){
final _that = this;
switch (_that) {
case _UserState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserState value)?  $default,){
final _that = this;
switch (_that) {
case _UserState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLogin,  String name,  String profileImage, @JsonKey(name: 'hasSalary')  bool isearningsPerSecond, @JsonKey(name: 'amount')  int monthlySalary,  int payday, @JsonKey(name: 'amountPerSec')  double earningsPerSecond,  bool hasAgreedTerm,  bool isCheckedIn)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserState() when $default != null:
return $default(_that.isLogin,_that.name,_that.profileImage,_that.isearningsPerSecond,_that.monthlySalary,_that.payday,_that.earningsPerSecond,_that.hasAgreedTerm,_that.isCheckedIn);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLogin,  String name,  String profileImage, @JsonKey(name: 'hasSalary')  bool isearningsPerSecond, @JsonKey(name: 'amount')  int monthlySalary,  int payday, @JsonKey(name: 'amountPerSec')  double earningsPerSecond,  bool hasAgreedTerm,  bool isCheckedIn)  $default,) {final _that = this;
switch (_that) {
case _UserState():
return $default(_that.isLogin,_that.name,_that.profileImage,_that.isearningsPerSecond,_that.monthlySalary,_that.payday,_that.earningsPerSecond,_that.hasAgreedTerm,_that.isCheckedIn);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLogin,  String name,  String profileImage, @JsonKey(name: 'hasSalary')  bool isearningsPerSecond, @JsonKey(name: 'amount')  int monthlySalary,  int payday, @JsonKey(name: 'amountPerSec')  double earningsPerSecond,  bool hasAgreedTerm,  bool isCheckedIn)?  $default,) {final _that = this;
switch (_that) {
case _UserState() when $default != null:
return $default(_that.isLogin,_that.name,_that.profileImage,_that.isearningsPerSecond,_that.monthlySalary,_that.payday,_that.earningsPerSecond,_that.hasAgreedTerm,_that.isCheckedIn);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserState implements UserState {
  const _UserState({this.isLogin = false, this.name = '', this.profileImage = '', @JsonKey(name: 'hasSalary') this.isearningsPerSecond = false, @JsonKey(name: 'amount') this.monthlySalary = 0, this.payday = 0, @JsonKey(name: 'amountPerSec') this.earningsPerSecond = 0.0, this.hasAgreedTerm = true, this.isCheckedIn = false});
  factory _UserState.fromJson(Map<String, dynamic> json) => _$UserStateFromJson(json);

/// 로그인 처리 여부
@override@JsonKey() final  bool isLogin;
/// 사용자 닉네임
@override@JsonKey() final  String name;
/// 프로필 이미지
@override@JsonKey() final  String profileImage;
/// 월 수익 설정 여부
@override@JsonKey(name: 'hasSalary') final  bool isearningsPerSecond;
/// 월 급여
@override@JsonKey(name: 'amount') final  int monthlySalary;
/// 월급날
@override@JsonKey() final  int payday;
/// 초당 수익
@override@JsonKey(name: 'amountPerSec') final  double earningsPerSecond;
/// 약관 동의 여부 (Default = true)
@override@JsonKey() final  bool hasAgreedTerm;
/// 출석 체크 여부 (Default = false)
@override@JsonKey() final  bool isCheckedIn;

/// Create a copy of UserState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserStateCopyWith<_UserState> get copyWith => __$UserStateCopyWithImpl<_UserState>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserStateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserState&&(identical(other.isLogin, isLogin) || other.isLogin == isLogin)&&(identical(other.name, name) || other.name == name)&&(identical(other.profileImage, profileImage) || other.profileImage == profileImage)&&(identical(other.isearningsPerSecond, isearningsPerSecond) || other.isearningsPerSecond == isearningsPerSecond)&&(identical(other.monthlySalary, monthlySalary) || other.monthlySalary == monthlySalary)&&(identical(other.payday, payday) || other.payday == payday)&&(identical(other.earningsPerSecond, earningsPerSecond) || other.earningsPerSecond == earningsPerSecond)&&(identical(other.hasAgreedTerm, hasAgreedTerm) || other.hasAgreedTerm == hasAgreedTerm)&&(identical(other.isCheckedIn, isCheckedIn) || other.isCheckedIn == isCheckedIn));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,isLogin,name,profileImage,isearningsPerSecond,monthlySalary,payday,earningsPerSecond,hasAgreedTerm,isCheckedIn);

@override
String toString() {
  return 'UserState(isLogin: $isLogin, name: $name, profileImage: $profileImage, isearningsPerSecond: $isearningsPerSecond, monthlySalary: $monthlySalary, payday: $payday, earningsPerSecond: $earningsPerSecond, hasAgreedTerm: $hasAgreedTerm, isCheckedIn: $isCheckedIn)';
}


}

/// @nodoc
abstract mixin class _$UserStateCopyWith<$Res> implements $UserStateCopyWith<$Res> {
  factory _$UserStateCopyWith(_UserState value, $Res Function(_UserState) _then) = __$UserStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLogin, String name, String profileImage,@JsonKey(name: 'hasSalary') bool isearningsPerSecond,@JsonKey(name: 'amount') int monthlySalary, int payday,@JsonKey(name: 'amountPerSec') double earningsPerSecond, bool hasAgreedTerm, bool isCheckedIn
});




}
/// @nodoc
class __$UserStateCopyWithImpl<$Res>
    implements _$UserStateCopyWith<$Res> {
  __$UserStateCopyWithImpl(this._self, this._then);

  final _UserState _self;
  final $Res Function(_UserState) _then;

/// Create a copy of UserState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLogin = null,Object? name = null,Object? profileImage = null,Object? isearningsPerSecond = null,Object? monthlySalary = null,Object? payday = null,Object? earningsPerSecond = null,Object? hasAgreedTerm = null,Object? isCheckedIn = null,}) {
  return _then(_UserState(
isLogin: null == isLogin ? _self.isLogin : isLogin // ignore: cast_nullable_to_non_nullable
as bool,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,profileImage: null == profileImage ? _self.profileImage : profileImage // ignore: cast_nullable_to_non_nullable
as String,isearningsPerSecond: null == isearningsPerSecond ? _self.isearningsPerSecond : isearningsPerSecond // ignore: cast_nullable_to_non_nullable
as bool,monthlySalary: null == monthlySalary ? _self.monthlySalary : monthlySalary // ignore: cast_nullable_to_non_nullable
as int,payday: null == payday ? _self.payday : payday // ignore: cast_nullable_to_non_nullable
as int,earningsPerSecond: null == earningsPerSecond ? _self.earningsPerSecond : earningsPerSecond // ignore: cast_nullable_to_non_nullable
as double,hasAgreedTerm: null == hasAgreedTerm ? _self.hasAgreedTerm : hasAgreedTerm // ignore: cast_nullable_to_non_nullable
as bool,isCheckedIn: null == isCheckedIn ? _self.isCheckedIn : isCheckedIn // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
