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

 bool get isLoading; List<WishModel> get starWishes; List<WishModel> get Wishes3; List<WishModel> get totalWishes;/// 나의 정보
 ProfileUserModel? get userInfo;/// 타 사용자 정보
 List<SimpleUserModel> get userList;// --- 전체 리스트 기능을 위한 상태 추가 ---
 int get currentWishCount; int get page; bool get hasMore;// --- 검색 기능을 위한 상태 추가 ---
/// 검색 API 호출 중 로딩 상태
 bool get isSearching;/// 검색 결과 리스트
 List<WishModel> get searchResults;/// 다음에 불러올 검색 결과 페이지 번호
 int get searchPage;/// 더 불러올 검색 결과가 남았는지 여부
 bool get searchHasMore;
/// Create a copy of WishState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WishStateCopyWith<WishState> get copyWith => _$WishStateCopyWithImpl<WishState>(this as WishState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WishState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other.starWishes, starWishes)&&const DeepCollectionEquality().equals(other.Wishes3, Wishes3)&&const DeepCollectionEquality().equals(other.totalWishes, totalWishes)&&(identical(other.userInfo, userInfo) || other.userInfo == userInfo)&&const DeepCollectionEquality().equals(other.userList, userList)&&(identical(other.currentWishCount, currentWishCount) || other.currentWishCount == currentWishCount)&&(identical(other.page, page) || other.page == page)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.isSearching, isSearching) || other.isSearching == isSearching)&&const DeepCollectionEquality().equals(other.searchResults, searchResults)&&(identical(other.searchPage, searchPage) || other.searchPage == searchPage)&&(identical(other.searchHasMore, searchHasMore) || other.searchHasMore == searchHasMore));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,const DeepCollectionEquality().hash(starWishes),const DeepCollectionEquality().hash(Wishes3),const DeepCollectionEquality().hash(totalWishes),userInfo,const DeepCollectionEquality().hash(userList),currentWishCount,page,hasMore,isSearching,const DeepCollectionEquality().hash(searchResults),searchPage,searchHasMore);

@override
String toString() {
  return 'WishState(isLoading: $isLoading, starWishes: $starWishes, Wishes3: $Wishes3, totalWishes: $totalWishes, userInfo: $userInfo, userList: $userList, currentWishCount: $currentWishCount, page: $page, hasMore: $hasMore, isSearching: $isSearching, searchResults: $searchResults, searchPage: $searchPage, searchHasMore: $searchHasMore)';
}


}

/// @nodoc
abstract mixin class $WishStateCopyWith<$Res>  {
  factory $WishStateCopyWith(WishState value, $Res Function(WishState) _then) = _$WishStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, List<WishModel> starWishes, List<WishModel> Wishes3, List<WishModel> totalWishes, ProfileUserModel? userInfo, List<SimpleUserModel> userList, int currentWishCount, int page, bool hasMore, bool isSearching, List<WishModel> searchResults, int searchPage, bool searchHasMore
});


