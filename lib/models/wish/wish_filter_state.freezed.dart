// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wish_filter_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$WishFilterState {

 SortKey? get sortKey;// 현재 선택된 정렬 기준
 SortDirection? get sortDirection;// 현재 정렬 방향
 bool get filterByStarred;// Star 필터 활성화 여부
 bool get filterByBought;
/// Create a copy of WishFilterState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WishFilterStateCopyWith<WishFilterState> get copyWith => _$WishFilterStateCopyWithImpl<WishFilterState>(this as WishFilterState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WishFilterState&&(identical(other.sortKey, sortKey) || other.sortKey == sortKey)&&(identical(other.sortDirection, sortDirection) || other.sortDirection == sortDirection)&&(identical(other.filterByStarred, filterByStarred) || other.filterByStarred == filterByStarred)&&(identical(other.filterByBought, filterByBought) || other.filterByBought == filterByBought));
}


@override
int get hashCode => Object.hash(runtimeType,sortKey,sortDirection,filterByStarred,filterByBought);

@override
String toString() {
  return 'WishFilterState(sortKey: $sortKey, sortDirection: $sortDirection, filterByStarred: $filterByStarred, filterByBought: $filterByBought)';
}


}

/// @nodoc
abstract mixin class $WishFilterStateCopyWith<$Res>  {
  factory $WishFilterStateCopyWith(WishFilterState value, $Res Function(WishFilterState) _then) = _$WishFilterStateCopyWithImpl;
@useResult
$Res call({
 SortKey? sortKey, SortDirection? sortDirection, bool filterByStarred, bool filterByBought
});




}
/// @nodoc
class _$WishFilterStateCopyWithImpl<$Res>
    implements $WishFilterStateCopyWith<$Res> {
  _$WishFilterStateCopyWithImpl(this._self, this._then);

  final WishFilterState _self;
  final $Res Function(WishFilterState) _then;

/// Create a copy of WishFilterState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sortKey = freezed,Object? sortDirection = freezed,Object? filterByStarred = null,Object? filterByBought = null,}) {
  return _then(_self.copyWith(
sortKey: freezed == sortKey ? _self.sortKey : sortKey // ignore: cast_nullable_to_non_nullable
as SortKey?,sortDirection: freezed == sortDirection ? _self.sortDirection : sortDirection // ignore: cast_nullable_to_non_nullable
as SortDirection?,filterByStarred: null == filterByStarred ? _self.filterByStarred : filterByStarred // ignore: cast_nullable_to_non_nullable
as bool,filterByBought: null == filterByBought ? _self.filterByBought : filterByBought // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [WishFilterState].
extension WishFilterStatePatterns on WishFilterState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WishFilterState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WishFilterState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WishFilterState value)  $default,){
final _that = this;
switch (_that) {
case _WishFilterState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WishFilterState value)?  $default,){
final _that = this;
switch (_that) {
case _WishFilterState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( SortKey? sortKey,  SortDirection? sortDirection,  bool filterByStarred,  bool filterByBought)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WishFilterState() when $default != null:
return $default(_that.sortKey,_that.sortDirection,_that.filterByStarred,_that.filterByBought);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( SortKey? sortKey,  SortDirection? sortDirection,  bool filterByStarred,  bool filterByBought)  $default,) {final _that = this;
switch (_that) {
case _WishFilterState():
return $default(_that.sortKey,_that.sortDirection,_that.filterByStarred,_that.filterByBought);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( SortKey? sortKey,  SortDirection? sortDirection,  bool filterByStarred,  bool filterByBought)?  $default,) {final _that = this;
switch (_that) {
case _WishFilterState() when $default != null:
return $default(_that.sortKey,_that.sortDirection,_that.filterByStarred,_that.filterByBought);case _:
  return null;

}
}

}

/// @nodoc


class _WishFilterState implements WishFilterState {
  const _WishFilterState({this.sortKey, this.sortDirection, this.filterByStarred = false, this.filterByBought = false});
  

@override final  SortKey? sortKey;
// 현재 선택된 정렬 기준
@override final  SortDirection? sortDirection;
// 현재 정렬 방향
@override@JsonKey() final  bool filterByStarred;
// Star 필터 활성화 여부
@override@JsonKey() final  bool filterByBought;

/// Create a copy of WishFilterState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WishFilterStateCopyWith<_WishFilterState> get copyWith => __$WishFilterStateCopyWithImpl<_WishFilterState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WishFilterState&&(identical(other.sortKey, sortKey) || other.sortKey == sortKey)&&(identical(other.sortDirection, sortDirection) || other.sortDirection == sortDirection)&&(identical(other.filterByStarred, filterByStarred) || other.filterByStarred == filterByStarred)&&(identical(other.filterByBought, filterByBought) || other.filterByBought == filterByBought));
}


@override
int get hashCode => Object.hash(runtimeType,sortKey,sortDirection,filterByStarred,filterByBought);

@override
String toString() {
  return 'WishFilterState(sortKey: $sortKey, sortDirection: $sortDirection, filterByStarred: $filterByStarred, filterByBought: $filterByBought)';
}


}

/// @nodoc
abstract mixin class _$WishFilterStateCopyWith<$Res> implements $WishFilterStateCopyWith<$Res> {
  factory _$WishFilterStateCopyWith(_WishFilterState value, $Res Function(_WishFilterState) _then) = __$WishFilterStateCopyWithImpl;
@override @useResult
$Res call({
 SortKey? sortKey, SortDirection? sortDirection, bool filterByStarred, bool filterByBought
});




}
/// @nodoc
class __$WishFilterStateCopyWithImpl<$Res>
    implements _$WishFilterStateCopyWith<$Res> {
  __$WishFilterStateCopyWithImpl(this._self, this._then);

  final _WishFilterState _self;
  final $Res Function(_WishFilterState) _then;

/// Create a copy of WishFilterState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sortKey = freezed,Object? sortDirection = freezed,Object? filterByStarred = null,Object? filterByBought = null,}) {
  return _then(_WishFilterState(
sortKey: freezed == sortKey ? _self.sortKey : sortKey // ignore: cast_nullable_to_non_nullable
as SortKey?,sortDirection: freezed == sortDirection ? _self.sortDirection : sortDirection // ignore: cast_nullable_to_non_nullable
as SortDirection?,filterByStarred: null == filterByStarred ? _self.filterByStarred : filterByStarred // ignore: cast_nullable_to_non_nullable
as bool,filterByBought: null == filterByBought ? _self.filterByBought : filterByBought // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
