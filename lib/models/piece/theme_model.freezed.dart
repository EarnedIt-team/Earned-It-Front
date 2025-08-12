// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'theme_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ThemeModel {

// 1. JSON 필드명과 Dart 필드명이 다른 경우 @JsonKey를 사용합니다.
@JsonKey(name: 'themeName') String get themeName;@JsonKey(name: 'collectedCount') int get collectedCount;@JsonKey(name: 'totalCount') int get totalCount;@JsonKey(name: 'totalValue') int get totalValue;// 2. JSON의 'slots' 키를 'slots' 필드에 매핑합니다.
@JsonKey(name: 'slots') List<SlotModel> get slots;
/// Create a copy of ThemeModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ThemeModelCopyWith<ThemeModel> get copyWith => _$ThemeModelCopyWithImpl<ThemeModel>(this as ThemeModel, _$identity);

  /// Serializes this ThemeModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ThemeModel&&(identical(other.themeName, themeName) || other.themeName == themeName)&&(identical(other.collectedCount, collectedCount) || other.collectedCount == collectedCount)&&(identical(other.totalCount, totalCount) || other.totalCount == totalCount)&&(identical(other.totalValue, totalValue) || other.totalValue == totalValue)&&const DeepCollectionEquality().equals(other.slots, slots));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,themeName,collectedCount,totalCount,totalValue,const DeepCollectionEquality().hash(slots));

@override
String toString() {
  return 'ThemeModel(themeName: $themeName, collectedCount: $collectedCount, totalCount: $totalCount, totalValue: $totalValue, slots: $slots)';
}


}

/// @nodoc
abstract mixin class $ThemeModelCopyWith<$Res>  {
  factory $ThemeModelCopyWith(ThemeModel value, $Res Function(ThemeModel) _then) = _$ThemeModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'themeName') String themeName,@JsonKey(name: 'collectedCount') int collectedCount,@JsonKey(name: 'totalCount') int totalCount,@JsonKey(name: 'totalValue') int totalValue,@JsonKey(name: 'slots') List<SlotModel> slots
});




}
/// @nodoc
class _$ThemeModelCopyWithImpl<$Res>
    implements $ThemeModelCopyWith<$Res> {
  _$ThemeModelCopyWithImpl(this._self, this._then);

  final ThemeModel _self;
  final $Res Function(ThemeModel) _then;

/// Create a copy of ThemeModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? themeName = null,Object? collectedCount = null,Object? totalCount = null,Object? totalValue = null,Object? slots = null,}) {
  return _then(_self.copyWith(
themeName: null == themeName ? _self.themeName : themeName // ignore: cast_nullable_to_non_nullable
as String,collectedCount: null == collectedCount ? _self.collectedCount : collectedCount // ignore: cast_nullable_to_non_nullable
as int,totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,totalValue: null == totalValue ? _self.totalValue : totalValue // ignore: cast_nullable_to_non_nullable
as int,slots: null == slots ? _self.slots : slots // ignore: cast_nullable_to_non_nullable
as List<SlotModel>,
  ));
}

}


