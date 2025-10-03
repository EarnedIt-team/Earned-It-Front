// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wish_add_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$WishAddState {

 XFile? get originalImageSource;// 원본 이미지
 XFile? get itemImage;// 수정된 이미지
 bool get isTop5; bool get canSubmit; String get priceError; bool get isLoading;
/// Create a copy of WishAddState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WishAddStateCopyWith<WishAddState> get copyWith => _$WishAddStateCopyWithImpl<WishAddState>(this as WishAddState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WishAddState&&(identical(other.originalImageSource, originalImageSource) || other.originalImageSource == originalImageSource)&&(identical(other.itemImage, itemImage) || other.itemImage == itemImage)&&(identical(other.isTop5, isTop5) || other.isTop5 == isTop5)&&(identical(other.canSubmit, canSubmit) || other.canSubmit == canSubmit)&&(identical(other.priceError, priceError) || other.priceError == priceError)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading));
}


@override
int get hashCode => Object.hash(runtimeType,originalImageSource,itemImage,isTop5,canSubmit,priceError,isLoading);

@override
String toString() {
  return 'WishAddState(originalImageSource: $originalImageSource, itemImage: $itemImage, isTop5: $isTop5, canSubmit: $canSubmit, priceError: $priceError, isLoading: $isLoading)';
}


}

/// @nodoc
abstract mixin class $WishAddStateCopyWith<$Res>  {
  factory $WishAddStateCopyWith(WishAddState value, $Res Function(WishAddState) _then) = _$WishAddStateCopyWithImpl;
@useResult
$Res call({
 XFile? originalImageSource, XFile? itemImage, bool isTop5, bool canSubmit, String priceError, bool isLoading
});




}
/// @nodoc
class _$WishAddStateCopyWithImpl<$Res>
    implements $WishAddStateCopyWith<$Res> {
  _$WishAddStateCopyWithImpl(this._self, this._then);

  final WishAddState _self;
  final $Res Function(WishAddState) _then;

/// Create a copy of WishAddState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? originalImageSource = freezed,Object? itemImage = freezed,Object? isTop5 = null,Object? canSubmit = null,Object? priceError = null,Object? isLoading = null,}) {
  return _then(_self.copyWith(
originalImageSource: freezed == originalImageSource ? _self.originalImageSource : originalImageSource // ignore: cast_nullable_to_non_nullable
as XFile?,itemImage: freezed == itemImage ? _self.itemImage : itemImage // ignore: cast_nullable_to_non_nullable
as XFile?,isTop5: null == isTop5 ? _self.isTop5 : isTop5 // ignore: cast_nullable_to_non_nullable
as bool,canSubmit: null == canSubmit ? _self.canSubmit : canSubmit // ignore: cast_nullable_to_non_nullable
as bool,priceError: null == priceError ? _self.priceError : priceError // ignore: cast_nullable_to_non_nullable
as String,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [WishAddState].
extension WishAddStatePatterns on WishAddState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WishAddState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WishAddState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WishAddState value)  $default,){
final _that = this;
switch (_that) {
case _WishAddState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WishAddState value)?  $default,){
final _that = this;
switch (_that) {
case _WishAddState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( XFile? originalImageSource,  XFile? itemImage,  bool isTop5,  bool canSubmit,  String priceError,  bool isLoading)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WishAddState() when $default != null:
return $default(_that.originalImageSource,_that.itemImage,_that.isTop5,_that.canSubmit,_that.priceError,_that.isLoading);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( XFile? originalImageSource,  XFile? itemImage,  bool isTop5,  bool canSubmit,  String priceError,  bool isLoading)  $default,) {final _that = this;
switch (_that) {
case _WishAddState():
return $default(_that.originalImageSource,_that.itemImage,_that.isTop5,_that.canSubmit,_that.priceError,_that.isLoading);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( XFile? originalImageSource,  XFile? itemImage,  bool isTop5,  bool canSubmit,  String priceError,  bool isLoading)?  $default,) {final _that = this;
switch (_that) {
case _WishAddState() when $default != null:
return $default(_that.originalImageSource,_that.itemImage,_that.isTop5,_that.canSubmit,_that.priceError,_that.isLoading);case _:
  return null;

}
}

}

/// @nodoc


class _WishAddState implements WishAddState {
  const _WishAddState({this.originalImageSource, this.itemImage, this.isTop5 = false, this.canSubmit = false, this.priceError = "", this.isLoading = false});
  

@override final  XFile? originalImageSource;
// 원본 이미지
@override final  XFile? itemImage;
// 수정된 이미지
@override@JsonKey() final  bool isTop5;
@override@JsonKey() final  bool canSubmit;
@override@JsonKey() final  String priceError;
@override@JsonKey() final  bool isLoading;

/// Create a copy of WishAddState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WishAddStateCopyWith<_WishAddState> get copyWith => __$WishAddStateCopyWithImpl<_WishAddState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WishAddState&&(identical(other.originalImageSource, originalImageSource) || other.originalImageSource == originalImageSource)&&(identical(other.itemImage, itemImage) || other.itemImage == itemImage)&&(identical(other.isTop5, isTop5) || other.isTop5 == isTop5)&&(identical(other.canSubmit, canSubmit) || other.canSubmit == canSubmit)&&(identical(other.priceError, priceError) || other.priceError == priceError)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading));
}


@override
int get hashCode => Object.hash(runtimeType,originalImageSource,itemImage,isTop5,canSubmit,priceError,isLoading);

@override
String toString() {
  return 'WishAddState(originalImageSource: $originalImageSource, itemImage: $itemImage, isTop5: $isTop5, canSubmit: $canSubmit, priceError: $priceError, isLoading: $isLoading)';
}


}

/// @nodoc
abstract mixin class _$WishAddStateCopyWith<$Res> implements $WishAddStateCopyWith<$Res> {
  factory _$WishAddStateCopyWith(_WishAddState value, $Res Function(_WishAddState) _then) = __$WishAddStateCopyWithImpl;
@override @useResult
$Res call({
 XFile? originalImageSource, XFile? itemImage, bool isTop5, bool canSubmit, String priceError, bool isLoading
});




}
/// @nodoc
class __$WishAddStateCopyWithImpl<$Res>
    implements _$WishAddStateCopyWith<$Res> {
  __$WishAddStateCopyWithImpl(this._self, this._then);

  final _WishAddState _self;
  final $Res Function(_WishAddState) _then;

/// Create a copy of WishAddState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? originalImageSource = freezed,Object? itemImage = freezed,Object? isTop5 = null,Object? canSubmit = null,Object? priceError = null,Object? isLoading = null,}) {
  return _then(_WishAddState(
originalImageSource: freezed == originalImageSource ? _self.originalImageSource : originalImageSource // ignore: cast_nullable_to_non_nullable
as XFile?,itemImage: freezed == itemImage ? _self.itemImage : itemImage // ignore: cast_nullable_to_non_nullable
as XFile?,isTop5: null == isTop5 ? _self.isTop5 : isTop5 // ignore: cast_nullable_to_non_nullable
as bool,canSubmit: null == canSubmit ? _self.canSubmit : canSubmit // ignore: cast_nullable_to_non_nullable
as bool,priceError: null == priceError ? _self.priceError : priceError // ignore: cast_nullable_to_non_nullable
as String,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