$ProfileUserModelCopyWith<$Res>? get userInfo;

}
/// @nodoc
class _$WishStateCopyWithImpl<$Res>
    implements $WishStateCopyWith<$Res> {
  _$WishStateCopyWithImpl(this._self, this._then);

  final WishState _self;
  final $Res Function(WishState) _then;

/// Create a copy of WishState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? starWishes = null,Object? Wishes3 = null,Object? totalWishes = null,Object? userInfo = freezed,Object? userList = null,Object? currentWishCount = null,Object? page = null,Object? hasMore = null,Object? isSearching = null,Object? searchResults = null,Object? searchPage = null,Object? searchHasMore = null,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,starWishes: null == starWishes ? _self.starWishes : starWishes // ignore: cast_nullable_to_non_nullable
as List<WishModel>,Wishes3: null == Wishes3 ? _self.Wishes3 : Wishes3 // ignore: cast_nullable_to_non_nullable
as List<WishModel>,totalWishes: null == totalWishes ? _self.totalWishes : totalWishes // ignore: cast_nullable_to_non_nullable
as List<WishModel>,userInfo: freezed == userInfo ? _self.userInfo : userInfo // ignore: cast_nullable_to_non_nullable
as ProfileUserModel?,userList: null == userList ? _self.userList : userList // ignore: cast_nullable_to_non_nullable
as List<SimpleUserModel>,currentWishCount: null == currentWishCount ? _self.currentWishCount : currentWishCount // ignore: cast_nullable_to_non_nullable
as int,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,isSearching: null == isSearching ? _self.isSearching : isSearching // ignore: cast_nullable_to_non_nullable
as bool,searchResults: null == searchResults ? _self.searchResults : searchResults // ignore: cast_nullable_to_non_nullable
as List<WishModel>,searchPage: null == searchPage ? _self.searchPage : searchPage // ignore: cast_nullable_to_non_nullable
as int,searchHasMore: null == searchHasMore ? _self.searchHasMore : searchHasMore // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of WishState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProfileUserModelCopyWith<$Res>? get userInfo {
    if (_self.userInfo == null) {
    return null;
  }

  return $ProfileUserModelCopyWith<$Res>(_self.userInfo!, (value) {
    return _then(_self.copyWith(userInfo: value));
  });
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  List<WishModel> starWishes,  List<WishModel> Wishes3,  List<WishModel> totalWishes,  ProfileUserModel? userInfo,  List<SimpleUserModel> userList,  int currentWishCount,  int page,  bool hasMore,  bool isSearching,  List<WishModel> searchResults,  int searchPage,  bool searchHasMore)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WishState() when $default != null:
return $default(_that.isLoading,_that.starWishes,_that.Wishes3,_that.totalWishes,_that.userInfo,_that.userList,_that.currentWishCount,_that.page,_that.hasMore,_that.isSearching,_that.searchResults,_that.searchPage,_that.searchHasMore);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  List<WishModel> starWishes,  List<WishModel> Wishes3,  List<WishModel> totalWishes,  ProfileUserModel? userInfo,  List<SimpleUserModel> userList,  int currentWishCount,  int page,  bool hasMore,  bool isSearching,  List<WishModel> searchResults,  int searchPage,  bool searchHasMore)  $default,) {final _that = this;
switch (_that) {
case _WishState():
return $default(_that.isLoading,_that.starWishes,_that.Wishes3,_that.totalWishes,_that.userInfo,_that.userList,_that.currentWishCount,_that.page,_that.hasMore,_that.isSearching,_that.searchResults,_that.searchPage,_that.searchHasMore);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  List<WishModel> starWishes,  List<WishModel> Wishes3,  List<WishModel> totalWishes,  ProfileUserModel? userInfo,  List<SimpleUserModel> userList,  int currentWishCount,  int page,  bool hasMore,  bool isSearching,  List<WishModel> searchResults,  int searchPage,  bool searchHasMore)?  $default,) {final _that = this;
switch (_that) {
case _WishState() when $default != null:
return $default(_that.isLoading,_that.starWishes,_that.Wishes3,_that.totalWishes,_that.userInfo,_that.userList,_that.currentWishCount,_that.page,_that.hasMore,_that.isSearching,_that.searchResults,_that.searchPage,_that.searchHasMore);case _:
  return null;

}
}

}

/// @nodoc


class _WishState implements WishState {
  const _WishState({this.isLoading = false, final  List<WishModel> starWishes = const [], final  List<WishModel> Wishes3 = const [], final  List<WishModel> totalWishes = const [], this.userInfo, final  List<SimpleUserModel> userList = const [], this.currentWishCount = 0, this.page = 0, this.hasMore = true, this.isSearching = false, final  List<WishModel> searchResults = const [], this.searchPage = 0, this.searchHasMore = true}): _starWishes = starWishes,_Wishes3 = Wishes3,_totalWishes = totalWishes,_userList = userList,_searchResults = searchResults;
  

@override@JsonKey() final  bool isLoading;
 final  List<WishModel> _starWishes;
@override@JsonKey() List<WishModel> get starWishes {
  if (_starWishes is EqualUnmodifiableListView) return _starWishes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_starWishes);
}

 final  List<WishModel> _Wishes3;
@override@JsonKey() List<WishModel> get Wishes3 {
  if (_Wishes3 is EqualUnmodifiableListView) return _Wishes3;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_Wishes3);
}

 final  List<WishModel> _totalWishes;
@override@JsonKey() List<WishModel> get totalWishes {
  if (_totalWishes is EqualUnmodifiableListView) return _totalWishes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_totalWishes);
}

/// 나의 정보
@override final  ProfileUserModel? userInfo;
/// 타 사용자 정보
 final  List<SimpleUserModel> _userList;
/// 타 사용자 정보
@override@JsonKey() List<SimpleUserModel> get userList {
  if (_userList is EqualUnmodifiableListView) return _userList;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_userList);
}

// --- 전체 리스트 기능을 위한 상태 추가 ---
@override@JsonKey() final  int currentWishCount;
@override@JsonKey() final  int page;
@override@JsonKey() final  bool hasMore;
// --- 검색 기능을 위한 상태 추가 ---
/// 검색 API 호출 중 로딩 상태
@override@JsonKey() final  bool isSearching;
/// 검색 결과 리스트
 final  List<WishModel> _searchResults;
/// 검색 결과 리스트
@override@JsonKey() List<WishModel> get searchResults {
  if (_searchResults is EqualUnmodifiableListView) return _searchResults;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_searchResults);
}

