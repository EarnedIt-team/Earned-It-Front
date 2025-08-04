import 'dart:math';
import 'package:animated_digit/animated_digit.dart';
import 'package:earned_it/config/design.dart';
import 'package:earned_it/view_models/home_provider.dart';
import 'package:earned_it/view_models/user_provider.dart';
import 'package:earned_it/view_models/wish/wish_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class WishView extends ConsumerWidget {
  const WishView({super.key});

  // 👇 1. 각 아이템의 진행률을 계산하는 헬퍼 함수
  double _calculateItemDisplayAmount(WidgetRef ref, int itemIndex) {
    final homeState = ref.read(homeViewModelProvider);
    final starWishList = ref.read(userProvider).starWishes;

    if (starWishList.isEmpty) return 0.0;

    // 현재 아이템에 사용할 수 있는 금액 계산
    double moneyAvailableForItem = homeState.currentEarnedAmount;
    for (int i = 0; i < itemIndex; i++) {
      moneyAvailableForItem -= starWishList[i].price;
    }

    // 음수가 되지 않도록 보정
    if (moneyAvailableForItem < 0) moneyAvailableForItem = 0;

    // 현재 아이템 가격을 초과하지 않도록 제한
    final currentItemPrice = starWishList[itemIndex].price.toDouble();
    return min(moneyAvailableForItem, currentItemPrice);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(userProvider);
    final homeState = ref.watch(homeViewModelProvider);
    final starWishList = userState.starWishes;
    final currencyFormat = NumberFormat.decimalPattern('ko_KR');

    final totalPrice = starWishList.fold<int>(
      0,
      (sum, item) => sum + item.price,
    );

    final double totalDisplayAmount =
        (totalPrice > 0)
            ? min(homeState.currentEarnedAmount, totalPrice.toDouble())
            : homeState.currentEarnedAmount;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Stack(
        children: <Widget>[
          Scaffold(
            appBar: AppBar(
              title: const Row(
                children: <Widget>[
                  Icon(Icons.local_mall),
                  SizedBox(width: 10), // spacing -> SizedBox로 수정
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // 위시아이템 검색 필드
                  Padding(
                    padding: EdgeInsets.only(
                      left: context.middlePadding,
                      right: context.middlePadding,
                      bottom:
                          starWishList.isNotEmpty ? context.middlePadding : 0,
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: '위시리스트 검색...',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor:
                            Theme.of(context).brightness == Brightness.dark
                                ? Colors.grey[800]
                                : Colors.grey[200],
                        contentPadding: EdgeInsets.zero,
                      ),
                      onChanged: (value) {
                        // TODO: 검색 로직 구현
                      },
                    ),
                  ),

                  // Star 위시리스트 (상단)
                  starWishList.isEmpty
                      ? SizedBox.shrink()
                      : Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: context.middlePadding,
                        ),
                        child: Row(
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
                                    fontWeight: FontWeight.bold,
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
                                            color:
                                                Theme.of(context).brightness ==
                                                        Brightness.dark
                                                    ? Colors.white
                                                    : Colors.black,
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
                        ),
                      ),
                  // Star 위시리스트 (하단)
                  starWishList.isEmpty
                      ? SizedBox.shrink()
                      : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: starWishList.length,
                        itemBuilder: (context, index) {
                          final item = starWishList[index];
                          // 👇 2. 각 아이템에 표시될 금액 계산
                          final itemDisplayAmount = _calculateItemDisplayAmount(
                            ref,
                            index,
                          );

                          return Card(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.transparent
                                    : Colors.white,
                            margin: EdgeInsets.symmetric(
                              vertical: context.height(0.005),
                            ),
                            elevation: 0,
                            child: ClipRRect(
                              child: Slidable(
                                key: ValueKey(item.wishId),
                                startActionPane: ActionPane(
                                  motion: const StretchMotion(),
                                  extentRatio: 0.5,
                                  children: <Widget>[
                                    SlidableAction(
                                      onPressed: (BuildContext context) {},
                                      backgroundColor: Colors.lightBlue,
                                      foregroundColor: Colors.white,
                                      icon: Icons.check,
                                      label: '구매',
                                    ),
                                    SlidableAction(
                                      onPressed: (BuildContext context) {},
                                      backgroundColor: Colors.orangeAccent,
                                      foregroundColor: Colors.white,
                                      icon: Icons.star,
                                      label: 'Star',
                                    ),
                                  ],
                                ),
                                endActionPane: ActionPane(
                                  motion: const StretchMotion(),
                                  extentRatio: 0.5,
                                  children: <Widget>[
                                    SlidableAction(
                                      onPressed:
                                          (context) => context.push(
                                            '/editWish',
                                            extra: item,
                                          ),
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
                                                content: Text(
                                                  "'${item.name}' 항목을 정말로 삭제하시겠습니까?",
                                                ),
                                                actions: [
                                                  TextButton(
                                                    child: const Text('취소'),
                                                    onPressed:
                                                        () =>
                                                            Navigator.of(
                                                              ctx,
                                                            ).pop(),
                                                  ),
                                                  TextButton(
                                                    child: const Text(
                                                      '삭제',
                                                      style: TextStyle(
                                                        color: Colors.red,
                                                      ),
                                                    ),
                                                    onPressed: () {
                                                      ref
                                                          .read(
                                                            wishViewModelProvider
                                                                .notifier,
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
                                      icon: Icons.delete,
                                      label: '삭제',
                                    ),
                                  ],
                                ),
                                child: InkWell(
                                  onTap: () {
                                    // TODO: 아이템 상세 보기 페이지로 이동 등
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: context.middlePadding,
                                    ),
                                    constraints: BoxConstraints(
                                      minHeight: context.height(0.1),
                                    ),

                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        SizedBox(
                                          width: context.height(0.08),
                                          height: context.height(0.08),
                                          child: Container(
                                            // SizedBox를 Container로 변경
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                    8.0,
                                                  ), // 둥근 모서리
                                              border: Border.all(
                                                strokeAlign:
                                                    BorderSide
                                                        .strokeAlignInside,
                                                width: 1,
                                                color: Colors.grey,
                                              ),
                                            ),
                                            child: ClipRRect(
                                              // ClipRRect는 이제 Container의 자식
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              child: Image.network(
                                                item.itemImage,
                                                fit: BoxFit.cover,
                                                errorBuilder: (
                                                  context,
                                                  error,
                                                  stackTrace,
                                                ) {
                                                  return Container(
                                                    color: Colors.grey.shade200,
                                                    child: const Icon(
                                                      Icons
                                                          .image_not_supported_outlined,
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
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
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
                                                      Theme.of(
                                                                context,
                                                              ).brightness ==
                                                              Brightness.dark
                                                          ? const Color.fromARGB(
                                                            255,
                                                            180,
                                                            180,
                                                            180,
                                                          )
                                                          : const Color.fromARGB(
                                                            255,
                                                            108,
                                                            108,
                                                            108,
                                                          ),
                                                  fontSize: context.width(
                                                    0.038,
                                                  ),
                                                ),
                                              ),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.baseline,
                                                textBaseline:
                                                    TextBaseline.alphabetic,
                                                children: [
                                                  // 👇 3. 계산된 금액을 조건에 따라 표시
                                                  Text(
                                                    '${currencyFormat.format(itemDisplayAmount.toInt())}원',
                                                    style: TextStyle(
                                                      color:
                                                          itemDisplayAmount >=
                                                                  item.price
                                                              ? Colors.green
                                                              : Theme.of(
                                                                    context,
                                                                  ).brightness ==
                                                                  Brightness
                                                                      .dark
                                                              ? Colors.white
                                                              : Colors.black,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: context.width(
                                                        0.038,
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    ' / ${currencyFormat.format(item.price)}원',
                                                    style: TextStyle(
                                                      fontSize: context.width(
                                                        0.038,
                                                      ),
                                                    ),
                                                  ),
                                                ],
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
                        },
                      ),
                  // ALL 위시리스트 (상단)
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.middlePadding,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Text(
                              "ALL",
                              style: TextStyle(
                                fontSize: context.width(0.06),
                                fontWeight: FontWeight.bold,
                                height: 1.0,
                              ),
                            ),
                            Text(
                              " (${starWishList.length}/5)",
                              style: TextStyle(
                                fontSize: context.width(0.035),
                                fontWeight: FontWeight.bold,
                                height: 1.0,
                              ),
                            ),
                          ],
                        ),
                        TextButton(
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
