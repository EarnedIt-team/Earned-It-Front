// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wish_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WishModel {

 int get wishId; int get userId; String get name; int get price; String get itemImage; String get vendor; String get createdAt; String get url; bool get bought; bool get starred;
/// Create a copy of WishModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WishModelCopyWith<WishModel> get copyWith => _$WishModelCopyWithImpl<WishModel>(this as WishModel, _$identity);

  /// Serializes this WishModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WishModel&&(identical(other.wishId, wishId) || other.wishId == wishId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.name, name) || other.name == name)&&(identical(other.price, price) || other.price == price)&&(identical(other.itemImage, itemImage) || other.itemImage == itemImage)&&(identical(other.vendor, vendor) || other.vendor == vendor)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.url, url) || other.url == url)&&(identical(other.bought, bought) || other.bought == bought)&&(identical(other.starred, starred) || other.starred == starred));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,wishId,userId,name,price,itemImage,vendor,createdAt,url,bought,starred);

@override
String toString() {
  return 'WishModel(wishId: $wishId, userId: $userId, name: $name, price: $price, itemImage: $itemImage, vendor: $vendor, createdAt: $createdAt, url: $url, bought: $bought, starred: $starred)';
}


}

/// @nodoc
abstract mixin class $WishModelCopyWith<$Res>  {
  factory $WishModelCopyWith(WishModel value, $Res Function(WishModel) _then) = _$WishModelCopyWithImpl;
@useResult
$Res call({
 int wishId, int userId, String name, int price, String itemImage, String vendor, String createdAt, String url, bool bought, bool starred
});




}
/// @nodoc
class _$WishModelCopyWithImpl<$Res>
    implements $WishModelCopyWith<$Res> {
  _$WishModelCopyWithImpl(this._self, this._then);

  final WishModel _self;
  final $Res Function(WishModel) _then;

/// Create a copy of WishModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? wishId = null,Object? userId = null,Object? name = null,Object? price = null,Object? itemImage = null,Object? vendor = null,Object? createdAt = null,Object? url = null,Object? bought = null,Object? starred = null,}) {
  return _then(_self.copyWith(
wishId: null == wishId ? _self.wishId : wishId // ignore: cast_nullable_to_non_nullable
as int,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as int,itemImage: null == itemImage ? _self.itemImage : itemImage // ignore: cast_nullable_to_non_nullable
as String,vendor: null == vendor ? _self.vendor : vendor // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,bought: null == bought ? _self.bought : bought // ignore: cast_nullable_to_non_nullable
as bool,starred: null == starred ? _self.starred : starred // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [WishModel].
extension WishModelPatterns on WishModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WishModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WishModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WishModel value)  $default,){
final _that = this;
switch (_that) {
case _WishModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WishModel value)?  $default,){
final _that = this;
switch (_that) {
case _WishModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int wishId,  int userId,  String name,  int price,  String itemImage,  String vendor,  String createdAt,  String url,  bool bought,  bool starred)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WishModel() when $default != null:
return $default(_that.wishId,_that.userId,_that.name,_that.price,_that.itemImage,_that.vendor,_that.createdAt,_that.url,_that.bought,_that.starred);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int wishId,  int userId,  String name,  int price,  String itemImage,  String vendor,  String createdAt,  String url,  bool bought,  bool starred)  $default,) {final _that = this;
switch (_that) {
case _WishModel():
return $default(_that.wishId,_that.userId,_that.name,_that.price,_that.itemImage,_that.vendor,_that.createdAt,_that.url,_that.bought,_that.starred);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int wishId,  int userId,  String name,  int price,  String itemImage,  String vendor,  String createdAt,  String url,  bool bought,  bool starred)?  $default,) {final _that = this;
switch (_that) {
case _WishModel() when $default != null:
return $default(_that.wishId,_that.userId,_that.name,_that.price,_that.itemImage,_that.vendor,_that.createdAt,_that.url,_that.bought,_that.starred);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WishModel implements WishModel {
  const _WishModel({this.wishId = 0, this.userId = 0, this.name = '', this.price = 0, this.itemImage = '', this.vendor = '', this.createdAt = '', this.url = '', this.bought = false, this.starred = false});
  factory _WishModel.fromJson(Map<String, dynamic> json) => _$WishModelFromJson(json);

@override@JsonKey() final  int wishId;
@override@JsonKey() final  int userId;
@override@JsonKey() final  String name;
@override@JsonKey() final  int price;
@override@JsonKey() final  String itemImage;
@override@JsonKey() final  String vendor;
@override@JsonKey() final  String createdAt;
@override@JsonKey() final  String url;
@override@JsonKey() final  bool bought;
@override@JsonKey() final  bool starred;

/// Create a copy of WishModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WishModelCopyWith<_WishModel> get copyWith => __$WishModelCopyWithImpl<_WishModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WishModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WishModel&&(identical(other.wishId, wishId) || other.wishId == wishId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.name, name) || other.name == name)&&(identical(other.price, price) || other.price == price)&&(identical(other.itemImage, itemImage) || other.itemImage == itemImage)&&(identical(other.vendor, vendor) || other.vendor == vendor)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.url, url) || other.url == url)&&(identical(other.bought, bought) || other.bought == bought)&&(identical(other.starred, starred) || other.starred == starred));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,wishId,userId,name,price,itemImage,vendor,createdAt,url,bought,starred);

@override
String toString() {
  return 'WishModel(wishId: $wishId, userId: $userId, name: $name, price: $price, itemImage: $itemImage, vendor: $vendor, createdAt: $createdAt, url: $url, bought: $bought, starred: $starred)';
}


}

/// @nodoc
abstract mixin class _$WishModelCopyWith<$Res> implements $WishModelCopyWith<$Res> {
  factory _$WishModelCopyWith(_WishModel value, $Res Function(_WishModel) _then) = __$WishModelCopyWithImpl;
@override @useResult
$Res call({
 int wishId, int userId, String name, int price, String itemImage, String vendor, String createdAt, String url, bool bought, bool starred
});




}
/// @nodoc
class __$WishModelCopyWithImpl<$Res>
    implements _$WishModelCopyWith<$Res> {
  __$WishModelCopyWithImpl(this._self, this._then);

  final _WishModel _self;
  final $Res Function(_WishModel) _then;

/// Create a copy of WishModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? wishId = null,Object? userId = null,Object? name = null,Object? price = null,Object? itemImage = null,Object? vendor = null,Object? createdAt = null,Object? url = null,Object? bought = null,Object? starred = null,}) {
  return _then(_WishModel(
wishId: null == wishId ? _self.wishId : wishId // ignore: cast_nullable_to_non_nullable
as int,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as int,itemImage: null == itemImage ? _self.itemImage : itemImage // ignore: cast_nullable_to_non_nullable
as String,vendor: null == vendor ? _self.vendor : vendor // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,bought: null == bought ? _self.bought : bought // ignore: cast_nullable_to_non_nullable
as bool,starred: null == starred ? _self.starred : starred // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
