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
 XFile? get originalImageSource;// 편집의 기준이 될 원본 이미지
 XFile? get itemImage;// 화면에 표시되고 최종 업로드될 이미지 (편집 결과물)
 bool get imageHasChanged;// 이미지가 변경되었는지 여부
 bool get isTop5; bool get canSubmit; String get priceError; bool get isLoading;
/// Create a copy of WishEditState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WishEditStateCopyWith<WishEditState> get copyWith => _$WishEditStateCopyWithImpl<WishEditState>(this as WishEditState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WishEditState&&(identical(other.initialWish, initialWish) || other.initialWish == initialWish)&&(identical(other.originalImageSource, originalImageSource) || other.originalImageSource == originalImageSource)&&(identical(other.itemImage, itemImage) || other.itemImage == itemImage)&&(identical(other.imageHasChanged, imageHasChanged) || other.imageHasChanged == imageHasChanged)&&(identical(other.isTop5, isTop5) || other.isTop5 == isTop5)&&(identical(other.canSubmit, canSubmit) || other.canSubmit == canSubmit)&&(identical(other.priceError, priceError) || other.priceError == priceError)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading));
}


@override
int get hashCode => Object.hash(runtimeType,initialWish,originalImageSource,itemImage,imageHasChanged,isTop5,canSubmit,priceError,isLoading);

@override
String toString() {
  return 'WishEditState(initialWish: $initialWish, originalImageSource: $originalImageSource, itemImage: $itemImage, imageHasChanged: $imageHasChanged, isTop5: $isTop5, canSubmit: $canSubmit, priceError: $priceError, isLoading: $isLoading)';
}


}

