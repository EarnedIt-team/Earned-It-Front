import 'dart:io';
import 'package:earned_it/config/design.dart';
import 'package:earned_it/models/wish/wish_model.dart';
import 'package:earned_it/view_models/home_provider.dart';
import 'package:earned_it/view_models/user_provider.dart';
import 'package:earned_it/view_models/wish/wish_provider.dart';
import 'package:earned_it/views/loading_overlay_view.dart';
import 'package:earned_it/views/wish/wish_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

final wishAllViewLoadingProvider = StateProvider<bool>((ref) => true);

// 1. ConsumerWidget -> ConsumerStatefulWidget으로 변경
class WishAllView extends ConsumerStatefulWidget {
  const WishAllView({super.key});

  @override
  ConsumerState<WishAllView> createState() => _WishAllViewState();
}

class _WishAllViewState extends ConsumerState<WishAllView> {
  // 2. initState 추가: 위젯이 처음 생성될 때 한 번만 실행
  @override
  void initState() {
    super.initState();
    // 👇 2. initState에서 로딩 상태를 제어하도록 수정
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // 로딩 시작
      ref.read(wishAllViewLoadingProvider.notifier).state = true;
      try {
        // 데이터 로드
        await ref.read(userProvider.notifier).loadAllWish();
      } finally {
        // 성공/실패 여부와 관계없이 로딩 해제
        if (mounted) {
          ref.read(wishAllViewLoadingProvider.notifier).state = false;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(userProvider);
    // star가 아닌 아이템들만 필터링하여 '전체' 리스트로 사용
    final allWishes = userState.totalWishes;
    final isLoading = ref.watch(wishAllViewLoadingProvider); // 로딩 상태 감시

    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            scrolledUnderElevation: 0,
            title: const Text(
              '전체 위시리스트',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            centerTitle: false,
          ),
          body:
              allWishes.isEmpty
                  ? const Center(
                    child: Text(
                      '위시리스트가 비어있습니다.',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  )
                  : ListView.builder(
                    itemCount: allWishes.length,
                    itemBuilder: (context, index) {
                      final item = allWishes[index];
                      // 3. 재사용 가능한 아이템 위젯 호출
                      return AllWishlistItem(
                        key: ValueKey(item.wishId), // 각 아이템에 고유 Key 부여
                        item: item,
                        itemIndex: index, // '전체' 리스트이므로 isStar는 false
                      );
                    },
                  ),
        ),
        if (isLoading) overlayView(),
      ],
    );
  }
}

class AllWishlistItem extends ConsumerWidget {
  final WishModel item;
  final int itemIndex;

  const AllWishlistItem({
    super.key,
    required this.item,
    required this.itemIndex,
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
                label: "Star",
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
