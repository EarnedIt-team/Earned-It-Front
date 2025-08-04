import 'dart:io';
import 'dart:math';
import 'package:animated_digit/animated_digit.dart';
import 'package:earned_it/config/design.dart';
import 'package:earned_it/view_models/home_provider.dart';
import 'package:earned_it/view_models/user_provider.dart';
import 'package:earned_it/view_models/wish/wish_provider.dart';
import 'package:earned_it/views/loading_overlay_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class WishView extends ConsumerWidget {
  const WishView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(userProvider);
    final homeState = ref.watch(homeViewModelProvider);
    final wishList = userState.starWishes;
    final currencyFormat = NumberFormat.decimalPattern('ko_KR');

    final totalPrice = wishList.fold<int>(0, (sum, item) => sum + item.price);

    final double displayAmount =
        (totalPrice > 0)
            ? min(homeState.currentEarnedAmount, totalPrice.toDouble())
            : homeState.currentEarnedAmount;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Stack(
        children: <Widget>[
          Scaffold(
            appBar: AppBar(
              title: const Text(
                "위시리스트",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              centerTitle: false,
              actions: <Widget>[
                IconButton(
                  onPressed: () => context.push('/addWish'),
                  icon: const Icon(Icons.add_circle, color: primaryColor),
                ),
              ],
              actionsPadding: EdgeInsets.symmetric(
                horizontal: context.middlePadding / 2,
              ),
            ),
            body: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: context.middlePadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextField(
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
                  const SizedBox(height: 30),
                  Row(
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
                              height: 1.0,
                            ),
                          ),
                          Text(
                            " (${wishList.length}/5)",
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
                          wishList.isEmpty
                              ? const Text("")
                              : displayAmount >= totalPrice
                              ? Text(
                                "모금 완료",
                                style: TextStyle(
                                  fontSize: context.width(0.05),
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                  height: 1.5,
                                ),
                              )
                              : Row(
                                children: [
                                  AnimatedDigitWidget(
                                    value: displayAmount.toInt(),
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
                  wishList.isEmpty
                      ? Padding(
                        padding: EdgeInsets.only(top: context.height(0.2)),
                        child: const Center(
                          child: Text(
                            '나만의 위시아이템을 추가해보세요.',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        ),
                      )
                      : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: wishList.length,
                        itemBuilder: (context, index) {
                          final item = wishList[index];
                          return Card(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.grey
                                    : Colors.white,
                            margin: const EdgeInsets.symmetric(vertical: 8.0),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color:
                                    Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors.white
                                        : Colors.black,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Slidable(
                                key: ValueKey(item.wishId),
                                endActionPane: ActionPane(
                                  motion: const StretchMotion(),
                                  extentRatio: 0.6,
                                  children: <Widget>[
                                    SlidableAction(
                                      onPressed:
                                          (context) =>
                                              print('수정: ${item.name}'),
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
                                child: ListTile(
                                  contentPadding: const EdgeInsets.all(12.0),
                                  leading: SizedBox(
                                    width: 80,
                                    height: 80,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.network(
                                        item.itemImage,
                                        fit: BoxFit.cover,
                                        errorBuilder: (
                                          context,
                                          error,
                                          stackTrace,
                                        ) {
                                          return Container(
                                            color: Colors.grey[200],
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
                                  title: Text(
                                    item.name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  subtitle: Text(
                                    item.vendor,
                                    style: TextStyle(color: Colors.grey[600]),
                                  ),
                                  trailing: Text(
                                    '${currencyFormat.format(item.price)}원',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15,
                                    ),
                                  ),
                                  onTap: () {
                                    // TODO: 아이템 상세 보기 페이지로 이동 등
                                  },
                                ),
                              ),
                            ),
                          );
                        },
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