/// @nodoc
abstract mixin class $WishEditStateCopyWith<$Res>  {
  factory $WishEditStateCopyWith(WishEditState value, $Res Function(WishEditState) _then) = _$WishEditStateCopyWithImpl;
@useResult
$Res call({
 WishModel? initialWish, XFile? originalImageSource, XFile? itemImage, bool imageHasChanged, bool isTop5, bool canSubmit, String priceError, bool isLoading
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
@pragma('vm:prefer-inline') @override $Res call({Object? initialWish = freezed,Object? originalImageSource = freezed,Object? itemImage = freezed,Object? imageHasChanged = null,Object? isTop5 = null,Object? canSubmit = null,Object? priceError = null,Object? isLoading = null,}) {
  return _then(_self.copyWith(
initialWish: freezed == initialWish ? _self.initialWish : initialWish // ignore: cast_nullable_to_non_nullable
as WishModel?,originalImageSource: freezed == originalImageSource ? _self.originalImageSource : originalImageSource // ignore: cast_nullable_to_non_nullable
as XFile?,itemImage: freezed == itemImage ? _self.itemImage : itemImage // ignore: cast_nullable_to_non_nullable
as XFile?,imageHasChanged: null == imageHasChanged ? _self.imageHasChanged : imageHasChanged // ignore: cast_nullable_to_non_nullable
as bool,isTop5: null == isTop5 ? _self.isTop5 : isTop5 // ignore: cast_nullable_to_non_nullable
as bool,canSubmit: null == canSubmit ? _self.canSubmit : canSubmit // ignore: cast_nullable_to_non_nullable
as bool,priceError: null == priceError ? _self.priceError : priceError // ignore: cast_nullable_to_non_nullable
as String,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( WishModel? initialWish,  XFile? originalImageSource,  XFile? itemImage,  bool imageHasChanged,  bool isTop5,  bool canSubmit,  String priceError,  bool isLoading)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WishEditState() when $default != null:
return $default(_that.initialWish,_that.originalImageSource,_that.itemImage,_that.imageHasChanged,_that.isTop5,_that.canSubmit,_that.priceError,_that.isLoading);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( WishModel? initialWish,  XFile? originalImageSource,  XFile? itemImage,  bool imageHasChanged,  bool isTop5,  bool canSubmit,  String priceError,  bool isLoading)  $default,) {final _that = this;
switch (_that) {
case _WishEditState():
return $default(_that.initialWish,_that.originalImageSource,_that.itemImage,_that.imageHasChanged,_that.isTop5,_that.canSubmit,_that.priceError,_that.isLoading);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( WishModel? initialWish,  XFile? originalImageSource,  XFile? itemImage,  bool imageHasChanged,  bool isTop5,  bool canSubmit,  String priceError,  bool isLoading)?  $default,) {final _that = this;
switch (_that) {
case _WishEditState() when $default != null:
return $default(_that.initialWish,_that.originalImageSource,_that.itemImage,_that.imageHasChanged,_that.isTop5,_that.canSubmit,_that.priceError,_that.isLoading);case _:
  return null;

}
}

}

/// @nodoc


class _WishEditState implements WishEditState {
  const _WishEditState({this.initialWish, this.originalImageSource, this.itemImage, this.imageHasChanged = false, this.isTop5 = false, this.canSubmit = false, this.priceError = "", this.isLoading = false});
  

@override final  WishModel? initialWish;
// 수정 전 원본 데이터
@override final  XFile? originalImageSource;
// 편집의 기준이 될 원본 이미지
@override final  XFile? itemImage;
// 화면에 표시되고 최종 업로드될 이미지 (편집 결과물)
@override@JsonKey() final  bool imageHasChanged;
// 이미지가 변경되었는지 여부
@override@JsonKey() final  bool isTop5;
@override@JsonKey() final  bool canSubmit;
@override@JsonKey() final  String priceError;
@override@JsonKey() final  bool isLoading;

/// Create a copy of WishEditState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WishEditStateCopyWith<_WishEditState> get copyWith => __$WishEditStateCopyWithImpl<_WishEditState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WishEditState&&(identical(other.initialWish, initialWish) || other.initialWish == initialWish)&&(identical(other.originalImageSource, originalImageSource) || other.originalImageSource == originalImageSource)&&(identical(other.itemImage, itemImage) || other.itemImage == itemImage)&&(identical(other.imageHasChanged, imageHasChanged) || other.imageHasChanged == imageHasChanged)&&(identical(other.isTop5, isTop5) || other.isTop5 == isTop5)&&(identical(other.canSubmit, canSubmit) || other.canSubmit == canSubmit)&&(identical(other.priceError, priceError) || other.priceError == priceError)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading));
}


@override
int get hashCode => Object.hash(runtimeType,initialWish,originalImageSource,itemImage,imageHasChanged,isTop5,canSubmit,priceError,isLoading);

@override
String toString() {
  return 'WishEditState(initialWish: $initialWish, originalImageSource: $originalImageSource, itemImage: $itemImage, imageHasChanged: $imageHasChanged, isTop5: $isTop5, canSubmit: $canSubmit, priceError: $priceError, isLoading: $isLoading)';
}


}

/// @nodoc
abstract mixin class _$WishEditStateCopyWith<$Res> implements $WishEditStateCopyWith<$Res> {
  factory _$WishEditStateCopyWith(_WishEditState value, $Res Function(_WishEditState) _then) = __$WishEditStateCopyWithImpl;
@override @useResult
$Res call({
 WishModel? initialWish, XFile? originalImageSource, XFile? itemImage, bool imageHasChanged, bool isTop5, bool canSubmit, String priceError, bool isLoading
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
@override @pragma('vm:prefer-inline') $Res call({Object? initialWish = freezed,Object? originalImageSource = freezed,Object? itemImage = freezed,Object? imageHasChanged = null,Object? isTop5 = null,Object? canSubmit = null,Object? priceError = null,Object? isLoading = null,}) {
  return _then(_WishEditState(
initialWish: freezed == initialWish ? _self.initialWish : initialWish // ignore: cast_nullable_to_non_nullable
as WishModel?,originalImageSource: freezed == originalImageSource ? _self.originalImageSource : originalImageSource // ignore: cast_nullable_to_non_nullable
as XFile?,itemImage: freezed == itemImage ? _self.itemImage : itemImage // ignore: cast_nullable_to_non_nullable
as XFile?,imageHasChanged: null == imageHasChanged ? _self.imageHasChanged : imageHasChanged // ignore: cast_nullable_to_non_nullable
as bool,isTop5: null == isTop5 ? _self.isTop5 : isTop5 // ignore: cast_nullable_to_non_nullable
as bool,canSubmit: null == canSubmit ? _self.canSubmit : canSubmit // ignore: cast_nullable_to_non_nullable
as bool,priceError: null == priceError ? _self.priceError : priceError // ignore: cast_nullable_to_non_nullable
as String,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
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
