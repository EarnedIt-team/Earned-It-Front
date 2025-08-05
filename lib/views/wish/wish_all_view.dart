import 'package:earned_it/view_models/user_provider.dart';
import 'package:earned_it/views/wish/wish_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WishAllView extends ConsumerWidget {
  // ConsumerWidget으로 변경
  const WishAllView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(userProvider);
    final allWishes = userState.Wishes3;

    return Scaffold(
      appBar: AppBar(title: const Text('전체 위시리스트'), centerTitle: false),
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

                  // 재사용하는 WishlistItem 위젯을 호출합니다.
                  return WishlistItem(
                    key: ValueKey(item.wishId), // 각 아이템에 고유 Key 부여
                    item: item,
                    itemIndex: index,
                    // '전체' 리스트에서는 Star 관련 진행률 표시가 필요 없으므로 false로 설정합니다.
                    isStar: false,
                  );
                },
              ),
    );
  }
}
