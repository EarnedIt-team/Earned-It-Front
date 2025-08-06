// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'nickname_edit_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$NicknameEditState {

 String? get initialNickname;// 수정 전 원본 닉네임
 String? get validationError;// 유효성 검사 에러 메시지
 bool get canSubmit;// 버튼 활성화 여부
 bool get isLoading;
/// Create a copy of NicknameEditState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NicknameEditStateCopyWith<NicknameEditState> get copyWith => _$NicknameEditStateCopyWithImpl<NicknameEditState>(this as NicknameEditState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NicknameEditState&&(identical(other.initialNickname, initialNickname) || other.initialNickname == initialNickname)&&(identical(other.validationError, validationError) || other.validationError == validationError)&&(identical(other.canSubmit, canSubmit) || other.canSubmit == canSubmit)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading));
}


@override
int get hashCode => Object.hash(runtimeType,initialNickname,validationError,canSubmit,isLoading);

@override
String toString() {
  return 'NicknameEditState(initialNickname: $initialNickname, validationError: $validationError, canSubmit: $canSubmit, isLoading: $isLoading)';
}


}

/// @nodoc
abstract mixin class $NicknameEditStateCopyWith<$Res>  {
  factory $NicknameEditStateCopyWith(NicknameEditState value, $Res Function(NicknameEditState) _then) = _$NicknameEditStateCopyWithImpl;
@useResult
$Res call({
 String? initialNickname, String? validationError, bool canSubmit, bool isLoading
});




}
/// @nodoc
class _$NicknameEditStateCopyWithImpl<$Res>
    implements $NicknameEditStateCopyWith<$Res> {
  _$NicknameEditStateCopyWithImpl(this._self, this._then);

  final NicknameEditState _self;
  final $Res Function(NicknameEditState) _then;

/// Create a copy of NicknameEditState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? initialNickname = freezed,Object? validationError = freezed,Object? canSubmit = null,Object? isLoading = null,}) {
  return _then(_self.copyWith(
initialNickname: freezed == initialNickname ? _self.initialNickname : initialNickname // ignore: cast_nullable_to_non_nullable
as String?,validationError: freezed == validationError ? _self.validationError : validationError // ignore: cast_nullable_to_non_nullable
as String?,canSubmit: null == canSubmit ? _self.canSubmit : canSubmit // ignore: cast_nullable_to_non_nullable
as bool,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [NicknameEditState].
extension NicknameEditStatePatterns on NicknameEditState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NicknameEditState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NicknameEditState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NicknameEditState value)  $default,){
final _that = this;
switch (_that) {
case _NicknameEditState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NicknameEditState value)?  $default,){
final _that = this;
switch (_that) {
case _NicknameEditState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? initialNickname,  String? validationError,  bool canSubmit,  bool isLoading)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NicknameEditState() when $default != null:
return $default(_that.initialNickname,_that.validationError,_that.canSubmit,_that.isLoading);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? initialNickname,  String? validationError,  bool canSubmit,  bool isLoading)  $default,) {final _that = this;
switch (_that) {
case _NicknameEditState():
return $default(_that.initialNickname,_that.validationError,_that.canSubmit,_that.isLoading);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? initialNickname,  String? validationError,  bool canSubmit,  bool isLoading)?  $default,) {final _that = this;
switch (_that) {
case _NicknameEditState() when $default != null:
return $default(_that.initialNickname,_that.validationError,_that.canSubmit,_that.isLoading);case _:
  return null;

}
}

}

/// @nodoc


class _NicknameEditState implements NicknameEditState {
  const _NicknameEditState({this.initialNickname, this.validationError, this.canSubmit = false, this.isLoading = false});
  

@override final  String? initialNickname;
// 수정 전 원본 닉네임
@override final  String? validationError;
// 유효성 검사 에러 메시지
@override@JsonKey() final  bool canSubmit;
// 버튼 활성화 여부
@override@JsonKey() final  bool isLoading;

/// Create a copy of NicknameEditState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NicknameEditStateCopyWith<_NicknameEditState> get copyWith => __$NicknameEditStateCopyWithImpl<_NicknameEditState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NicknameEditState&&(identical(other.initialNickname, initialNickname) || other.initialNickname == initialNickname)&&(identical(other.validationError, validationError) || other.validationError == validationError)&&(identical(other.canSubmit, canSubmit) || other.canSubmit == canSubmit)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading));
}


@override
int get hashCode => Object.hash(runtimeType,initialNickname,validationError,canSubmit,isLoading);

@override
String toString() {
  return 'NicknameEditState(initialNickname: $initialNickname, validationError: $validationError, canSubmit: $canSubmit, isLoading: $isLoading)';
}


}

/// @nodoc
abstract mixin class _$NicknameEditStateCopyWith<$Res> implements $NicknameEditStateCopyWith<$Res> {
  factory _$NicknameEditStateCopyWith(_NicknameEditState value, $Res Function(_NicknameEditState) _then) = __$NicknameEditStateCopyWithImpl;
@override @useResult
$Res call({
 String? initialNickname, String? validationError, bool canSubmit, bool isLoading
});




}
/// @nodoc
class __$NicknameEditStateCopyWithImpl<$Res>
    implements _$NicknameEditStateCopyWith<$Res> {
  __$NicknameEditStateCopyWithImpl(this._self, this._then);

  final _NicknameEditState _self;
  final $Res Function(_NicknameEditState) _then;

/// Create a copy of NicknameEditState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? initialNickname = freezed,Object? validationError = freezed,Object? canSubmit = null,Object? isLoading = null,}) {
  return _then(_NicknameEditState(
initialNickname: freezed == initialNickname ? _self.initialNickname : initialNickname // ignore: cast_nullable_to_non_nullable
as String?,validationError: freezed == validationError ? _self.validationError : validationError // ignore: cast_nullable_to_non_nullable
as String?,canSubmit: null == canSubmit ? _self.canSubmit : canSubmit // ignore: cast_nullable_to_non_nullable
as bool,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
