import 'package:earned_it/view_models/home_provider.dart';
import 'package:earned_it/view_models/user_provider.dart';
import 'package:earned_it/view_models/wish/wish_order_provider.dart';
import 'package:earned_it/view_models/wish/wish_provider.dart';
import 'dart:math';
import 'package:animated_digit/animated_digit.dart';
import 'package:earned_it/config/design.dart';
import 'package:earned_it/models/wish/wish_model.dart';
import 'package:earned_it/views/navigation_view.dart';
import 'package:earned_it/views/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class WishView extends ConsumerStatefulWidget {
  const WishView({super.key});

  @override
  ConsumerState<WishView> createState() => _WishViewState();
}

class _WishViewState extends ConsumerState<WishView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // 👇 2. initState에서 로딩 상태를 제어하도록 수정
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(wishViewModelProvider.notifier).loadStarWish();
      await ref.read(wishViewModelProvider.notifier).loadHighLightWish();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(userProvider);
    final wishState = ref.watch(wishViewModelProvider);
    final starWishList = wishState.starWishes;
    final HighLightWishList = wishState.Wishes3;
    final currencyFormat = NumberFormat.decimalPattern('ko_KR');

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Stack(
        children: <Widget>[
          Scaffold(
            appBar: AppBar(
              scrolledUnderElevation: 0,
              title: const Row(
                children: <Widget>[
                  Icon(Icons.local_mall),
                  SizedBox(width: 10),
                  Text("위시리스트", style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
              centerTitle: false,
              actions:
                  starWishList.isNotEmpty || HighLightWishList.isNotEmpty
                      ? <Widget>[
                        IconButton(
                          onPressed: () {
                            ref
                                .read(wishOrderViewModelProvider.notifier)
                                .initialize(wishState.starWishes);
                            // 4. 모달 띄우기
                            ref.read(isOpenSwapList.notifier).state = true;
                          },
                          icon: const Icon(Icons.reorder),
                        ),
                        IconButton(
                          onPressed: () => context.push('/addWish'),
                          icon: const Icon(Icons.add),
                        ),
                      ]
                      : null,
              actionsPadding: EdgeInsets.symmetric(
                horizontal: context.middlePadding / 2,
              ),
            ),
            body:
                // --- 리스트가 모두 비어있을 때 ---
                starWishList.isEmpty && HighLightWishList.isEmpty
                    ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Lottie.asset(
                            'assets/lottie/check_wish.json',
                            filterQuality: FilterQuality.high,
                            width: context.width(0.4),
                            height: context.width(0.4),
                            fit: BoxFit.contain,
                          ),
                          SizedBox(height: context.height(0.03)),
                          Text(
                            "나만의 위시리스트를 등록하세요.",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: context.regularFont,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: context.height(0.02)),
                          if (userState.isLogin == true)
                            ElevatedButton(
                              onPressed: () {
                                context.push('/addWish');
                              },
                              child: const Text("위시리스트 추가"),
                            )
                          else
                            Text(
                              "- 로그인이 필요한 서비스 입니다 -",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: context.width(0.035),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                        ],
                      ),
                    )
                    : SingleChildScrollView(
                      controller: _scrollController,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                              left: context.middlePadding,
                              right: context.middlePadding,
                              bottom:
                                  (starWishList.isNotEmpty ||
                                          HighLightWishList.isNotEmpty)
                                      ? context.middlePadding
                                      : 0,
                            ),
                            child: InkWell(
                              onTap: () => context.push('/wishSearch'),
                              child: AbsorbPointer(
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: '브랜드, 이름 등',
                                    prefixIcon: const Icon(Icons.search),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                        context.width(0.1),
                                      ),
                                      borderSide: const BorderSide(
                                        width: 1,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    filled: true,
                                    fillColor:
                                        Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? Colors.transparent
                                            : lightColor,
                                    contentPadding: EdgeInsets.zero,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          // --- Star 위시리스트 섹션 ---
                          if (starWishList.isNotEmpty)
                            Padding(
                              padding: EdgeInsets.only(
                                left: context.middlePadding,
                                right: context.middlePadding,
                                bottom: context.middlePadding / 2,
                              ),
                              // 👇 2. 실시간 데이터가 필요한 헤더 부분만 Consumer로 감쌉니다.
                              child: Consumer(
                                builder: (context, ref, child) {
                                  final homeState = ref.watch(
                                    homeViewModelProvider,
                                  );
                                  final totalPrice = starWishList.fold<int>(
                                    0,
                                    (sum, item) => sum + item.price,
                                  );
                                  final double totalDisplayAmount =
                                      (totalPrice > 0)
                                          ? min(
                                            homeState.currentEarnedAmount,
                                            totalPrice.toDouble(),
                                          )
                                          : homeState.currentEarnedAmount;

                                  return Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.baseline,
                                        textBaseline: TextBaseline.alphabetic,
                                        children: [
                                          Text(
                                            "Star",
                                            style: TextStyle(
                                              fontSize: context.width(0.07),
                                              fontWeight: FontWeight.w500,
                                              color: primaryColor,
                                              height: 1.0,
                                            ),
                                          ),
                                          Text(
                                            " (${starWishList.length}/5)",
                                            style: TextStyle(
                                              fontSize: context.width(0.035),
                                              fontWeight: FontWeight.w600,
                                              height: 1.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.baseline,
                                        textBaseline: TextBaseline.alphabetic,
                                        children: [
                                          if (totalPrice > 0)
                                            Text(
                                              "${currencyFormat.format(totalPrice)} 원 / ",
                                              style: TextStyle(
                                                fontSize: context.width(0.03),
                                                color: Colors.grey,
                                                height: 1.5,
                                              ),
                                            ),
                                          totalDisplayAmount >= totalPrice
                                              ? Text(
                                                "달성 완료",
                                                style: TextStyle(
                                                  fontSize: context.width(
                                                    0.045,
                                                  ),
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.green,
                                                  height: 1.5,
                                                ),
                                              )
                                              : Row(
                                                children: [
                                                  AnimatedDigitWidget(
                                                    value:
                                                        totalDisplayAmount
                                                            .toInt(),
                                                    enableSeparator: true,
                                                    textStyle: TextStyle(
                                                      color:
                                                          Theme.of(
                                                                    context,
                                                                  ).brightness ==
                                                                  Brightness
                                                                      .dark
                                                              ? Colors.white
                                                              : Colors.black,
                                                      fontSize: context.width(
                                                        0.05,
                                                      ),

                                                      height: 1.5,
                                                    ),
                                                  ),
                                                  Text(
                                                    " 원",
                                                    style: TextStyle(
                                                      fontSize: context.width(
                                                        0.05,
                                                      ),

                                                      height: 1.5,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                        ],
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),

                          // --- Star 위시리스트 목록 ---
                          if (starWishList.isNotEmpty)
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: starWishList.length,
                              itemBuilder: (context, index) {
                                final item = starWishList[index];
                                // 각 아이템 위젯을 분리하여 재빌드를 최소화
                                return _WishlistItem(
                                  item: item,
                                  itemIndex: index,
                                  isStar: true,
                                );
                              },
                            ),

                          // --- All 위시리스트 섹션 ---
                          if (HighLightWishList.isNotEmpty)
                            Padding(
                              padding: EdgeInsets.only(
                                top: context.middlePadding / 2,
                                left: context.middlePadding,
                                right: context.middlePadding,
                                bottom: context.middlePadding / 2,
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.baseline,
                                    textBaseline: TextBaseline.alphabetic,
                                    children: [
                                      Text(
                                        "ALL",
                                        style: TextStyle(
                                          fontSize: context.width(0.07),
                                          fontWeight: FontWeight.w500,
                                          height: 1.0,
                                        ),
                                      ),
                                      Text(
                                        " (${wishState.currentWishCount}/100)",
                                        style: TextStyle(
                                          fontSize: context.width(0.035),
                                          fontWeight: FontWeight.w600,
                                          height: 1.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                  TextButton(
                                    style: TextButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                      minimumSize: Size.zero,
                                      tapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                    ),
                                    onPressed: () {
                                      context.push('/wishALL');
                                    },
                                    child: const Text(
                                      "더보기",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                          // --- All 위시리스트 목록 ---
                          if (HighLightWishList.isNotEmpty)
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: HighLightWishList.length,
                              itemBuilder: (context, index) {
                                final item = HighLightWishList[index];
                                return _WishlistItem(
                                  item: item,
                                  itemIndex: index,
                                  isStar: false,
                                );
                              },
                            ),
                          SizedBox(height: context.height(0.05)),
                        ],
                      ),
                    ),
          ),
        ],
      ),
    );
  }
}

// 👇 3. 각 리스트 아이템을 별도의 ConsumerWidget으로 분리
class _WishlistItem extends ConsumerWidget {
  final WishModel item;
  final int itemIndex;
  final bool isStar;

  const _WishlistItem({
    super.key,
    required this.item,
    required this.itemIndex,
    required this.isStar,
  });

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

    // 각 아이템의 진행률 계산 로직
    double calculateItemDisplayAmount() {
      final homeState = ref.watch(homeViewModelProvider);
      final starWishList = ref.read(wishViewModelProvider).starWishes;

      if (!isStar || starWishList.isEmpty) return 0.0;

      double moneyAvailableForItem = homeState.currentEarnedAmount;
      for (int i = 0; i < itemIndex; i++) {
        moneyAvailableForItem -= starWishList[i].price;
      }
      if (moneyAvailableForItem < 0) moneyAvailableForItem = 0;
      return min(moneyAvailableForItem, item.price.toDouble());
    }

    final itemDisplayAmount = calculateItemDisplayAmount();

    // 1. 진행률 계산 (0.0 ~ 1.0)
    // item.price가 0인 경우 0으로 나누는 오류를 방지합니다.
    final double progress =
        item.price > 0 ? (itemDisplayAmount / item.price) : 0.0;

    // 2. 진행률에 따른 색상 결정
    final progressColor = _getProgressColor(progress);

    return Card(
      color:
          Theme.of(context).brightness == Brightness.dark
              ? Colors.transparent
              : lightColor,
      margin: EdgeInsets.symmetric(vertical: context.height(0.005)),
      elevation: 0,
      child: ClipRRect(
        child: Slidable(
          key: ValueKey(item.wishId),
          startActionPane:
              isStar
                  ? ActionPane(
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
                        child: Icon(
                          item.bought
                              ? Icons.check
                              : Icons.shopping_cart_outlined,
                          size: context.width(0.08),
                          color: Colors.white,
                        ),
                      ),
                      CustomSlidableAction(
                        onPressed: (context) {
                          ref
                              .read(wishViewModelProvider.notifier)
                              .editStarWishItem(context, item.wishId);
                        },
                        backgroundColor: const Color.fromARGB(
                          255,
                          231,
                          127,
                          111,
                        ),
                        // 👇 2. child 속성을 사용하여 위젯을 직접 구성합니다.
                        child: Icon(
                          item.starred ? Icons.star : Icons.star_outline,
                          size: context.width(0.08),
                          color: Colors.white,
                        ),
                      ),
                    ],
                  )
                  : null,
          endActionPane:
              isStar
                  ? ActionPane(
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
                                  content: Text(
                                    "'${item.name}' 항목을 정말로 삭제하시겠습니까?",
                                  ),
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
                                            .read(
                                              wishViewModelProvider.notifier,
                                            )
                                            .deleteWishItem(
                                              context,
                                              item.wishId,
                                            );
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
                  )
                  : null,
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
                  Container(
                    color: Colors.transparent,
                    height: context.height(0.08),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
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
                          if (isStar)
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                Text(
                                  '${currencyFormat.format(itemDisplayAmount.toInt())} 원',
                                  style: TextStyle(
                                    color: progressColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: context.width(0.04),
                                    height: 1.5,
                                  ),
                                ),
                                Text(
                                  ' / ${currencyFormat.format(item.price)} 원',
                                  style: TextStyle(
                                    fontSize: context.width(0.03),
                                    color: Colors.grey,
                                    height: 1.5,
                                  ),
                                ),
                              ],
                            )
                          else
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
                  if (isStar)
                    SizedBox(
                      width: context.width(0.1),
                      height: context.width(0.1),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          // 원형 진행률 표시기
                          CircularProgressIndicator(
                            value: progress, // 진행률 (0.0 ~ 1.0)
                            strokeWidth: context.width(0.007), // 선의 두께
                            backgroundColor: Colors.grey[300], // 배경색
                            valueColor: AlwaysStoppedAnimation<Color>(
                              progressColor,
                            ), // 진행 색상
                          ),
                          // 중앙에 진행률 텍스트 표시
                          Center(
                            child: Text(
                              '${(progress * 100).toInt()}',
                              style: TextStyle(
                                fontSize: context.width(0.035),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
