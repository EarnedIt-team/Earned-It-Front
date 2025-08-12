// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wish_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$WishState {

// API 호출 중 로딩 상태
 bool get isLoading;/// 즐겨찾기 위시리스트 (Top5)
 List<WishModel> get starWishes;/// 위시리스트 상위 노출 3개
 List<WishModel> get Wishes3;/// 전체 위시리스트 (페이지네이션으로 불러옴)
 List<WishModel> get totalWishes;/// 등록된 위시아이템 개수
 int get currentWishCount;// --- 페이지네이션을 위한 상태 ---
/// 다음에 불러올 페이지 번호
 int get page;/// 더 불러올 페이지가 남았는지 여부
 bool get hasMore;
/// Create a copy of WishState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WishStateCopyWith<WishState> get copyWith => _$WishStateCopyWithImpl<WishState>(this as WishState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WishState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other.starWishes, starWishes)&&const DeepCollectionEquality().equals(other.Wishes3, Wishes3)&&const DeepCollectionEquality().equals(other.totalWishes, totalWishes)&&(identical(other.currentWishCount, currentWishCount) || other.currentWishCount == currentWishCount)&&(identical(other.page, page) || other.page == page)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,const DeepCollectionEquality().hash(starWishes),const DeepCollectionEquality().hash(Wishes3),const DeepCollectionEquality().hash(totalWishes),currentWishCount,page,hasMore);

@override
String toString() {
  return 'WishState(isLoading: $isLoading, starWishes: $starWishes, Wishes3: $Wishes3, totalWishes: $totalWishes, currentWishCount: $currentWishCount, page: $page, hasMore: $hasMore)';
}


}

/// @nodoc
abstract mixin class $WishStateCopyWith<$Res>  {
  factory $WishStateCopyWith(WishState value, $Res Function(WishState) _then) = _$WishStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, List<WishModel> starWishes, List<WishModel> Wishes3, List<WishModel> totalWishes, int currentWishCount, int page, bool hasMore
});




}
/// @nodoc
class _$WishStateCopyWithImpl<$Res>
    implements $WishStateCopyWith<$Res> {
  _$WishStateCopyWithImpl(this._self, this._then);

  final WishState _self;
  final $Res Function(WishState) _then;

/// Create a copy of WishState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? starWishes = null,Object? Wishes3 = null,Object? totalWishes = null,Object? currentWishCount = null,Object? page = null,Object? hasMore = null,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,starWishes: null == starWishes ? _self.starWishes : starWishes // ignore: cast_nullable_to_non_nullable
as List<WishModel>,Wishes3: null == Wishes3 ? _self.Wishes3 : Wishes3 // ignore: cast_nullable_to_non_nullable
as List<WishModel>,totalWishes: null == totalWishes ? _self.totalWishes : totalWishes // ignore: cast_nullable_to_non_nullable
as List<WishModel>,currentWishCount: null == currentWishCount ? _self.currentWishCount : currentWishCount // ignore: cast_nullable_to_non_nullable
as int,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [WishState].
extension WishStatePatterns on WishState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WishState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WishState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WishState value)  $default,){
final _that = this;
switch (_that) {
case _WishState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WishState value)?  $default,){
final _that = this;
switch (_that) {
case _WishState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  List<WishModel> starWishes,  List<WishModel> Wishes3,  List<WishModel> totalWishes,  int currentWishCount,  int page,  bool hasMore)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WishState() when $default != null:
return $default(_that.isLoading,_that.starWishes,_that.Wishes3,_that.totalWishes,_that.currentWishCount,_that.page,_that.hasMore);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  List<WishModel> starWishes,  List<WishModel> Wishes3,  List<WishModel> totalWishes,  int currentWishCount,  int page,  bool hasMore)  $default,) {final _that = this;
switch (_that) {
case _WishState():
return $default(_that.isLoading,_that.starWishes,_that.Wishes3,_that.totalWishes,_that.currentWishCount,_that.page,_that.hasMore);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  List<WishModel> starWishes,  List<WishModel> Wishes3,  List<WishModel> totalWishes,  int currentWishCount,  int page,  bool hasMore)?  $default,) {final _that = this;
switch (_that) {
case _WishState() when $default != null:
return $default(_that.isLoading,_that.starWishes,_that.Wishes3,_that.totalWishes,_that.currentWishCount,_that.page,_that.hasMore);case _:
  return null;

}
}

}

