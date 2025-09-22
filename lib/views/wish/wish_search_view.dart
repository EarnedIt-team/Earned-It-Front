import 'package:earned_it/config/design.dart';
import 'package:earned_it/models/wish/wish_filter_state.dart';
import 'package:earned_it/models/wish/wish_model.dart';
import 'package:earned_it/view_models/wish/wish_filter_provider.dart';
import 'package:earned_it/view_models/wish/wish_provider.dart';
import 'package:earned_it/views/wish/wish_all_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class WishSearchView extends ConsumerStatefulWidget {
  const WishSearchView({super.key});

  @override
  ConsumerState<WishSearchView> createState() => _WishSearchViewState();
}

class _WishSearchViewState extends ConsumerState<WishSearchView> {
  final _scrollController = ScrollController();
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // 👇 1. (핵심 수정) 화면에 진입할 때 검색 결과를 초기화합니다.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(wishViewModelProvider.notifier).clearSearchResults();
    });

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        ref
            .read(wishViewModelProvider.notifier)
            .searchWishes(context, keyword: _searchController.text);
      }
    });
  }

  @override
  void dispose() {
    FocusScope.of(context).unfocus();
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _performSearch() {
    ref
        .read(wishViewModelProvider.notifier)
        .searchWishes(
          context,
          keyword: _searchController.text,
          isNewSearch: true,
        );
  }

  @override
  Widget build(BuildContext context) {
    final wishState = ref.watch(wishViewModelProvider);
    final searchResults = wishState.searchResults;

    // 필터가 변경되면 새로운 검색을 수행
    ref.listen<WishFilterState>(wishFilterViewModelProvider, (previous, next) {
      if (previous != next) {
        _performSearch();
      }
    });

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor:
            Theme.of(context).brightness == Brightness.dark
                ? Colors.black
                : lightColor2,
        appBar: AppBar(
          backgroundColor:
              Theme.of(context).brightness == Brightness.dark
                  ? Colors.black
                  : lightColor2,
          title: TextField(
            controller: _searchController,
            autofocus: true,
            decoration: InputDecoration(
              hintText: '위시리스트 검색...',
              hintStyle: const TextStyle(color: Colors.grey),
              border: InputBorder.none,
              suffixIcon: IconButton(
                icon: Icon(
                  Icons.search,
                  color:
                      Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
                ),
                onPressed: _performSearch,
              ),
            ),
            onSubmitted: (_) => _performSearch(),
          ),
          scrolledUnderElevation: 0,
        ),
        body: Column(
          children: [
            _buildFilterBar(context, ref),
            Expanded(
              child:
                  searchResults.isEmpty && !wishState.isSearching
                      ? const Center(child: Text('검색 결과가 없습니다.'))
                      : ListView.builder(
                        keyboardDismissBehavior:
                            ScrollViewKeyboardDismissBehavior.onDrag,
                        controller: _scrollController,
                        itemCount:
                            searchResults.length +
                            (wishState.searchHasMore ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (index == searchResults.length) {
                            return wishState.isSearching
                                ? const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 16.0),
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                )
                                : const SizedBox.shrink();
                          }
                          final item = searchResults[index];
                          return _AllWishlistItem(
                            key: ValueKey(item.wishId),
                            item: item,
                          );
                        },
                      ),
            ),
          ],
        ),
      ),
    );
  }

  // --- 필터 바 위젯 ---
  Widget _buildFilterBar(BuildContext context, WidgetRef ref) {
    final filterState = ref.watch(wishFilterViewModelProvider);
    final filterNotifier = ref.read(wishFilterViewModelProvider.notifier);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _buildSortButton(
              context,
              filterNotifier,
              filterState,
              SortKey.name,
              "이름",
            ),
            _buildSortButton(
              context,
              filterNotifier,
              filterState,
              SortKey.createdAt,
              "생성순",
            ),
            _buildSortButton(
              context,
              filterNotifier,
              filterState,
              SortKey.price,
              "가격",
            ),
            const VerticalDivider(width: 16, thickness: 1),
            _buildFilterChip(
              context,
              filterNotifier.toggleStarFilter,
              filterState.filterByStarred,
              "Star",
            ),
            _buildFilterChip(
              context,
              filterNotifier.toggleBoughtFilter,
              filterState.filterByBought,
              "구매 여부",
            ),
          ],
        ),
      ),
    );
  }

  // --- 정렬 버튼 위젯 ---
  Widget _buildSortButton(
    BuildContext context,
    WishFilterViewModel notifier,
    WishFilterState state,
    SortKey key,
    String label,
  ) {
    final bool isActive = state.sortKey == key;
    return TextButton.icon(
      onPressed: () => notifier.selectSort(key),
      icon:
          isActive
              ? Icon(
                state.sortDirection == SortDirection.asc
                    ? Icons.arrow_upward
                    : Icons.arrow_downward,
                size: 16,
              )
              : const SizedBox.shrink(),
      label: Text(label),
      style: TextButton.styleFrom(
        foregroundColor:
            isActive ? Theme.of(context).colorScheme.primary : Colors.grey,
      ),
    );
  }

  // --- 필터 칩 위젯 ---
  Widget _buildFilterChip(
    BuildContext context,
    VoidCallback onPressed,
    bool isSelected,
    String label,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: FilterChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (_) => onPressed(),
        selectedColor: primaryGradientStart,
      ),
    );
  }
}

