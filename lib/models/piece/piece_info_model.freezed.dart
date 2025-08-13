// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'piece_info_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PieceInfoModel {

/// 조각 Id
 int? get pieceId;/// 등급
 String? get rarity;/// 등록 날짜
 String? get collectedAt;/// 이미지 URL
 String? get image;/// 판매자, 회사명
 String? get vendor;/// 조각 이름
 String? get name;/// 가격
 int? get price;/// 상세 설명
 String? get description;/// 메인 고정 여부
 bool? get isMainPiece;
/// Create a copy of PieceInfoModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PieceInfoModelCopyWith<PieceInfoModel> get copyWith => _$PieceInfoModelCopyWithImpl<PieceInfoModel>(this as PieceInfoModel, _$identity);

  /// Serializes this PieceInfoModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PieceInfoModel&&(identical(other.pieceId, pieceId) || other.pieceId == pieceId)&&(identical(other.rarity, rarity) || other.rarity == rarity)&&(identical(other.collectedAt, collectedAt) || other.collectedAt == collectedAt)&&(identical(other.image, image) || other.image == image)&&(identical(other.vendor, vendor) || other.vendor == vendor)&&(identical(other.name, name) || other.name == name)&&(identical(other.price, price) || other.price == price)&&(identical(other.description, description) || other.description == description)&&(identical(other.isMainPiece, isMainPiece) || other.isMainPiece == isMainPiece));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,pieceId,rarity,collectedAt,image,vendor,name,price,description,isMainPiece);

@override
String toString() {
  return 'PieceInfoModel(pieceId: $pieceId, rarity: $rarity, collectedAt: $collectedAt, image: $image, vendor: $vendor, name: $name, price: $price, description: $description, isMainPiece: $isMainPiece)';
}


}

