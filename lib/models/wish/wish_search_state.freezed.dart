// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wish_search_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$WishSearchState {

// API 통신 중 로딩 상태
 bool get isLoading;// 검색 정보
 SearchInfoModel? get searchInfo;// 검색된 상품 리스트
 List<ProductModel> get products;// 에러 메시지
 String? get errorMessage;
/// Create a copy of WishSearchState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WishSearchStateCopyWith<WishSearchState> get copyWith => _$WishSearchStateCopyWithImpl<WishSearchState>(this as WishSearchState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WishSearchState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.searchInfo, searchInfo) || other.searchInfo == searchInfo)&&const DeepCollectionEquality().equals(other.products, products)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,searchInfo,const DeepCollectionEquality().hash(products),errorMessage);

@override
String toString() {
  return 'WishSearchState(isLoading: $isLoading, searchInfo: $searchInfo, products: $products, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $WishSearchStateCopyWith<$Res>  {
  factory $WishSearchStateCopyWith(WishSearchState value, $Res Function(WishSearchState) _then) = _$WishSearchStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, SearchInfoModel? searchInfo, List<ProductModel> products, String? errorMessage
});


$SearchInfoModelCopyWith<$Res>? get searchInfo;

}
/// @nodoc
class _$WishSearchStateCopyWithImpl<$Res>
    implements $WishSearchStateCopyWith<$Res> {
  _$WishSearchStateCopyWithImpl(this._self, this._then);

  final WishSearchState _self;
  final $Res Function(WishSearchState) _then;

/// Create a copy of WishSearchState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? searchInfo = freezed,Object? products = null,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,searchInfo: freezed == searchInfo ? _self.searchInfo : searchInfo // ignore: cast_nullable_to_non_nullable
as SearchInfoModel?,products: null == products ? _self.products : products // ignore: cast_nullable_to_non_nullable
as List<ProductModel>,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of WishSearchState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SearchInfoModelCopyWith<$Res>? get searchInfo {
    if (_self.searchInfo == null) {
    return null;
  }

  return $SearchInfoModelCopyWith<$Res>(_self.searchInfo!, (value) {
    return _then(_self.copyWith(searchInfo: value));
  });
}
}


