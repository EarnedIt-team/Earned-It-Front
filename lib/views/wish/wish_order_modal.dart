import 'package:earned_it/config/design.dart';
import 'package:earned_it/view_models/wish/wish_order_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class WishOrderModal extends ConsumerWidget {
  const WishOrderModal({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(wishOrderViewModelProvider);
    final notifier = ref.read(wishOrderViewModelProvider.notifier);
    final currencyFormat = NumberFormat.decimalPattern('ko_KR');

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(context.middlePadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            // --- 헤더 ---
            const Text(
              textAlign: TextAlign.center,
              "Star 위시리스트 순서 변경",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              textAlign: TextAlign.center,
              "아이템을 길게 눌러 순서를 변경하세요.",
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 16),

            // --- 순서 변경 리스트 ---
            // 리스트가 길어질 경우를 대비해 높이 제한 및 스크롤 적용
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.5,
              ),
              child: ReorderableListView.builder(
                shrinkWrap: true,
                itemCount: state.currentList.length,
                itemBuilder: (context, index) {
                  final item = state.currentList[index];
                  return Card(
                    key: ValueKey(item.wishId),
                    child: ListTile(
                      leading: const Icon(Icons.drag_handle),
                      title: Text(
                        item.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: Text('${currencyFormat.format(item.price)}원'),
                    ),
                  );
                },
                onReorder: notifier.reorderList,
              ),
            ),
            const SizedBox(height: 24),

            // --- 하단 버튼 ---
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: state.canSubmit ? notifier.resetOrder : null,
                    child: const Text("초기화"),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                    ),
                    onPressed:
                        state.canSubmit
                            ? () => notifier.submitOrder(context)
                            : null,
                    child: const Text(
                      "완료",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
