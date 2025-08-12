import 'package:earned_it/view_models/wish/wish_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

// 이 ViewModel은 별도의 상태 클래스 없이 로직만 제공합니다.
final wishDetailViewModelProvider = Provider.autoDispose((ref) {
  return WishDetailViewModel(ref);
});

class WishDetailViewModel {
  final Ref _ref;
  const WishDetailViewModel(this._ref);

  /// 구매 상태를 변경합니다.
  void toggleBoughtStatus(BuildContext context, int wishId) {
    _ref
        .read(wishViewModelProvider.notifier)
        .editBoughtWishItem(context, wishId);
  }

  /// Star 상태를 변경합니다.
  void toggleStarStatus(BuildContext context, int wishId) {
    _ref.read(wishViewModelProvider.notifier).editStarWishItem(context, wishId);
  }

  /// 아이템을 삭제합니다.
  Future<void> deleteItem(BuildContext context, int wishId) async {
    // 삭제 확인 다이얼로그를 먼저 띄웁니다.
    final bool? confirmed = await showDialog<bool>(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: const Text('삭제 확인'),
            content: const Text("이 아이템을 정말로 삭제하시겠습니까?"),
            actions: [
              TextButton(
                child: const Text('취소'),
                onPressed: () => context.pop(false),
              ),
              TextButton(
                child: const Text('삭제', style: TextStyle(color: Colors.red)),
                onPressed: () => context.pop(true),
              ),
            ],
          ),
    );

    // 사용자가 '삭제'를 눌렀을 때만 API 호출
    if (confirmed == true && context.mounted) {
      await _ref
          .read(wishViewModelProvider.notifier)
          .deleteWishItem(context, wishId);
      // 삭제 성공 후, 상세 페이지를 닫고 이전 화면으로 돌아갑니다.
      if (context.mounted) {
        context.pop();
      }
    }
  }

  /// 구매 링크를 엽니다.
  Future<void> launchURL(String url, String name) async {
    String targetUrl;
    if (url.isEmpty) {
      final encodedName = Uri.encodeComponent(name);
      targetUrl = "https://www.google.com/search?q=$encodedName";
    } else {
      targetUrl = url;
    }
    final uri = Uri.parse(targetUrl);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $targetUrl');
    }
  }
}
