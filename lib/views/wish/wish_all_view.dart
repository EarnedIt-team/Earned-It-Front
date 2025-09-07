import 'package:earned_it/config/design.dart';
import 'package:earned_it/models/wish/wish_filter_state.dart';
import 'package:earned_it/models/wish/wish_model.dart';
import 'package:earned_it/view_models/user/user_provider.dart';
import 'package:earned_it/view_models/wish/wish_filter_provider.dart';
import 'package:earned_it/view_models/wish/wish_provider.dart';
import 'package:earned_it/views/loading_overlay_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

final filteredWishesProvider = Provider.autoDispose<List<WishModel>>((ref) {
  // 필터 조건과 원본 리스트를 감시
  final filterState = ref.watch(wishFilterViewModelProvider);
  final allWishes = ref.watch(
    wishViewModelProvider.select((s) => s.totalWishes),
  );

  List<WishModel> filteredList = List.from(allWishes);

  // --- 필터링 로직 ---
  if (filterState.filterByStarred) {
    filteredList.retainWhere((item) => item.starred);
  }
  if (filterState.filterByBought) {
    filteredList.retainWhere((item) => item.bought);
  }

  // --- 정렬 로직 ---
  if (filterState.sortKey != null) {
    filteredList.sort((a, b) {
      int comparison = 0;
      switch (filterState.sortKey!) {
        case SortKey.name:
          comparison = a.name.compareTo(b.name);
          break;
        case SortKey.createdAt:
          // 최신순이 기본이 되도록 b와 a를 비교
          comparison = b.createdAt.compareTo(a.createdAt);
          break;
        case SortKey.price:
          comparison = a.price.compareTo(b.price);
          break;
      }
      // 내림차순일 경우 순서를 뒤집음
      return filterState.sortDirection == SortDirection.desc
          ? -comparison
          : comparison;
    });
  }

  return filteredList;
});

// 1. ConsumerWidget -> ConsumerStatefulWidget으로 변경
class WishAllView extends ConsumerStatefulWidget {
  const WishAllView({super.key});

  @override
  ConsumerState<WishAllView> createState() => _WishAllViewState();
}

class _WishAllViewState extends ConsumerState<WishAllView> {
  // 2. initState 추가: 위젯이 처음 생성될 때 한 번만 실행
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    final filterState = ref.read(wishFilterViewModelProvider);