class _AllWishlistItem extends ConsumerWidget {
  final WishModel item;

  const _AllWishlistItem({super.key, required this.item});

  // 진행률에 따라 색상을 반환하는 함수
  Color _getProgressColor(double progress) {
    if (progress >= 1.0) return Colors.green; // 100% 달성 시
    if (progress >= 0.8) return Colors.purple;
    if (progress >= 0.5) return Colors.blue;
    if (progress >= 0.3) return Colors.orange;
    return Colors.red;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currencyFormat = NumberFormat.decimalPattern('ko_KR');
    final wishState = ref.watch(wishViewModelProvider);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: context.middlePadding / 2),
      child: Card(
        color:
            Theme.of(context).brightness == Brightness.dark
                ? lightDarkColor
                : Colors.white,
        margin: EdgeInsets.symmetric(vertical: context.height(0.005)),
        elevation: 0,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Slidable(
            key: ValueKey(item.wishId),
            child: InkWell(
              onTap: () {
                context.push('/wishDetail', extra: item);
              },
              child: Container(
                padding: EdgeInsets.only(
                  left: item.bought || item.starred ? 0 : context.middlePadding,
                  right: context.middlePadding,
                ),
                constraints: BoxConstraints(minHeight: context.height(0.1)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(width: context.middlePadding / 4),
                    Column(
                      children: [
                        if (item.starred)
                          Icon(
                            Icons.stars,
                            size: context.width(0.04),
                            color: Colors.amber,
                          ),
                        if (item.bought && item.starred)
                          SizedBox(height: context.height(0.01)),
                        if (item.bought)
                          Icon(
                            Icons.check_circle,
                            size: context.width(0.04),
                            color: Colors.lightBlue,
                          ),
                      ],
                    ),
                    SizedBox(width: context.middlePadding / 4),
                    SizedBox(
                      width: context.height(0.08),
                      height: context.height(0.08),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(width: 1, color: Colors.grey),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            item.itemImage,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: Colors.grey.shade200,
                                child: const Icon(
                                  Icons.image_not_supported_outlined,
                                  color: Colors.grey,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(right: context.width(0.05)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Text(
                                  item.vendor,
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: context.width(0.032),
                                    height: 1,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),

                            Text(
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              item.name,
                              style: TextStyle(
                                color:
                                    Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors.white
                                        : const Color.fromARGB(255, 44, 44, 44),
                                fontWeight: FontWeight.w600,
                                fontSize: context.width(0.04),
                                height: 1.5,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              '${currencyFormat.format(item.price)} 원',
                              style: TextStyle(
                                fontSize: context.width(0.04),
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