/// 다음에 불러올 검색 결과 페이지 번호
@override@JsonKey() final  int searchPage;
/// 더 불러올 검색 결과가 남았는지 여부
@override@JsonKey() final  bool searchHasMore;

/// Create a copy of WishState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WishStateCopyWith<_WishState> get copyWith => __$WishStateCopyWithImpl<_WishState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WishState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other._starWishes, _starWishes)&&const DeepCollectionEquality().equals(other._Wishes3, _Wishes3)&&const DeepCollectionEquality().equals(other._totalWishes, _totalWishes)&&(identical(other.userInfo, userInfo) || other.userInfo == userInfo)&&const DeepCollectionEquality().equals(other._userList, _userList)&&(identical(other.currentWishCount, currentWishCount) || other.currentWishCount == currentWishCount)&&(identical(other.page, page) || other.page == page)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.isSearching, isSearching) || other.isSearching == isSearching)&&const DeepCollectionEquality().equals(other._searchResults, _searchResults)&&(identical(other.searchPage, searchPage) || other.searchPage == searchPage)&&(identical(other.searchHasMore, searchHasMore) || other.searchHasMore == searchHasMore));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,const DeepCollectionEquality().hash(_starWishes),const DeepCollectionEquality().hash(_Wishes3),const DeepCollectionEquality().hash(_totalWishes),userInfo,const DeepCollectionEquality().hash(_userList),currentWishCount,page,hasMore,isSearching,const DeepCollectionEquality().hash(_searchResults),searchPage,searchHasMore);

@override
String toString() {
  return 'WishState(isLoading: $isLoading, starWishes: $starWishes, Wishes3: $Wishes3, totalWishes: $totalWishes, userInfo: $userInfo, userList: $userList, currentWishCount: $currentWishCount, page: $page, hasMore: $hasMore, isSearching: $isSearching, searchResults: $searchResults, searchPage: $searchPage, searchHasMore: $searchHasMore)';
}


}

/// @nodoc
abstract mixin class _$WishStateCopyWith<$Res> implements $WishStateCopyWith<$Res> {
  factory _$WishStateCopyWith(_WishState value, $Res Function(_WishState) _then) = __$WishStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, List<WishModel> starWishes, List<WishModel> Wishes3, List<WishModel> totalWishes, ProfileUserModel? userInfo, List<SimpleUserModel> userList, int currentWishCount, int page, bool hasMore, bool isSearching, List<WishModel> searchResults, int searchPage, bool searchHasMore
});


@override $ProfileUserModelCopyWith<$Res>? get userInfo;

}
/// @nodoc
class __$WishStateCopyWithImpl<$Res>
    implements _$WishStateCopyWith<$Res> {
  __$WishStateCopyWithImpl(this._self, this._then);

  final _WishState _self;
  final $Res Function(_WishState) _then;

/// Create a copy of WishState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? starWishes = null,Object? Wishes3 = null,Object? totalWishes = null,Object? userInfo = freezed,Object? userList = null,Object? currentWishCount = null,Object? page = null,Object? hasMore = null,Object? isSearching = null,Object? searchResults = null,Object? searchPage = null,Object? searchHasMore = null,}) {
  return _then(_WishState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,starWishes: null == starWishes ? _self._starWishes : starWishes // ignore: cast_nullable_to_non_nullable
as List<WishModel>,Wishes3: null == Wishes3 ? _self._Wishes3 : Wishes3 // ignore: cast_nullable_to_non_nullable
as List<WishModel>,totalWishes: null == totalWishes ? _self._totalWishes : totalWishes // ignore: cast_nullable_to_non_nullable
as List<WishModel>,userInfo: freezed == userInfo ? _self.userInfo : userInfo // ignore: cast_nullable_to_non_nullable
as ProfileUserModel?,userList: null == userList ? _self._userList : userList // ignore: cast_nullable_to_non_nullable
as List<SimpleUserModel>,currentWishCount: null == currentWishCount ? _self.currentWishCount : currentWishCount // ignore: cast_nullable_to_non_nullable
as int,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,isSearching: null == isSearching ? _self.isSearching : isSearching // ignore: cast_nullable_to_non_nullable
as bool,searchResults: null == searchResults ? _self._searchResults : searchResults // ignore: cast_nullable_to_non_nullable
as List<WishModel>,searchPage: null == searchPage ? _self.searchPage : searchPage // ignore: cast_nullable_to_non_nullable
as int,searchHasMore: null == searchHasMore ? _self.searchHasMore : searchHasMore // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of WishState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProfileUserModelCopyWith<$Res>? get userInfo {
    if (_self.userInfo == null) {
    return null;
  }

  return $ProfileUserModelCopyWith<$Res>(_self.userInfo!, (value) {
    return _then(_self.copyWith(userInfo: value));
  });
}
}

// dart format on
