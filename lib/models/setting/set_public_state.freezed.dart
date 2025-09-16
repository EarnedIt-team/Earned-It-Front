// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'set_public_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SetPublicState {

// 현재 사용자의 공개 설정 여부 (true: 공개)
 bool get isPublic;// API 통신 중 로딩 상태
 bool get isLoading;
/// Create a copy of SetPublicState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SetPublicStateCopyWith<SetPublicState> get copyWith => _$SetPublicStateCopyWithImpl<SetPublicState>(this as SetPublicState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SetPublicState&&(identical(other.isPublic, isPublic) || other.isPublic == isPublic)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading));
}


@override
int get hashCode => Object.hash(runtimeType,isPublic,isLoading);

@override
String toString() {
  return 'SetPublicState(isPublic: $isPublic, isLoading: $isLoading)';
}


}

/// @nodoc
abstract mixin class $SetPublicStateCopyWith<$Res>  {
  factory $SetPublicStateCopyWith(SetPublicState value, $Res Function(SetPublicState) _then) = _$SetPublicStateCopyWithImpl;
@useResult
$Res call({
 bool isPublic, bool isLoading
});




}
/// @nodoc
class _$SetPublicStateCopyWithImpl<$Res>
    implements $SetPublicStateCopyWith<$Res> {
  _$SetPublicStateCopyWithImpl(this._self, this._then);

  final SetPublicState _self;
  final $Res Function(SetPublicState) _then;

/// Create a copy of SetPublicState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isPublic = null,Object? isLoading = null,}) {
  return _then(_self.copyWith(
isPublic: null == isPublic ? _self.isPublic : isPublic // ignore: cast_nullable_to_non_nullable
as bool,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [SetPublicState].
extension SetPublicStatePatterns on SetPublicState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SetPublicState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SetPublicState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SetPublicState value)  $default,){
final _that = this;
switch (_that) {
case _SetPublicState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SetPublicState value)?  $default,){
final _that = this;
switch (_that) {
case _SetPublicState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isPublic,  bool isLoading)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SetPublicState() when $default != null:
return $default(_that.isPublic,_that.isLoading);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isPublic,  bool isLoading)  $default,) {final _that = this;
switch (_that) {
case _SetPublicState():
return $default(_that.isPublic,_that.isLoading);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isPublic,  bool isLoading)?  $default,) {final _that = this;
switch (_that) {
case _SetPublicState() when $default != null:
return $default(_that.isPublic,_that.isLoading);case _:
  return null;

}
}

}

/// @nodoc


class _SetPublicState implements SetPublicState {
  const _SetPublicState({this.isPublic = true, this.isLoading = false});
  

// 현재 사용자의 공개 설정 여부 (true: 공개)
@override@JsonKey() final  bool isPublic;
// API 통신 중 로딩 상태
@override@JsonKey() final  bool isLoading;

/// Create a copy of SetPublicState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SetPublicStateCopyWith<_SetPublicState> get copyWith => __$SetPublicStateCopyWithImpl<_SetPublicState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SetPublicState&&(identical(other.isPublic, isPublic) || other.isPublic == isPublic)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading));
}


@override
int get hashCode => Object.hash(runtimeType,isPublic,isLoading);

@override
String toString() {
  return 'SetPublicState(isPublic: $isPublic, isLoading: $isLoading)';
}


}

/// @nodoc
abstract mixin class _$SetPublicStateCopyWith<$Res> implements $SetPublicStateCopyWith<$Res> {
  factory _$SetPublicStateCopyWith(_SetPublicState value, $Res Function(_SetPublicState) _then) = __$SetPublicStateCopyWithImpl;
@override @useResult
$Res call({
 bool isPublic, bool isLoading
});




}
/// @nodoc
class __$SetPublicStateCopyWithImpl<$Res>
    implements _$SetPublicStateCopyWith<$Res> {
  __$SetPublicStateCopyWithImpl(this._self, this._then);

  final _SetPublicState _self;
  final $Res Function(_SetPublicState) _then;

/// Create a copy of SetPublicState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isPublic = null,Object? isLoading = null,}) {
  return _then(_SetPublicState(
isPublic: null == isPublic ? _self.isPublic : isPublic // ignore: cast_nullable_to_non_nullable
as bool,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