/// Adds pattern-matching-related methods to [WishSearchState].
extension WishSearchStatePatterns on WishSearchState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WishSearchState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WishSearchState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WishSearchState value)  $default,){
final _that = this;
switch (_that) {
case _WishSearchState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WishSearchState value)?  $default,){
final _that = this;
switch (_that) {
case _WishSearchState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  SearchInfoModel? searchInfo,  List<ProductModel> products,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WishSearchState() when $default != null:
return $default(_that.isLoading,_that.searchInfo,_that.products,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  SearchInfoModel? searchInfo,  List<ProductModel> products,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _WishSearchState():
return $default(_that.isLoading,_that.searchInfo,_that.products,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  SearchInfoModel? searchInfo,  List<ProductModel> products,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _WishSearchState() when $default != null:
return $default(_that.isLoading,_that.searchInfo,_that.products,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _WishSearchState implements WishSearchState {
  const _WishSearchState({this.isLoading = false, this.searchInfo, final  List<ProductModel> products = const [], this.errorMessage}): _products = products;
  

// API 통신 중 로딩 상태
@override@JsonKey() final  bool isLoading;
// 검색 정보
@override final  SearchInfoModel? searchInfo;
// 검색된 상품 리스트
 final  List<ProductModel> _products;
// 검색된 상품 리스트
@override@JsonKey() List<ProductModel> get products {
  if (_products is EqualUnmodifiableListView) return _products;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_products);
}

// 에러 메시지
@override final  String? errorMessage;

/// Create a copy of WishSearchState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WishSearchStateCopyWith<_WishSearchState> get copyWith => __$WishSearchStateCopyWithImpl<_WishSearchState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WishSearchState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.searchInfo, searchInfo) || other.searchInfo == searchInfo)&&const DeepCollectionEquality().equals(other._products, _products)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,searchInfo,const DeepCollectionEquality().hash(_products),errorMessage);

@override
String toString() {
  return 'WishSearchState(isLoading: $isLoading, searchInfo: $searchInfo, products: $products, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$WishSearchStateCopyWith<$Res> implements $WishSearchStateCopyWith<$Res> {
  factory _$WishSearchStateCopyWith(_WishSearchState value, $Res Function(_WishSearchState) _then) = __$WishSearchStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, SearchInfoModel? searchInfo, List<ProductModel> products, String? errorMessage
});


@override $SearchInfoModelCopyWith<$Res>? get searchInfo;

}
/// @nodoc
class __$WishSearchStateCopyWithImpl<$Res>
    implements _$WishSearchStateCopyWith<$Res> {
  __$WishSearchStateCopyWithImpl(this._self, this._then);

  final _WishSearchState _self;
  final $Res Function(_WishSearchState) _then;

/// Create a copy of WishSearchState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? searchInfo = freezed,Object? products = null,Object? errorMessage = freezed,}) {
  return _then(_WishSearchState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,searchInfo: freezed == searchInfo ? _self.searchInfo : searchInfo // ignore: cast_nullable_to_non_nullable
as SearchInfoModel?,products: null == products ? _self._products : products // ignore: cast_nullable_to_non_nullable
as List<ProductModel>,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of WishSearchState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SearchInfoModelCopyWith<$Res>? get searchInfo {
    if (_self.searchInfo == null) {
    return null;
  }

  return $SearchInfoModelCopyWith<$Res>(_self.searchInfo!, (value) {
    return _then(_self.copyWith(searchInfo: value));
  });
}
}


/// @nodoc
mixin _$SearchInfoModel {

 int get totalCount; String get query; bool get useCache; bool get removeBackground;
/// Create a copy of SearchInfoModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SearchInfoModelCopyWith<SearchInfoModel> get copyWith => _$SearchInfoModelCopyWithImpl<SearchInfoModel>(this as SearchInfoModel, _$identity);

  /// Serializes this SearchInfoModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchInfoModel&&(identical(other.totalCount, totalCount) || other.totalCount == totalCount)&&(identical(other.query, query) || other.query == query)&&(identical(other.useCache, useCache) || other.useCache == useCache)&&(identical(other.removeBackground, removeBackground) || other.removeBackground == removeBackground));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalCount,query,useCache,removeBackground);

@override
String toString() {
  return 'SearchInfoModel(totalCount: $totalCount, query: $query, useCache: $useCache, removeBackground: $removeBackground)';
}


}

/// @nodoc
abstract mixin class $SearchInfoModelCopyWith<$Res>  {
  factory $SearchInfoModelCopyWith(SearchInfoModel value, $Res Function(SearchInfoModel) _then) = _$SearchInfoModelCopyWithImpl;
@useResult
$Res call({
 int totalCount, String query, bool useCache, bool removeBackground
});




}
/// @nodoc
class _$SearchInfoModelCopyWithImpl<$Res>
    implements $SearchInfoModelCopyWith<$Res> {
  _$SearchInfoModelCopyWithImpl(this._self, this._then);

  final SearchInfoModel _self;
  final $Res Function(SearchInfoModel) _then;

/// Create a copy of SearchInfoModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalCount = null,Object? query = null,Object? useCache = null,Object? removeBackground = null,}) {
  return _then(_self.copyWith(
totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,useCache: null == useCache ? _self.useCache : useCache // ignore: cast_nullable_to_non_nullable
as bool,removeBackground: null == removeBackground ? _self.removeBackground : removeBackground // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [SearchInfoModel].
extension SearchInfoModelPatterns on SearchInfoModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SearchInfoModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SearchInfoModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SearchInfoModel value)  $default,){
final _that = this;
switch (_that) {
case _SearchInfoModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SearchInfoModel value)?  $default,){
final _that = this;
switch (_that) {
case _SearchInfoModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int totalCount,  String query,  bool useCache,  bool removeBackground)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SearchInfoModel() when $default != null:
return $default(_that.totalCount,_that.query,_that.useCache,_that.removeBackground);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int totalCount,  String query,  bool useCache,  bool removeBackground)  $default,) {final _that = this;
switch (_that) {
case _SearchInfoModel():
return $default(_that.totalCount,_that.query,_that.useCache,_that.removeBackground);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int totalCount,  String query,  bool useCache,  bool removeBackground)?  $default,) {final _that = this;
switch (_that) {
case _SearchInfoModel() when $default != null:
return $default(_that.totalCount,_that.query,_that.useCache,_that.removeBackground);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SearchInfoModel implements SearchInfoModel {
  const _SearchInfoModel({required this.totalCount, required this.query, this.useCache = false, this.removeBackground = false});
  factory _SearchInfoModel.fromJson(Map<String, dynamic> json) => _$SearchInfoModelFromJson(json);

@override final  int totalCount;
@override final  String query;
@override@JsonKey() final  bool useCache;
@override@JsonKey() final  bool removeBackground;

/// Create a copy of SearchInfoModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SearchInfoModelCopyWith<_SearchInfoModel> get copyWith => __$SearchInfoModelCopyWithImpl<_SearchInfoModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SearchInfoModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SearchInfoModel&&(identical(other.totalCount, totalCount) || other.totalCount == totalCount)&&(identical(other.query, query) || other.query == query)&&(identical(other.useCache, useCache) || other.useCache == useCache)&&(identical(other.removeBackground, removeBackground) || other.removeBackground == removeBackground));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalCount,query,useCache,removeBackground);

@override
String toString() {
  return 'SearchInfoModel(totalCount: $totalCount, query: $query, useCache: $useCache, removeBackground: $removeBackground)';
}


}

/// @nodoc
abstract mixin class _$SearchInfoModelCopyWith<$Res> implements $SearchInfoModelCopyWith<$Res> {
  factory _$SearchInfoModelCopyWith(_SearchInfoModel value, $Res Function(_SearchInfoModel) _then) = __$SearchInfoModelCopyWithImpl;
@override @useResult
$Res call({
 int totalCount, String query, bool useCache, bool removeBackground
});




}
/// @nodoc
class __$SearchInfoModelCopyWithImpl<$Res>
    implements _$SearchInfoModelCopyWith<$Res> {
  __$SearchInfoModelCopyWithImpl(this._self, this._then);

  final _SearchInfoModel _self;
  final $Res Function(_SearchInfoModel) _then;

/// Create a copy of SearchInfoModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalCount = null,Object? query = null,Object? useCache = null,Object? removeBackground = null,}) {
  return _then(_SearchInfoModel(
totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,useCache: null == useCache ? _self.useCache : useCache // ignore: cast_nullable_to_non_nullable
as bool,removeBackground: null == removeBackground ? _self.removeBackground : removeBackground // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$ProductModel {

 String get id; String get name; double get price; String get imageUrl; String get url; String? get maker;
/// Create a copy of ProductModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductModelCopyWith<ProductModel> get copyWith => _$ProductModelCopyWithImpl<ProductModel>(this as ProductModel, _$identity);

  /// Serializes this ProductModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.price, price) || other.price == price)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.url, url) || other.url == url)&&(identical(other.maker, maker) || other.maker == maker));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,price,imageUrl,url,maker);

@override
String toString() {
  return 'ProductModel(id: $id, name: $name, price: $price, imageUrl: $imageUrl, url: $url, maker: $maker)';
}


}

/// @nodoc
abstract mixin class $ProductModelCopyWith<$Res>  {
  factory $ProductModelCopyWith(ProductModel value, $Res Function(ProductModel) _then) = _$ProductModelCopyWithImpl;
@useResult
$Res call({
 String id, String name, double price, String imageUrl, String url, String? maker
});




}
/// @nodoc
class _$ProductModelCopyWithImpl<$Res>
    implements $ProductModelCopyWith<$Res> {
  _$ProductModelCopyWithImpl(this._self, this._then);

  final ProductModel _self;
  final $Res Function(ProductModel) _then;

/// Create a copy of ProductModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? price = null,Object? imageUrl = null,Object? url = null,Object? maker = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,maker: freezed == maker ? _self.maker : maker // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ProductModel].
extension ProductModelPatterns on ProductModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProductModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProductModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProductModel value)  $default,){
final _that = this;
switch (_that) {
case _ProductModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProductModel value)?  $default,){
final _that = this;
switch (_that) {
case _ProductModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  double price,  String imageUrl,  String url,  String? maker)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProductModel() when $default != null:
return $default(_that.id,_that.name,_that.price,_that.imageUrl,_that.url,_that.maker);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  double price,  String imageUrl,  String url,  String? maker)  $default,) {final _that = this;
switch (_that) {
case _ProductModel():
return $default(_that.id,_that.name,_that.price,_that.imageUrl,_that.url,_that.maker);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  double price,  String imageUrl,  String url,  String? maker)?  $default,) {final _that = this;
switch (_that) {
case _ProductModel() when $default != null:
return $default(_that.id,_that.name,_that.price,_that.imageUrl,_that.url,_that.maker);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProductModel implements ProductModel {
  const _ProductModel({required this.id, required this.name, required this.price, required this.imageUrl, required this.url, this.maker});
  factory _ProductModel.fromJson(Map<String, dynamic> json) => _$ProductModelFromJson(json);

@override final  String id;
@override final  String name;
@override final  double price;
@override final  String imageUrl;
@override final  String url;
@override final  String? maker;

/// Create a copy of ProductModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProductModelCopyWith<_ProductModel> get copyWith => __$ProductModelCopyWithImpl<_ProductModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProductModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProductModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.price, price) || other.price == price)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.url, url) || other.url == url)&&(identical(other.maker, maker) || other.maker == maker));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,price,imageUrl,url,maker);

@override
String toString() {
  return 'ProductModel(id: $id, name: $name, price: $price, imageUrl: $imageUrl, url: $url, maker: $maker)';
}


}

/// @nodoc
abstract mixin class _$ProductModelCopyWith<$Res> implements $ProductModelCopyWith<$Res> {
  factory _$ProductModelCopyWith(_ProductModel value, $Res Function(_ProductModel) _then) = __$ProductModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, double price, String imageUrl, String url, String? maker
});




}
/// @nodoc
class __$ProductModelCopyWithImpl<$Res>
    implements _$ProductModelCopyWith<$Res> {
  __$ProductModelCopyWithImpl(this._self, this._then);

  final _ProductModel _self;
  final $Res Function(_ProductModel) _then;

/// Create a copy of ProductModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? price = null,Object? imageUrl = null,Object? url = null,Object? maker = freezed,}) {
  return _then(_ProductModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,maker: freezed == maker ? _self.maker : maker // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
