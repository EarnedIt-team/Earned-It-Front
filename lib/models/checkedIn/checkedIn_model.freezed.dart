// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'checkedIn_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CheckedinModel {

 int? get itemId; String? get name; String? get image; int? get price;
/// Create a copy of CheckedinModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CheckedinModelCopyWith<CheckedinModel> get copyWith => _$CheckedinModelCopyWithImpl<CheckedinModel>(this as CheckedinModel, _$identity);

  /// Serializes this CheckedinModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CheckedinModel&&(identical(other.itemId, itemId) || other.itemId == itemId)&&(identical(other.name, name) || other.name == name)&&(identical(other.image, image) || other.image == image)&&(identical(other.price, price) || other.price == price));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,itemId,name,image,price);

@override
String toString() {
  return 'CheckedinModel(itemId: $itemId, name: $name, image: $image, price: $price)';
}


}

/// @nodoc
abstract mixin class $CheckedinModelCopyWith<$Res>  {
  factory $CheckedinModelCopyWith(CheckedinModel value, $Res Function(CheckedinModel) _then) = _$CheckedinModelCopyWithImpl;
@useResult
$Res call({
 int? itemId, String? name, String? image, int? price
});




}
/// @nodoc
class _$CheckedinModelCopyWithImpl<$Res>
    implements $CheckedinModelCopyWith<$Res> {
  _$CheckedinModelCopyWithImpl(this._self, this._then);

  final CheckedinModel _self;
  final $Res Function(CheckedinModel) _then;

/// Create a copy of CheckedinModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? itemId = freezed,Object? name = freezed,Object? image = freezed,Object? price = freezed,}) {
  return _then(_self.copyWith(
itemId: freezed == itemId ? _self.itemId : itemId // ignore: cast_nullable_to_non_nullable
as int?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String?,price: freezed == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [CheckedinModel].
extension CheckedinModelPatterns on CheckedinModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CheckedinModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CheckedinModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CheckedinModel value)  $default,){
final _that = this;
switch (_that) {
case _CheckedinModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CheckedinModel value)?  $default,){
final _that = this;
switch (_that) {
case _CheckedinModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? itemId,  String? name,  String? image,  int? price)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CheckedinModel() when $default != null:
return $default(_that.itemId,_that.name,_that.image,_that.price);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? itemId,  String? name,  String? image,  int? price)  $default,) {final _that = this;
switch (_that) {
case _CheckedinModel():
return $default(_that.itemId,_that.name,_that.image,_that.price);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? itemId,  String? name,  String? image,  int? price)?  $default,) {final _that = this;
switch (_that) {
case _CheckedinModel() when $default != null:
return $default(_that.itemId,_that.name,_that.image,_that.price);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CheckedinModel implements CheckedinModel {
  const _CheckedinModel({this.itemId, this.name, this.image, this.price});
  factory _CheckedinModel.fromJson(Map<String, dynamic> json) => _$CheckedinModelFromJson(json);

@override final  int? itemId;
@override final  String? name;
@override final  String? image;
@override final  int? price;

/// Create a copy of CheckedinModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CheckedinModelCopyWith<_CheckedinModel> get copyWith => __$CheckedinModelCopyWithImpl<_CheckedinModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CheckedinModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CheckedinModel&&(identical(other.itemId, itemId) || other.itemId == itemId)&&(identical(other.name, name) || other.name == name)&&(identical(other.image, image) || other.image == image)&&(identical(other.price, price) || other.price == price));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,itemId,name,image,price);

@override
String toString() {
  return 'CheckedinModel(itemId: $itemId, name: $name, image: $image, price: $price)';
}


}

/// @nodoc
abstract mixin class _$CheckedinModelCopyWith<$Res> implements $CheckedinModelCopyWith<$Res> {
  factory _$CheckedinModelCopyWith(_CheckedinModel value, $Res Function(_CheckedinModel) _then) = __$CheckedinModelCopyWithImpl;
@override @useResult
$Res call({
 int? itemId, String? name, String? image, int? price
});




}
/// @nodoc
class __$CheckedinModelCopyWithImpl<$Res>
    implements _$CheckedinModelCopyWith<$Res> {
  __$CheckedinModelCopyWithImpl(this._self, this._then);

  final _CheckedinModel _self;
  final $Res Function(_CheckedinModel) _then;

/// Create a copy of CheckedinModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? itemId = freezed,Object? name = freezed,Object? image = freezed,Object? price = freezed,}) {
  return _then(_CheckedinModel(
itemId: freezed == itemId ? _self.itemId : itemId // ignore: cast_nullable_to_non_nullable
as int?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String?,price: freezed == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