/// @nodoc
abstract mixin class $PieceInfoModelCopyWith<$Res>  {
  factory $PieceInfoModelCopyWith(PieceInfoModel value, $Res Function(PieceInfoModel) _then) = _$PieceInfoModelCopyWithImpl;
@useResult
$Res call({
 int? pieceId, String? rarity, String? collectedAt, String? image, String? vendor, String? name, int? price, String? description, bool? isMainPiece
});




}
/// @nodoc
class _$PieceInfoModelCopyWithImpl<$Res>
    implements $PieceInfoModelCopyWith<$Res> {
  _$PieceInfoModelCopyWithImpl(this._self, this._then);

  final PieceInfoModel _self;
  final $Res Function(PieceInfoModel) _then;

/// Create a copy of PieceInfoModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? pieceId = freezed,Object? rarity = freezed,Object? collectedAt = freezed,Object? image = freezed,Object? vendor = freezed,Object? name = freezed,Object? price = freezed,Object? description = freezed,Object? isMainPiece = freezed,}) {
  return _then(_self.copyWith(
pieceId: freezed == pieceId ? _self.pieceId : pieceId // ignore: cast_nullable_to_non_nullable
as int?,rarity: freezed == rarity ? _self.rarity : rarity // ignore: cast_nullable_to_non_nullable
as String?,collectedAt: freezed == collectedAt ? _self.collectedAt : collectedAt // ignore: cast_nullable_to_non_nullable
as String?,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String?,vendor: freezed == vendor ? _self.vendor : vendor // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,price: freezed == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as int?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,isMainPiece: freezed == isMainPiece ? _self.isMainPiece : isMainPiece // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// Adds pattern-matching-related methods to [PieceInfoModel].
extension PieceInfoModelPatterns on PieceInfoModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PieceInfoModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PieceInfoModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PieceInfoModel value)  $default,){
final _that = this;
switch (_that) {
case _PieceInfoModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PieceInfoModel value)?  $default,){
final _that = this;
switch (_that) {
case _PieceInfoModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? pieceId,  String? rarity,  String? collectedAt,  String? image,  String? vendor,  String? name,  int? price,  String? description,  bool? isMainPiece)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PieceInfoModel() when $default != null:
return $default(_that.pieceId,_that.rarity,_that.collectedAt,_that.image,_that.vendor,_that.name,_that.price,_that.description,_that.isMainPiece);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? pieceId,  String? rarity,  String? collectedAt,  String? image,  String? vendor,  String? name,  int? price,  String? description,  bool? isMainPiece)  $default,) {final _that = this;
switch (_that) {
case _PieceInfoModel():
return $default(_that.pieceId,_that.rarity,_that.collectedAt,_that.image,_that.vendor,_that.name,_that.price,_that.description,_that.isMainPiece);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? pieceId,  String? rarity,  String? collectedAt,  String? image,  String? vendor,  String? name,  int? price,  String? description,  bool? isMainPiece)?  $default,) {final _that = this;
switch (_that) {
case _PieceInfoModel() when $default != null:
return $default(_that.pieceId,_that.rarity,_that.collectedAt,_that.image,_that.vendor,_that.name,_that.price,_that.description,_that.isMainPiece);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PieceInfoModel implements PieceInfoModel {
  const _PieceInfoModel({this.pieceId, this.rarity, this.collectedAt, this.image, this.vendor, this.name, this.price, this.description, this.isMainPiece});
  factory _PieceInfoModel.fromJson(Map<String, dynamic> json) => _$PieceInfoModelFromJson(json);

/// 조각 Id
@override final  int? pieceId;
/// 등급
@override final  String? rarity;
/// 등록 날짜
@override final  String? collectedAt;
/// 이미지 URL
@override final  String? image;
/// 판매자, 회사명
@override final  String? vendor;
/// 조각 이름
@override final  String? name;
/// 가격
@override final  int? price;
/// 상세 설명
@override final  String? description;
/// 메인 고정 여부
@override final  bool? isMainPiece;

/// Create a copy of PieceInfoModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PieceInfoModelCopyWith<_PieceInfoModel> get copyWith => __$PieceInfoModelCopyWithImpl<_PieceInfoModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PieceInfoModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PieceInfoModel&&(identical(other.pieceId, pieceId) || other.pieceId == pieceId)&&(identical(other.rarity, rarity) || other.rarity == rarity)&&(identical(other.collectedAt, collectedAt) || other.collectedAt == collectedAt)&&(identical(other.image, image) || other.image == image)&&(identical(other.vendor, vendor) || other.vendor == vendor)&&(identical(other.name, name) || other.name == name)&&(identical(other.price, price) || other.price == price)&&(identical(other.description, description) || other.description == description)&&(identical(other.isMainPiece, isMainPiece) || other.isMainPiece == isMainPiece));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,pieceId,rarity,collectedAt,image,vendor,name,price,description,isMainPiece);

@override
String toString() {
  return 'PieceInfoModel(pieceId: $pieceId, rarity: $rarity, collectedAt: $collectedAt, image: $image, vendor: $vendor, name: $name, price: $price, description: $description, isMainPiece: $isMainPiece)';
}


}

/// @nodoc
abstract mixin class _$PieceInfoModelCopyWith<$Res> implements $PieceInfoModelCopyWith<$Res> {
  factory _$PieceInfoModelCopyWith(_PieceInfoModel value, $Res Function(_PieceInfoModel) _then) = __$PieceInfoModelCopyWithImpl;
@override @useResult
$Res call({
 int? pieceId, String? rarity, String? collectedAt, String? image, String? vendor, String? name, int? price, String? description, bool? isMainPiece
});




}
/// @nodoc
class __$PieceInfoModelCopyWithImpl<$Res>
    implements _$PieceInfoModelCopyWith<$Res> {
  __$PieceInfoModelCopyWithImpl(this._self, this._then);

  final _PieceInfoModel _self;
  final $Res Function(_PieceInfoModel) _then;

/// Create a copy of PieceInfoModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? pieceId = freezed,Object? rarity = freezed,Object? collectedAt = freezed,Object? image = freezed,Object? vendor = freezed,Object? name = freezed,Object? price = freezed,Object? description = freezed,Object? isMainPiece = freezed,}) {
  return _then(_PieceInfoModel(
pieceId: freezed == pieceId ? _self.pieceId : pieceId // ignore: cast_nullable_to_non_nullable
as int?,rarity: freezed == rarity ? _self.rarity : rarity // ignore: cast_nullable_to_non_nullable
as String?,collectedAt: freezed == collectedAt ? _self.collectedAt : collectedAt // ignore: cast_nullable_to_non_nullable
as String?,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String?,vendor: freezed == vendor ? _self.vendor : vendor // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,price: freezed == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as int?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,isMainPiece: freezed == isMainPiece ? _self.isMainPiece : isMainPiece // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}

// dart format on
