import 'package:collection/collection.dart';
import 'package:earned_it/config/design.dart';
import 'package:earned_it/models/wish/wish_model.dart';
import 'package:earned_it/view_models/wish/wish_detail_provider.dart';
import 'package:earned_it/view_models/wish/wish_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

// (핵심 수정) wishId 필드명을 wishId -> id로 수정
final wishItemProvider = Provider.autoDispose.family<WishModel?, int>((
  ref,
  wishId,
) {
  final wishState = ref.watch(wishViewModelProvider);
  final foundItem =
      wishState.starWishes.firstWhereOrNull((item) => item.wishId == wishId) ??
      wishState.Wishes3.firstWhereOrNull((item) => item.wishId == wishId) ??
      wishState.totalWishes.firstWhereOrNull((item) => item.wishId == wishId) ??
      wishState.searchResults.firstWhereOrNull((item) => item.wishId == wishId);
  return foundItem;
});

class WishDetailView extends ConsumerWidget {
  final WishModel initialWishItem;
  const WishDetailView({super.key, required this.initialWishItem});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final item = ref.watch(wishItemProvider(initialWishItem.wishId));
    final notifier = ref.read(wishDetailViewModelProvider);

    if (item == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final String formattedDate =
        item.createdAt.isNotEmpty
            ? DateFormat('yyyy.MM.dd').format(DateTime.parse(item.createdAt))
            : '날짜 정보 없음';

    return Scaffold(
      appBar: AppBar(
        title: Text(
          item.vendor,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: Icon(
              Icons.edit,
              color:
                  Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
            ),
            // 수정하기 버튼
            onPressed: () {
              context.push('/editWish', extra: item);
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline, color: Colors.red),
            onPressed: () => notifier.deleteItem(context, item.wishId),
          ),
        ],
        actionsPadding: EdgeInsets.symmetric(
          horizontal: context.middlePadding / 2,
        ),
      ),
      // 👇 1. body를 SingleChildScrollView로 감싸 스크롤 가능하게 만듭니다.
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(context.middlePadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // --- 이미지 ---
              SizedBox(
                height: context.height(0.4), // 이미지 높이를 고정
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    item.itemImage,
                    fit: BoxFit.contain,
                    errorBuilder:
                        (context, error, stackTrace) => const Center(
                          child: Icon(
                            Icons.image_not_supported_outlined,
                            size: 50,
                          ),
                        ),
                  ),
                ),
              ),
              SizedBox(height: context.height(0.02)),

              // --- 이름 ---
              Text(
                item.name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: context.height(0.01)),

              Text(
                '등록일: $formattedDate',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
              SizedBox(height: context.height(0.04)),

              // --- ON/OFF 버튼 ---
              Row(
                children: [
                  Expanded(
                    child: _buildActionButton(
                      context: context,
                      label: item.bought ? "구매완료" : "미구매",
                      iconData:
                          item.bought
                              ? Icons.check_circle
                              : Icons.shopping_cart_outlined,
                      isActive: item.bought,
                      onTap:
                          () =>
                              notifier.toggleBoughtStatus(context, item.wishId),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildActionButton(
                      context: context,
                      label: item.starred ? "Star" : "미등록",
                      iconData:
                          item.starred
                              ? Icons.star
                              : Icons.star_border_outlined,
                      isActive: item.starred,
                      onTap:
                          () => notifier.toggleStarStatus(context, item.wishId),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      // 👇 2. bottomNavigationBar로 버튼을 이동시킵니다.
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(context.middlePadding),
          child: SizedBox(
            height: context.height(0.06),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryGradientEnd,
              ),
              icon: Icon(
                Icons.shopping_bag,
                size: context.width(0.06),
                color: Colors.white,
              ),
              label: Text(
                "구매하러 가기",
                style: TextStyle(
                  fontSize: context.width(0.04),
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () => notifier.launchURL(item.url, item.name),
            ),
          ),
        ),
      ),
    );
  }

  // 재사용 가능한 액션 버튼 위젯
  Widget _buildActionButton({
    required BuildContext context,
    required String label,
    required IconData iconData,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    final activeColor = isActive ? primaryGradientStart : Colors.grey.shade600;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: activeColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: activeColor.withOpacity(0.3)),
        ),
        child: Column(
          children: [
            Icon(iconData, color: activeColor, size: 32),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(color: activeColor, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