/// @nodoc


class _WishState implements WishState {
  const _WishState({this.isLoading = false, final  List<WishModel> starWishes = const [], final  List<WishModel> Wishes3 = const [], final  List<WishModel> totalWishes = const [], this.currentWishCount = 0, this.page = 0, this.hasMore = true}): _starWishes = starWishes,_Wishes3 = Wishes3,_totalWishes = totalWishes;
  

// API 호출 중 로딩 상태
@override@JsonKey() final  bool isLoading;
/// 즐겨찾기 위시리스트 (Top5)
 final  List<WishModel> _starWishes;
/// 즐겨찾기 위시리스트 (Top5)
@override@JsonKey() List<WishModel> get starWishes {
  if (_starWishes is EqualUnmodifiableListView) return _starWishes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_starWishes);
}

/// 위시리스트 상위 노출 3개
 final  List<WishModel> _Wishes3;
/// 위시리스트 상위 노출 3개
@override@JsonKey() List<WishModel> get Wishes3 {
  if (_Wishes3 is EqualUnmodifiableListView) return _Wishes3;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_Wishes3);
}

/// 전체 위시리스트 (페이지네이션으로 불러옴)
 final  List<WishModel> _totalWishes;
/// 전체 위시리스트 (페이지네이션으로 불러옴)
@override@JsonKey() List<WishModel> get totalWishes {
  if (_totalWishes is EqualUnmodifiableListView) return _totalWishes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_totalWishes);
}

/// 등록된 위시아이템 개수
@override@JsonKey() final  int currentWishCount;
// --- 페이지네이션을 위한 상태 ---
/// 다음에 불러올 페이지 번호
@override@JsonKey() final  int page;
/// 더 불러올 페이지가 남았는지 여부
@override@JsonKey() final  bool hasMore;

/// Create a copy of WishState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WishStateCopyWith<_WishState> get copyWith => __$WishStateCopyWithImpl<_WishState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WishState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other._starWishes, _starWishes)&&const DeepCollectionEquality().equals(other._Wishes3, _Wishes3)&&const DeepCollectionEquality().equals(other._totalWishes, _totalWishes)&&(identical(other.currentWishCount, currentWishCount) || other.currentWishCount == currentWishCount)&&(identical(other.page, page) || other.page == page)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,const DeepCollectionEquality().hash(_starWishes),const DeepCollectionEquality().hash(_Wishes3),const DeepCollectionEquality().hash(_totalWishes),currentWishCount,page,hasMore);

@override
String toString() {
  return 'WishState(isLoading: $isLoading, starWishes: $starWishes, Wishes3: $Wishes3, totalWishes: $totalWishes, currentWishCount: $currentWishCount, page: $page, hasMore: $hasMore)';
}


}

/// @nodoc
abstract mixin class _$WishStateCopyWith<$Res> implements $WishStateCopyWith<$Res> {
  factory _$WishStateCopyWith(_WishState value, $Res Function(_WishState) _then) = __$WishStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, List<WishModel> starWishes, List<WishModel> Wishes3, List<WishModel> totalWishes, int currentWishCount, int page, bool hasMore
});




}
/// @nodoc
class __$WishStateCopyWithImpl<$Res>
    implements _$WishStateCopyWith<$Res> {
  __$WishStateCopyWithImpl(this._self, this._then);

  final _WishState _self;
  final $Res Function(_WishState) _then;

/// Create a copy of WishState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? starWishes = null,Object? Wishes3 = null,Object? totalWishes = null,Object? currentWishCount = null,Object? page = null,Object? hasMore = null,}) {
  return _then(_WishState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,starWishes: null == starWishes ? _self._starWishes : starWishes // ignore: cast_nullable_to_non_nullable
as List<WishModel>,Wishes3: null == Wishes3 ? _self._Wishes3 : Wishes3 // ignore: cast_nullable_to_non_nullable
as List<WishModel>,totalWishes: null == totalWishes ? _self._totalWishes : totalWishes // ignore: cast_nullable_to_non_nullable
as List<WishModel>,currentWishCount: null == currentWishCount ? _self.currentWishCount : currentWishCount // ignore: cast_nullable_to_non_nullable
as int,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
