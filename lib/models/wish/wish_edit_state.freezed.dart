// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wish_edit_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$WishEditState {

 WishModel? get initialWish;// 수정 전 원본 데이터
 XFile? get imageForUpload;// 새로 선택했거나, 기존 이미지를 다운로드한 파일
 bool get isTop5; bool get canSubmit; bool get isLoading;
/// Create a copy of WishEditState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WishEditStateCopyWith<WishEditState> get copyWith => _$WishEditStateCopyWithImpl<WishEditState>(this as WishEditState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WishEditState&&(identical(other.initialWish, initialWish) || other.initialWish == initialWish)&&(identical(other.imageForUpload, imageForUpload) || other.imageForUpload == imageForUpload)&&(identical(other.isTop5, isTop5) || other.isTop5 == isTop5)&&(identical(other.canSubmit, canSubmit) || other.canSubmit == canSubmit)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading));
}


@override
int get hashCode => Object.hash(runtimeType,initialWish,imageForUpload,isTop5,canSubmit,isLoading);

@override
String toString() {
  return 'WishEditState(initialWish: $initialWish, imageForUpload: $imageForUpload, isTop5: $isTop5, canSubmit: $canSubmit, isLoading: $isLoading)';
}


}

/// @nodoc
abstract mixin class $WishEditStateCopyWith<$Res>  {
  factory $WishEditStateCopyWith(WishEditState value, $Res Function(WishEditState) _then) = _$WishEditStateCopyWithImpl;
@useResult
$Res call({
 WishModel? initialWish, XFile? imageForUpload, bool isTop5, bool canSubmit, bool isLoading
});


$WishModelCopyWith<$Res>? get initialWish;

}
/// @nodoc
class _$WishEditStateCopyWithImpl<$Res>
    implements $WishEditStateCopyWith<$Res> {
  _$WishEditStateCopyWithImpl(this._self, this._then);

  final WishEditState _self;
  final $Res Function(WishEditState) _then;

/// Create a copy of WishEditState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? initialWish = freezed,Object? imageForUpload = freezed,Object? isTop5 = null,Object? canSubmit = null,Object? isLoading = null,}) {
  return _then(_self.copyWith(
initialWish: freezed == initialWish ? _self.initialWish : initialWish // ignore: cast_nullable_to_non_nullable
as WishModel?,imageForUpload: freezed == imageForUpload ? _self.imageForUpload : imageForUpload // ignore: cast_nullable_to_non_nullable
as XFile?,isTop5: null == isTop5 ? _self.isTop5 : isTop5 // ignore: cast_nullable_to_non_nullable
as bool,canSubmit: null == canSubmit ? _self.canSubmit : canSubmit // ignore: cast_nullable_to_non_nullable
as bool,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of WishEditState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WishModelCopyWith<$Res>? get initialWish {
    if (_self.initialWish == null) {
    return null;
  }

  return $WishModelCopyWith<$Res>(_self.initialWish!, (value) {
    return _then(_self.copyWith(initialWish: value));
  });
}
}


/// Adds pattern-matching-related methods to [WishEditState].
extension WishEditStatePatterns on WishEditState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WishEditState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WishEditState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WishEditState value)  $default,){
final _that = this;
switch (_that) {
case _WishEditState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WishEditState value)?  $default,){
final _that = this;
switch (_that) {
case _WishEditState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( WishModel? initialWish,  XFile? imageForUpload,  bool isTop5,  bool canSubmit,  bool isLoading)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WishEditState() when $default != null:
return $default(_that.initialWish,_that.imageForUpload,_that.isTop5,_that.canSubmit,_that.isLoading);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( WishModel? initialWish,  XFile? imageForUpload,  bool isTop5,  bool canSubmit,  bool isLoading)  $default,) {final _that = this;
switch (_that) {
case _WishEditState():
return $default(_that.initialWish,_that.imageForUpload,_that.isTop5,_that.canSubmit,_that.isLoading);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( WishModel? initialWish,  XFile? imageForUpload,  bool isTop5,  bool canSubmit,  bool isLoading)?  $default,) {final _that = this;
switch (_that) {
case _WishEditState() when $default != null:
return $default(_that.initialWish,_that.imageForUpload,_that.isTop5,_that.canSubmit,_that.isLoading);case _:
  return null;

}
}

}

/// @nodoc


class _WishEditState implements WishEditState {
  const _WishEditState({this.initialWish, this.imageForUpload, this.isTop5 = false, this.canSubmit = false, this.isLoading = false});
  

@override final  WishModel? initialWish;
// 수정 전 원본 데이터
@override final  XFile? imageForUpload;
// 새로 선택했거나, 기존 이미지를 다운로드한 파일
@override@JsonKey() final  bool isTop5;
@override@JsonKey() final  bool canSubmit;
@override@JsonKey() final  bool isLoading;

/// Create a copy of WishEditState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WishEditStateCopyWith<_WishEditState> get copyWith => __$WishEditStateCopyWithImpl<_WishEditState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WishEditState&&(identical(other.initialWish, initialWish) || other.initialWish == initialWish)&&(identical(other.imageForUpload, imageForUpload) || other.imageForUpload == imageForUpload)&&(identical(other.isTop5, isTop5) || other.isTop5 == isTop5)&&(identical(other.canSubmit, canSubmit) || other.canSubmit == canSubmit)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading));
}


@override
int get hashCode => Object.hash(runtimeType,initialWish,imageForUpload,isTop5,canSubmit,isLoading);

@override
String toString() {
  return 'WishEditState(initialWish: $initialWish, imageForUpload: $imageForUpload, isTop5: $isTop5, canSubmit: $canSubmit, isLoading: $isLoading)';
}


}

/// @nodoc
abstract mixin class _$WishEditStateCopyWith<$Res> implements $WishEditStateCopyWith<$Res> {
  factory _$WishEditStateCopyWith(_WishEditState value, $Res Function(_WishEditState) _then) = __$WishEditStateCopyWithImpl;
@override @useResult
$Res call({
 WishModel? initialWish, XFile? imageForUpload, bool isTop5, bool canSubmit, bool isLoading
});


@override $WishModelCopyWith<$Res>? get initialWish;

}
/// @nodoc
class __$WishEditStateCopyWithImpl<$Res>
    implements _$WishEditStateCopyWith<$Res> {
  __$WishEditStateCopyWithImpl(this._self, this._then);

  final _WishEditState _self;
  final $Res Function(_WishEditState) _then;

/// Create a copy of WishEditState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? initialWish = freezed,Object? imageForUpload = freezed,Object? isTop5 = null,Object? canSubmit = null,Object? isLoading = null,}) {
  return _then(_WishEditState(
initialWish: freezed == initialWish ? _self.initialWish : initialWish // ignore: cast_nullable_to_non_nullable
as WishModel?,imageForUpload: freezed == imageForUpload ? _self.imageForUpload : imageForUpload // ignore: cast_nullable_to_non_nullable
as XFile?,isTop5: null == isTop5 ? _self.isTop5 : isTop5 // ignore: cast_nullable_to_non_nullable
as bool,canSubmit: null == canSubmit ? _self.canSubmit : canSubmit // ignore: cast_nullable_to_non_nullable
as bool,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of WishEditState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WishModelCopyWith<$Res>? get initialWish {
    if (_self.initialWish == null) {
    return null;
  }

  return $WishModelCopyWith<$Res>(_self.initialWish!, (value) {
    return _then(_self.copyWith(initialWish: value));
  });
}
}

// dart format on