/// Adds pattern-matching-related methods to [ThemeModel].
extension ThemeModelPatterns on ThemeModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ThemeModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ThemeModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ThemeModel value)  $default,){
final _that = this;
switch (_that) {
case _ThemeModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ThemeModel value)?  $default,){
final _that = this;
switch (_that) {
case _ThemeModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'themeName')  String themeName, @JsonKey(name: 'collectedCount')  int collectedCount, @JsonKey(name: 'totalCount')  int totalCount, @JsonKey(name: 'totalValue')  int totalValue, @JsonKey(name: 'slots')  List<SlotModel> slots)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ThemeModel() when $default != null:
return $default(_that.themeName,_that.collectedCount,_that.totalCount,_that.totalValue,_that.slots);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'themeName')  String themeName, @JsonKey(name: 'collectedCount')  int collectedCount, @JsonKey(name: 'totalCount')  int totalCount, @JsonKey(name: 'totalValue')  int totalValue, @JsonKey(name: 'slots')  List<SlotModel> slots)  $default,) {final _that = this;
switch (_that) {
case _ThemeModel():
return $default(_that.themeName,_that.collectedCount,_that.totalCount,_that.totalValue,_that.slots);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'themeName')  String themeName, @JsonKey(name: 'collectedCount')  int collectedCount, @JsonKey(name: 'totalCount')  int totalCount, @JsonKey(name: 'totalValue')  int totalValue, @JsonKey(name: 'slots')  List<SlotModel> slots)?  $default,) {final _that = this;
switch (_that) {
case _ThemeModel() when $default != null:
return $default(_that.themeName,_that.collectedCount,_that.totalCount,_that.totalValue,_that.slots);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ThemeModel implements ThemeModel {
  const _ThemeModel({@JsonKey(name: 'themeName') required this.themeName, @JsonKey(name: 'collectedCount') required this.collectedCount, @JsonKey(name: 'totalCount') required this.totalCount, @JsonKey(name: 'totalValue') required this.totalValue, @JsonKey(name: 'slots') required final  List<SlotModel> slots}): _slots = slots;
  factory _ThemeModel.fromJson(Map<String, dynamic> json) => _$ThemeModelFromJson(json);

// 1. JSON 필드명과 Dart 필드명이 다른 경우 @JsonKey를 사용합니다.
@override@JsonKey(name: 'themeName') final  String themeName;
@override@JsonKey(name: 'collectedCount') final  int collectedCount;
@override@JsonKey(name: 'totalCount') final  int totalCount;
@override@JsonKey(name: 'totalValue') final  int totalValue;
// 2. JSON의 'slots' 키를 'slots' 필드에 매핑합니다.
 final  List<SlotModel> _slots;
// 2. JSON의 'slots' 키를 'slots' 필드에 매핑합니다.
@override@JsonKey(name: 'slots') List<SlotModel> get slots {
  if (_slots is EqualUnmodifiableListView) return _slots;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_slots);
}


/// Create a copy of ThemeModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ThemeModelCopyWith<_ThemeModel> get copyWith => __$ThemeModelCopyWithImpl<_ThemeModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ThemeModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ThemeModel&&(identical(other.themeName, themeName) || other.themeName == themeName)&&(identical(other.collectedCount, collectedCount) || other.collectedCount == collectedCount)&&(identical(other.totalCount, totalCount) || other.totalCount == totalCount)&&(identical(other.totalValue, totalValue) || other.totalValue == totalValue)&&const DeepCollectionEquality().equals(other._slots, _slots));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,themeName,collectedCount,totalCount,totalValue,const DeepCollectionEquality().hash(_slots));

@override
String toString() {
  return 'ThemeModel(themeName: $themeName, collectedCount: $collectedCount, totalCount: $totalCount, totalValue: $totalValue, slots: $slots)';
}


}

/// @nodoc
abstract mixin class _$ThemeModelCopyWith<$Res> implements $ThemeModelCopyWith<$Res> {
  factory _$ThemeModelCopyWith(_ThemeModel value, $Res Function(_ThemeModel) _then) = __$ThemeModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'themeName') String themeName,@JsonKey(name: 'collectedCount') int collectedCount,@JsonKey(name: 'totalCount') int totalCount,@JsonKey(name: 'totalValue') int totalValue,@JsonKey(name: 'slots') List<SlotModel> slots
});




}
/// @nodoc
class __$ThemeModelCopyWithImpl<$Res>
    implements _$ThemeModelCopyWith<$Res> {
  __$ThemeModelCopyWithImpl(this._self, this._then);

  final _ThemeModel _self;
  final $Res Function(_ThemeModel) _then;

/// Create a copy of ThemeModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? themeName = null,Object? collectedCount = null,Object? totalCount = null,Object? totalValue = null,Object? slots = null,}) {
  return _then(_ThemeModel(
themeName: null == themeName ? _self.themeName : themeName // ignore: cast_nullable_to_non_nullable
as String,collectedCount: null == collectedCount ? _self.collectedCount : collectedCount // ignore: cast_nullable_to_non_nullable
as int,totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,totalValue: null == totalValue ? _self.totalValue : totalValue // ignore: cast_nullable_to_non_nullable
as int,slots: null == slots ? _self._slots : slots // ignore: cast_nullable_to_non_nullable
as List<SlotModel>,
  ));
}


}


