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

/// 월 수익 설정 여부
 bool get isearningsPerSecond;/// 월 급여
 int get monthlySalary;/// 월급날
 int get payday;/// 초당 수익
 double get earningsPerSecond;
/// Create a copy of UserState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserStateCopyWith<UserState> get copyWith => _$UserStateCopyWithImpl<UserState>(this as UserState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserState&&(identical(other.isearningsPerSecond, isearningsPerSecond) || other.isearningsPerSecond == isearningsPerSecond)&&(identical(other.monthlySalary, monthlySalary) || other.monthlySalary == monthlySalary)&&(identical(other.payday, payday) || other.payday == payday)&&(identical(other.earningsPerSecond, earningsPerSecond) || other.earningsPerSecond == earningsPerSecond));
}


@override
int get hashCode => Object.hash(runtimeType,isearningsPerSecond,monthlySalary,payday,earningsPerSecond);

@override
String toString() {
  return 'UserState(isearningsPerSecond: $isearningsPerSecond, monthlySalary: $monthlySalary, payday: $payday, earningsPerSecond: $earningsPerSecond)';
}


}

/// @nodoc
abstract mixin class $UserStateCopyWith<$Res>  {
  factory $UserStateCopyWith(UserState value, $Res Function(UserState) _then) = _$UserStateCopyWithImpl;
@useResult
$Res call({
 bool isearningsPerSecond, int monthlySalary, int payday, double earningsPerSecond
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
@pragma('vm:prefer-inline') @override $Res call({Object? isearningsPerSecond = null,Object? monthlySalary = null,Object? payday = null,Object? earningsPerSecond = null,}) {
  return _then(_self.copyWith(
isearningsPerSecond: null == isearningsPerSecond ? _self.isearningsPerSecond : isearningsPerSecond // ignore: cast_nullable_to_non_nullable
as bool,monthlySalary: null == monthlySalary ? _self.monthlySalary : monthlySalary // ignore: cast_nullable_to_non_nullable
as int,payday: null == payday ? _self.payday : payday // ignore: cast_nullable_to_non_nullable
as int,earningsPerSecond: null == earningsPerSecond ? _self.earningsPerSecond : earningsPerSecond // ignore: cast_nullable_to_non_nullable
as double,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isearningsPerSecond,  int monthlySalary,  int payday,  double earningsPerSecond)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserState() when $default != null:
return $default(_that.isearningsPerSecond,_that.monthlySalary,_that.payday,_that.earningsPerSecond);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isearningsPerSecond,  int monthlySalary,  int payday,  double earningsPerSecond)  $default,) {final _that = this;
switch (_that) {
case _UserState():
return $default(_that.isearningsPerSecond,_that.monthlySalary,_that.payday,_that.earningsPerSecond);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isearningsPerSecond,  int monthlySalary,  int payday,  double earningsPerSecond)?  $default,) {final _that = this;
switch (_that) {
case _UserState() when $default != null:
return $default(_that.isearningsPerSecond,_that.monthlySalary,_that.payday,_that.earningsPerSecond);case _:
  return null;

}
}

}

/// @nodoc


class _UserState implements UserState {
  const _UserState({this.isearningsPerSecond = false, this.monthlySalary = 0, this.payday = 0, this.earningsPerSecond = 0.0});
  

/// 월 수익 설정 여부
@override@JsonKey() final  bool isearningsPerSecond;
/// 월 급여
@override@JsonKey() final  int monthlySalary;
/// 월급날
@override@JsonKey() final  int payday;
/// 초당 수익
@override@JsonKey() final  double earningsPerSecond;

/// Create a copy of UserState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserStateCopyWith<_UserState> get copyWith => __$UserStateCopyWithImpl<_UserState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserState&&(identical(other.isearningsPerSecond, isearningsPerSecond) || other.isearningsPerSecond == isearningsPerSecond)&&(identical(other.monthlySalary, monthlySalary) || other.monthlySalary == monthlySalary)&&(identical(other.payday, payday) || other.payday == payday)&&(identical(other.earningsPerSecond, earningsPerSecond) || other.earningsPerSecond == earningsPerSecond));
}


@override
int get hashCode => Object.hash(runtimeType,isearningsPerSecond,monthlySalary,payday,earningsPerSecond);

@override
String toString() {
  return 'UserState(isearningsPerSecond: $isearningsPerSecond, monthlySalary: $monthlySalary, payday: $payday, earningsPerSecond: $earningsPerSecond)';
}


}

/// @nodoc
abstract mixin class _$UserStateCopyWith<$Res> implements $UserStateCopyWith<$Res> {
  factory _$UserStateCopyWith(_UserState value, $Res Function(_UserState) _then) = __$UserStateCopyWithImpl;
@override @useResult
$Res call({
 bool isearningsPerSecond, int monthlySalary, int payday, double earningsPerSecond
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
@override @pragma('vm:prefer-inline') $Res call({Object? isearningsPerSecond = null,Object? monthlySalary = null,Object? payday = null,Object? earningsPerSecond = null,}) {
  return _then(_UserState(
isearningsPerSecond: null == isearningsPerSecond ? _self.isearningsPerSecond : isearningsPerSecond // ignore: cast_nullable_to_non_nullable
as bool,monthlySalary: null == monthlySalary ? _self.monthlySalary : monthlySalary // ignore: cast_nullable_to_non_nullable
as int,payday: null == payday ? _self.payday : payday // ignore: cast_nullable_to_non_nullable
as int,earningsPerSecond: null == earningsPerSecond ? _self.earningsPerSecond : earningsPerSecond // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