    // 2. 위젯이 처음 생성될 때 첫 페이지 데이터 로드
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(wishViewModelProvider.notifier).resetAndFetchWishes(context);
    });

    // // 3. 스크롤 리스너 추가
    // _scrollController.addListener(() {
    //   // 스크롤이 맨 아래에 도달했을 때 다음 페이지 데이터 로드
    //   if (_scrollController.position.pixels ==
    //       _scrollController.position.maxScrollExtent) {
    //     ref.read(wishViewModelProvider.notifier).fetchMoreWishes(context);
    //   }
    // });

    _scrollController.addListener(() {
      final filterState = ref.read(wishFilterViewModelProvider);
      // 필터가 적용되지 않았을 때만 무한 스크롤 동작
      if (!filterState.isFiltered &&
          _scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent) {
        ref.read(wishViewModelProvider.notifier).fetchMoreWishes(context);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final wishState = ref.watch(wishViewModelProvider);
    // star가 아닌 아이템들만 필터링하여 '전체' 리스트로 사용
    final displayedWishes = ref.watch(filteredWishesProvider);
    final filterState = ref.watch(
      wishFilterViewModelProvider,
    ); // isFiltered 사용을 위해 watch

    // 👇 (핵심 수정) 정렬(sort) 옵션이 변경되었을 때만 API를 다시 호출합니다.
    ref.listen<WishFilterState>(wishFilterViewModelProvider, (previous, next) {
      // 이전 상태가 null이 아닐 때만 비교
      if (previous != null) {
        // 정렬 키 또는 방향이 변경되었는지 확인
        final sortChanged =
            previous.sortKey != next.sortKey ||
            previous.sortDirection != next.sortDirection;

        // 정렬 옵션이 변경되었을 때만 데이터를 새로고침
        if (sortChanged) {
          ref.read(wishViewModelProvider.notifier).resetAndFetchWishes(context);
        }
      }
    });

    return Stack(
      children: [
        Scaffold(
          backgroundColor:
              Theme.of(context).brightness == Brightness.dark
                  ? Colors.black
                  : lightColor2,
          appBar: AppBar(
            backgroundColor:
                Theme.of(context).brightness == Brightness.dark
                    ? Colors.black
                    : lightColor2,
            scrolledUnderElevation: 0,
            title: const Text(
              '전체 위시리스트',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            centerTitle: false,
            actions: <Widget>[
              IconButton(
                onPressed: () => context.push('/wishSearch'),
                icon: const Icon(Icons.search),
              ),
            ],
            actionsPadding: EdgeInsets.symmetric(
              horizontal: context.middlePadding / 2,
            ),
          ),
          body: Column(
            children: [
              _buildFilterBar(context, ref),
              Expanded(
                child:
                    displayedWishes.isEmpty && !wishState.isLoading
                        ? const Center(
                          child: Text(
                            '위시리스트가 비어있습니다.',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        )
                        : ListView.builder(
                          controller: _scrollController,
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount:
                              displayedWishes.length +
                              (wishState.hasMore && !filterState.isFiltered
                                  ? 1
                                  : 0),
                          itemBuilder: (context, index) {
                            // 로딩 인디케이터를 표시할 조건이 아니면 null을 반환하여 아무것도 그리지 않음
                            if (index >= displayedWishes.length) {
                              return null;
                            }

                            final item = displayedWishes[index];
                            return AllWishlistItem(
                              key: ValueKey(item.wishId),
                              item: item,
                            );
                          },
                        ),
              ),
            ],
          ),
        ),
        if (wishState.isLoading) overlayView(),
      ],
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

class AllWishlistItem extends ConsumerWidget {
  final WishModel item;

  const AllWishlistItem({super.key, required this.item});

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
            startActionPane: ActionPane(
              motion: const DrawerMotion(),
              extentRatio: 0.5,
              children: <Widget>[
                CustomSlidableAction(
                  onPressed: (context) {
                    ref
                        .read(wishViewModelProvider.notifier)
                        .editBoughtWishItem(context, item.wishId);
                  },
                  backgroundColor: primaryGradientStart,
                  // 👇 2. child 속성을 사용하여 위젯을 직접 구성합니다.
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        item.bought
                            ? Icons.check
                            : Icons.shopping_cart_outlined,
                        size: context.width(0.08),
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                if ((wishState.starWishes.length < 5 && !item.starred) ||
                    (wishState.starWishes.length <= 5 && item.starred))
                  CustomSlidableAction(
                    onPressed: (context) {
                      ref
                          .read(wishViewModelProvider.notifier)
                          .editStarWishItem(context, item.wishId);
                    },
                    backgroundColor: const Color.fromARGB(255, 231, 127, 111),
                    // 👇 2. child 속성을 사용하여 위젯을 직접 구성합니다.
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          item.starred ? Icons.star : Icons.star_outline,
                          size: context.width(0.08),
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
              ],
            ),
            endActionPane: ActionPane(
              motion: const DrawerMotion(),
              extentRatio: 0.5,
              children: <Widget>[
                CustomSlidableAction(
                  onPressed:
                      (context) => context.push('/editWish', extra: item),
                  backgroundColor: Colors.grey.shade600,
                  foregroundColor: Colors.white,
                  // 👇 2. child 속성을 사용하여 위젯을 직접 구성합니다.
                  child: Text(
                    "수정",
                    style: TextStyle(fontSize: context.width(0.04)),
                  ),
                ),

                CustomSlidableAction(
                  onPressed: (context) {
                    showDialog(
                      context: context,
                      builder:
                          (ctx) => AlertDialog(
                            title: const Text('삭제 확인'),
                            content: Text("'${item.name}' 항목을 정말로 삭제하시겠습니까?"),
                            actions: [
                              TextButton(
                                child: const Text('취소'),
                                onPressed: () => Navigator.of(ctx).pop(),
                              ),
                              TextButton(
                                child: const Text(
                                  '삭제',
                                  style: TextStyle(color: Colors.red),
                                ),
                                onPressed: () {
                                  ref
                                      .read(wishViewModelProvider.notifier)
                                      .deleteWishItem(context, item.wishId);
                                  Navigator.of(ctx).pop();
                                },
                              ),
                            ],
                          ),
                    );
                  },
                  backgroundColor: const Color(0xFFFE4A49),
                  foregroundColor: Colors.white,
                  // 👇 2. child 속성을 사용하여 위젯을 직접 구성합니다.
                  child: Text(
                    "삭제",
                    style: TextStyle(fontSize: context.width(0.04)),
                  ),
                ),
              ],
            ),
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
                    SizedBox(width: context.width(0.03)),
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