/// @nodoc
mixin _$SlotModel {

 int get slotIndex; int? get pieceId; int? get itemId; String? get itemName; String? get image; int? get value; String? get collectedAt;// 3. JSON의 'collected' 키를 'isCollected' 필드에 매핑합니다.
@JsonKey(name: 'collected') bool get isCollected;
/// Create a copy of SlotModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SlotModelCopyWith<SlotModel> get copyWith => _$SlotModelCopyWithImpl<SlotModel>(this as SlotModel, _$identity);

  /// Serializes this SlotModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SlotModel&&(identical(other.slotIndex, slotIndex) || other.slotIndex == slotIndex)&&(identical(other.pieceId, pieceId) || other.pieceId == pieceId)&&(identical(other.itemId, itemId) || other.itemId == itemId)&&(identical(other.itemName, itemName) || other.itemName == itemName)&&(identical(other.image, image) || other.image == image)&&(identical(other.value, value) || other.value == value)&&(identical(other.collectedAt, collectedAt) || other.collectedAt == collectedAt)&&(identical(other.isCollected, isCollected) || other.isCollected == isCollected));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,slotIndex,pieceId,itemId,itemName,image,value,collectedAt,isCollected);

@override
String toString() {
  return 'SlotModel(slotIndex: $slotIndex, pieceId: $pieceId, itemId: $itemId, itemName: $itemName, image: $image, value: $value, collectedAt: $collectedAt, isCollected: $isCollected)';
}


}

