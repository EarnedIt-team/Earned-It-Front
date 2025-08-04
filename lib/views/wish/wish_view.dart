import 'package:earned_it/view_models/home_provider.dart';
import 'package:earned_it/view_models/user_provider.dart';
import 'package:earned_it/view_models/wish/wish_provider.dart';
import 'dart:math';
import 'package:animated_digit/animated_digit.dart';
import 'package:earned_it/config/design.dart';
import 'package:earned_it/models/wish/wish_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class WishView extends ConsumerStatefulWidget {
  const WishView({super.key});

  @override
  ConsumerState<WishView> createState() => _WishViewState();
}

class _WishViewState extends ConsumerState<WishView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 👇 1. homeState는 watch하지 않고, userState만 watch합니다.
    final userState = ref.watch(userProvider);
    final starWishList = userState.starWishes;
    final allWishList = userState.Wishes3;
    final currencyFormat = NumberFormat.decimalPattern('ko_KR');

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Stack(
        children: <Widget>[
          Scaffold(
            appBar: AppBar(
              title: const Row(
                children: <Widget>[
                  Icon(Icons.local_mall),
                  SizedBox(width: 10),
                  Text("위시리스트", style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
              centerTitle: false,
              actions: <Widget>[
                IconButton(
                  onPressed: () => context.push('/addWish'),
                  icon: const Icon(Icons.add_circle),
                ),
              ],
              actionsPadding: EdgeInsets.symmetric(
                horizontal: context.middlePadding / 2,
              ),
            ),
            body: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                      left: context.middlePadding,
                      right: context.middlePadding,
                      bottom:
                          (starWishList.isNotEmpty || allWishList.isNotEmpty)
                              ? context.middlePadding
                              : 0,
                    ),
                    child: InkWell(
                      onTap: () => context.push('/wishSearch'),
                      child: AbsorbPointer(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: '브랜드, 이름, 가격 등',
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
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.transparent
                                    : Colors.white,
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
                        bottom: context.middlePadding,
                      ),
                      // 👇 2. 실시간 데이터가 필요한 헤더 부분만 Consumer로 감쌉니다.
                      child: Consumer(
                        builder: (context, ref, child) {
                          final homeState = ref.watch(homeViewModelProvider);
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                textBaseline: TextBaseline.alphabetic,
                                children: [
                                  Text(
                                    "Star",
                                    style: TextStyle(
                                      fontSize: context.width(0.06),
                                      fontWeight: FontWeight.bold,
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
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                textBaseline: TextBaseline.alphabetic,
                                children: [
                                  if (totalPrice > 0)
                                    Text(
                                      "${currencyFormat.format(totalPrice)} 원 / ",
                                      style: TextStyle(
                                        fontSize: context.width(0.035),
                                        color: Colors.grey,
                                        height: 1.5,
                                      ),
                                    ),
                                  totalDisplayAmount >= totalPrice
                                      ? Text(
                                        "달성 완료",
                                        style: TextStyle(
                                          fontSize: context.width(0.045),
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green,
                                          height: 1.5,
                                        ),
                                      )
                                      : Row(
                                        children: [
                                          AnimatedDigitWidget(
                                            value: totalDisplayAmount.toInt(),
                                            enableSeparator: true,
                                            textStyle: TextStyle(
                                              fontSize: context.width(0.05),
                                              fontWeight: FontWeight.bold,
                                              height: 1.5,
                                            ),
                                          ),
                                          Text(
                                            " 원",
                                            style: TextStyle(
                                              fontSize: context.width(0.05),
                                              fontWeight: FontWeight.bold,
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
                  if (allWishList.isNotEmpty)
                    Padding(
                      padding: EdgeInsets.all(context.middlePadding),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "ALL",
                            style: TextStyle(
                              fontSize: context.width(0.06),
                              fontWeight: FontWeight.bold,
                              height: 1.0,
                            ),
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            onPressed: () {},
                            child: const Text(
                              "자세히보기",
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
                  if (allWishList.isNotEmpty)
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: allWishList.length,
                      itemBuilder: (context, index) {
                        final item = allWishList[index];
                        return _WishlistItem(
                          item: item,
                          itemIndex: index,
                          isStar: false,
                        );
                      },
                    ),

                  // --- 리스트가 모두 비어있을 때 ---
                  if (starWishList.isEmpty && allWishList.isEmpty)
                    Padding(
                      padding: EdgeInsets.only(top: context.height(0.2)),
                      child: const Center(
                        child: Text(
                          '나만의 위시아이템을 추가해보세요.',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      ),
                    ),
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
    required this.item,
    required this.itemIndex,
    required this.isStar,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currencyFormat = NumberFormat.decimalPattern('ko_KR');

    // 각 아이템의 진행률 계산 로직
    double calculateItemDisplayAmount() {
      final homeState = ref.watch(homeViewModelProvider);
      final starWishList = ref.read(userProvider).starWishes;

      if (!isStar || starWishList.isEmpty) return 0.0;

      double moneyAvailableForItem = homeState.currentEarnedAmount;
      for (int i = 0; i < itemIndex; i++) {
        moneyAvailableForItem -= starWishList[i].price;
      }
      if (moneyAvailableForItem < 0) moneyAvailableForItem = 0;
      return min(moneyAvailableForItem, item.price.toDouble());
    }

    final itemDisplayAmount = calculateItemDisplayAmount();

    return Card(
      color:
          Theme.of(context).brightness == Brightness.dark
              ? Colors.transparent
              : Colors.white,
      margin: EdgeInsets.symmetric(vertical: context.height(0.005)),
      elevation: 0,
      child: ClipRRect(
        child: Slidable(
          key: ValueKey(item.wishId),
          startActionPane: ActionPane(
            motion: const StretchMotion(),
            extentRatio: 0.5,
            children: <Widget>[
              SlidableAction(
                onPressed: (context) {},
                backgroundColor: Colors.lightBlue,
                foregroundColor: Colors.white,
                icon: Icons.check,
                label: '구매',
              ),
              SlidableAction(
                onPressed: (context) {},
                backgroundColor: Colors.orangeAccent,
                foregroundColor: Colors.white,
                icon: Icons.star,
                label: isStar ? 'Star 해제' : 'Star 등록',
              ),
            ],
          ),
          endActionPane: ActionPane(
            motion: const StretchMotion(),
            extentRatio: 0.5,
            children: <Widget>[
              SlidableAction(
                onPressed: (context) => context.push('/editWish', extra: item),
                backgroundColor: Colors.grey.shade600,
                foregroundColor: Colors.white,
                icon: Icons.edit,
                label: '수정',
              ),
              SlidableAction(
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
                icon: Icons.delete,
                label: '삭제',
              ),
            ],
          ),
          child: InkWell(
            onTap: () {
              /* 상세 페이지 이동 등 */
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: context.middlePadding),
              constraints: BoxConstraints(minHeight: context.height(0.1)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          item.vendor,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: context.width(0.04),
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item.name,
                          style: TextStyle(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? const Color.fromARGB(255, 180, 180, 180)
                                    : const Color.fromARGB(255, 108, 108, 108),
                            fontSize: context.width(0.038),
                          ),
                        ),
                        if (isStar)
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              Text(
                                '${currencyFormat.format(itemDisplayAmount.toInt())}원',
                                style: TextStyle(
                                  color:
                                      itemDisplayAmount >= item.price
                                          ? Colors.green
                                          : Theme.of(
                                            context,
                                          ).textTheme.bodyLarge?.color,
                                  fontWeight: FontWeight.w600,
                                  fontSize: context.width(0.038),
                                ),
                              ),
                              Text(
                                ' / ${currencyFormat.format(item.price)}원',
                                style: TextStyle(
                                  fontSize: context.width(0.038),
                                ),
                              ),
                            ],
                          )
                        else
                          Text(
                            '${currencyFormat.format(item.price)}원',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: context.width(0.038),
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
