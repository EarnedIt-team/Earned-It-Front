// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wish_order_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WishOrderState {

 List<WishModel>? get initialList;// 순서 변경 전 원본 리스트
 List<WishModel> get currentList;// 현재 순서가 반영된 리스트
 bool get canSubmit;// 버튼 활성화 여부
 bool get isLoading;
/// Create a copy of WishOrderState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WishOrderStateCopyWith<WishOrderState> get copyWith => _$WishOrderStateCopyWithImpl<WishOrderState>(this as WishOrderState, _$identity);

  /// Serializes this WishOrderState to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WishOrderState&&const DeepCollectionEquality().equals(other.initialList, initialList)&&const DeepCollectionEquality().equals(other.currentList, currentList)&&(identical(other.canSubmit, canSubmit) || other.canSubmit == canSubmit)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(initialList),const DeepCollectionEquality().hash(currentList),canSubmit,isLoading);

@override
String toString() {
  return 'WishOrderState(initialList: $initialList, currentList: $currentList, canSubmit: $canSubmit, isLoading: $isLoading)';
}


}

/// @nodoc
abstract mixin class $WishOrderStateCopyWith<$Res>  {
  factory $WishOrderStateCopyWith(WishOrderState value, $Res Function(WishOrderState) _then) = _$WishOrderStateCopyWithImpl;
@useResult
$Res call({
 List<WishModel>? initialList, List<WishModel> currentList, bool canSubmit, bool isLoading
});




}
/// @nodoc
class _$WishOrderStateCopyWithImpl<$Res>
    implements $WishOrderStateCopyWith<$Res> {
  _$WishOrderStateCopyWithImpl(this._self, this._then);

  final WishOrderState _self;
  final $Res Function(WishOrderState) _then;

/// Create a copy of WishOrderState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? initialList = freezed,Object? currentList = null,Object? canSubmit = null,Object? isLoading = null,}) {
  return _then(_self.copyWith(
initialList: freezed == initialList ? _self.initialList : initialList // ignore: cast_nullable_to_non_nullable
as List<WishModel>?,currentList: null == currentList ? _self.currentList : currentList // ignore: cast_nullable_to_non_nullable
as List<WishModel>,canSubmit: null == canSubmit ? _self.canSubmit : canSubmit // ignore: cast_nullable_to_non_nullable
as bool,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [WishOrderState].
extension WishOrderStatePatterns on WishOrderState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WishOrderState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WishOrderState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WishOrderState value)  $default,){
final _that = this;
switch (_that) {
case _WishOrderState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WishOrderState value)?  $default,){
final _that = this;
switch (_that) {
case _WishOrderState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<WishModel>? initialList,  List<WishModel> currentList,  bool canSubmit,  bool isLoading)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WishOrderState() when $default != null:
return $default(_that.initialList,_that.currentList,_that.canSubmit,_that.isLoading);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<WishModel>? initialList,  List<WishModel> currentList,  bool canSubmit,  bool isLoading)  $default,) {final _that = this;
switch (_that) {
case _WishOrderState():
return $default(_that.initialList,_that.currentList,_that.canSubmit,_that.isLoading);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<WishModel>? initialList,  List<WishModel> currentList,  bool canSubmit,  bool isLoading)?  $default,) {final _that = this;
switch (_that) {
case _WishOrderState() when $default != null:
return $default(_that.initialList,_that.currentList,_that.canSubmit,_that.isLoading);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WishOrderState implements WishOrderState {
  const _WishOrderState({final  List<WishModel>? initialList, final  List<WishModel> currentList = const [], this.canSubmit = false, this.isLoading = false}): _initialList = initialList,_currentList = currentList;
  factory _WishOrderState.fromJson(Map<String, dynamic> json) => _$WishOrderStateFromJson(json);

 final  List<WishModel>? _initialList;
@override List<WishModel>? get initialList {
  final value = _initialList;
  if (value == null) return null;
  if (_initialList is EqualUnmodifiableListView) return _initialList;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

// 순서 변경 전 원본 리스트
 final  List<WishModel> _currentList;
// 순서 변경 전 원본 리스트
@override@JsonKey() List<WishModel> get currentList {
  if (_currentList is EqualUnmodifiableListView) return _currentList;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_currentList);
}

// 현재 순서가 반영된 리스트
@override@JsonKey() final  bool canSubmit;
// 버튼 활성화 여부
@override@JsonKey() final  bool isLoading;

/// Create a copy of WishOrderState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WishOrderStateCopyWith<_WishOrderState> get copyWith => __$WishOrderStateCopyWithImpl<_WishOrderState>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WishOrderStateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WishOrderState&&const DeepCollectionEquality().equals(other._initialList, _initialList)&&const DeepCollectionEquality().equals(other._currentList, _currentList)&&(identical(other.canSubmit, canSubmit) || other.canSubmit == canSubmit)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_initialList),const DeepCollectionEquality().hash(_currentList),canSubmit,isLoading);

@override
String toString() {
  return 'WishOrderState(initialList: $initialList, currentList: $currentList, canSubmit: $canSubmit, isLoading: $isLoading)';
}


}

/// @nodoc
abstract mixin class _$WishOrderStateCopyWith<$Res> implements $WishOrderStateCopyWith<$Res> {
  factory _$WishOrderStateCopyWith(_WishOrderState value, $Res Function(_WishOrderState) _then) = __$WishOrderStateCopyWithImpl;
@override @useResult
$Res call({
 List<WishModel>? initialList, List<WishModel> currentList, bool canSubmit, bool isLoading
});




}
/// @nodoc
class __$WishOrderStateCopyWithImpl<$Res>
    implements _$WishOrderStateCopyWith<$Res> {
  __$WishOrderStateCopyWithImpl(this._self, this._then);

  final _WishOrderState _self;
  final $Res Function(_WishOrderState) _then;

/// Create a copy of WishOrderState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? initialList = freezed,Object? currentList = null,Object? canSubmit = null,Object? isLoading = null,}) {
  return _then(_WishOrderState(
initialList: freezed == initialList ? _self._initialList : initialList // ignore: cast_nullable_to_non_nullable
as List<WishModel>?,currentList: null == currentList ? _self._currentList : currentList // ignore: cast_nullable_to_non_nullable
as List<WishModel>,canSubmit: null == canSubmit ? _self.canSubmit : canSubmit // ignore: cast_nullable_to_non_nullable
as bool,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