/// @nodoc
abstract mixin class $SlotModelCopyWith<$Res>  {
  factory $SlotModelCopyWith(SlotModel value, $Res Function(SlotModel) _then) = _$SlotModelCopyWithImpl;
@useResult
$Res call({
 int slotIndex, int? pieceId, int? itemId, String? itemName, String? image, int? value, String? collectedAt,@JsonKey(name: 'collected') bool isCollected
});




}
/// @nodoc
class _$SlotModelCopyWithImpl<$Res>
    implements $SlotModelCopyWith<$Res> {
  _$SlotModelCopyWithImpl(this._self, this._then);

  final SlotModel _self;
  final $Res Function(SlotModel) _then;

/// Create a copy of SlotModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? slotIndex = null,Object? pieceId = freezed,Object? itemId = freezed,Object? itemName = freezed,Object? image = freezed,Object? value = freezed,Object? collectedAt = freezed,Object? isCollected = null,}) {
  return _then(_self.copyWith(
slotIndex: null == slotIndex ? _self.slotIndex : slotIndex // ignore: cast_nullable_to_non_nullable
as int,pieceId: freezed == pieceId ? _self.pieceId : pieceId // ignore: cast_nullable_to_non_nullable
as int?,itemId: freezed == itemId ? _self.itemId : itemId // ignore: cast_nullable_to_non_nullable
as int?,itemName: freezed == itemName ? _self.itemName : itemName // ignore: cast_nullable_to_non_nullable
as String?,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String?,value: freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as int?,collectedAt: freezed == collectedAt ? _self.collectedAt : collectedAt // ignore: cast_nullable_to_non_nullable
as String?,isCollected: null == isCollected ? _self.isCollected : isCollected // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [SlotModel].
extension SlotModelPatterns on SlotModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SlotModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SlotModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SlotModel value)  $default,){
final _that = this;
switch (_that) {
case _SlotModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SlotModel value)?  $default,){
final _that = this;
switch (_that) {
case _SlotModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int slotIndex,  int? pieceId,  int? itemId,  String? itemName,  String? image,  int? value,  String? collectedAt, @JsonKey(name: 'collected')  bool isCollected)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SlotModel() when $default != null:
return $default(_that.slotIndex,_that.pieceId,_that.itemId,_that.itemName,_that.image,_that.value,_that.collectedAt,_that.isCollected);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int slotIndex,  int? pieceId,  int? itemId,  String? itemName,  String? image,  int? value,  String? collectedAt, @JsonKey(name: 'collected')  bool isCollected)  $default,) {final _that = this;
switch (_that) {
case _SlotModel():
return $default(_that.slotIndex,_that.pieceId,_that.itemId,_that.itemName,_that.image,_that.value,_that.collectedAt,_that.isCollected);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int slotIndex,  int? pieceId,  int? itemId,  String? itemName,  String? image,  int? value,  String? collectedAt, @JsonKey(name: 'collected')  bool isCollected)?  $default,) {final _that = this;
switch (_that) {
case _SlotModel() when $default != null:
return $default(_that.slotIndex,_that.pieceId,_that.itemId,_that.itemName,_that.image,_that.value,_that.collectedAt,_that.isCollected);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SlotModel implements SlotModel {
  const _SlotModel({required this.slotIndex, this.pieceId, this.itemId, this.itemName, this.image, this.value, this.collectedAt, @JsonKey(name: 'collected') required this.isCollected});
  factory _SlotModel.fromJson(Map<String, dynamic> json) => _$SlotModelFromJson(json);

@override final  int slotIndex;
@override final  int? pieceId;
@override final  int? itemId;
@override final  String? itemName;
@override final  String? image;
@override final  int? value;
@override final  String? collectedAt;
// 3. JSON의 'collected' 키를 'isCollected' 필드에 매핑합니다.
@override@JsonKey(name: 'collected') final  bool isCollected;

/// Create a copy of SlotModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SlotModelCopyWith<_SlotModel> get copyWith => __$SlotModelCopyWithImpl<_SlotModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SlotModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SlotModel&&(identical(other.slotIndex, slotIndex) || other.slotIndex == slotIndex)&&(identical(other.pieceId, pieceId) || other.pieceId == pieceId)&&(identical(other.itemId, itemId) || other.itemId == itemId)&&(identical(other.itemName, itemName) || other.itemName == itemName)&&(identical(other.image, image) || other.image == image)&&(identical(other.value, value) || other.value == value)&&(identical(other.collectedAt, collectedAt) || other.collectedAt == collectedAt)&&(identical(other.isCollected, isCollected) || other.isCollected == isCollected));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,slotIndex,pieceId,itemId,itemName,image,value,collectedAt,isCollected);

@override
String toString() {
  return 'SlotModel(slotIndex: $slotIndex, pieceId: $pieceId, itemId: $itemId, itemName: $itemName, image: $image, value: $value, collectedAt: $collectedAt, isCollected: $isCollected)';
}


}

/// @nodoc
abstract mixin class _$SlotModelCopyWith<$Res> implements $SlotModelCopyWith<$Res> {
  factory _$SlotModelCopyWith(_SlotModel value, $Res Function(_SlotModel) _then) = __$SlotModelCopyWithImpl;
@override @useResult
$Res call({
 int slotIndex, int? pieceId, int? itemId, String? itemName, String? image, int? value, String? collectedAt,@JsonKey(name: 'collected') bool isCollected
});




}
/// @nodoc
class __$SlotModelCopyWithImpl<$Res>
    implements _$SlotModelCopyWith<$Res> {
  __$SlotModelCopyWithImpl(this._self, this._then);

  final _SlotModel _self;
  final $Res Function(_SlotModel) _then;

/// Create a copy of SlotModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? slotIndex = null,Object? pieceId = freezed,Object? itemId = freezed,Object? itemName = freezed,Object? image = freezed,Object? value = freezed,Object? collectedAt = freezed,Object? isCollected = null,}) {
  return _then(_SlotModel(
slotIndex: null == slotIndex ? _self.slotIndex : slotIndex // ignore: cast_nullable_to_non_nullable
as int,pieceId: freezed == pieceId ? _self.pieceId : pieceId // ignore: cast_nullable_to_non_nullable
as int?,itemId: freezed == itemId ? _self.itemId : itemId // ignore: cast_nullable_to_non_nullable
as int?,itemName: freezed == itemName ? _self.itemName : itemName // ignore: cast_nullable_to_non_nullable
as String?,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String?,value: freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as int?,collectedAt: freezed == collectedAt ? _self.collectedAt : collectedAt // ignore: cast_nullable_to_non_nullable
as String?,isCollected: null == isCollected ? _self.isCollected : isCollected // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
