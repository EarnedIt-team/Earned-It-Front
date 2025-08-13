import 'package:earned_it/config/design.dart';
import 'package:earned_it/models/piece/piece_info_model.dart';
import 'package:earned_it/view_models/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class PieceDetailModal extends ConsumerWidget {
  final PieceInfoModel pieceInfo;
  const PieceDetailModal({super.key, required this.pieceInfo});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeViewModelProvider);
    final currencyFormat = NumberFormat.decimalPattern('ko_KR');

    int buyablePieces = 0;
    final piecePrice = pieceInfo.price ?? 0;
    if (piecePrice > 0) {
      buyablePieces = (homeState.currentEarnedAmount / piecePrice).floor();
    }

    final collectedDate =
        pieceInfo.collectedAt != null
            ? DateFormat(
              'yyyy.MM.dd',
            ).format(DateTime.parse(pieceInfo.collectedAt!))
            : '미획득';

    // isMainPiece가 null일 경우 false로 처리
    final bool isMain = pieceInfo.isMainPiece ?? false;

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(context.middlePadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            // 이미지
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                pieceInfo.image ?? '',
                width: context.height(0.3),
                height: context.height(0.3),
                fit: BoxFit.contain,
                loadingBuilder:
                    (context, child, progress) =>
                        progress == null
                            ? child
                            : const Center(child: CircularProgressIndicator()),
                errorBuilder:
                    (context, error, stackTrace) => const Icon(
                      Icons.image_not_supported_outlined,
                      size: 50,
                      color: Colors.grey,
                    ),
              ),
            ),
            const SizedBox(height: 16),
            // 이름 및 등급
            Text(
              textAlign: TextAlign.center,
              pieceInfo.vendor ?? '브랜드 정보 없음',
              style: const TextStyle(color: Colors.grey, fontSize: 16),
            ),
            Text(
              pieceInfo.name ?? '이름 없음',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            // 가격 및 획득일
            Text(
              textAlign: TextAlign.center,
              '${currencyFormat.format(pieceInfo.price ?? 0)}원',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 16),
            Text(
              textAlign: TextAlign.center,
              '획득일: $collectedDate',
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            // 설명
            Text(
              pieceInfo.description ?? '설명이 없습니다.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              decoration: BoxDecoration(
                color: primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '현재 금액으로 ${currencyFormat.format(buyablePieces)}개 구매 가능',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  color: primaryGradientStart,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 24),

            // --- 👇 (핵심 수정) 하단 버튼 영역 ---
            SizedBox(
              height: context.height(0.06),
              child: Row(
                children: [
                  // --- "메인으로 고정" 버튼 ---
                  Expanded(
                    child: SizedBox(
                      height: context.height(0.1),
                      child: ElevatedButton(
                        // isMain이 true이면 버튼 비활성화
                        onPressed:
                            isMain
                                ? null
                                : () {
                                  // TODO: 메인으로 고정하는 API 호출 로직
                                },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              isMain ? Colors.grey : primaryGradientStart,
                          disabledBackgroundColor: Colors.grey.shade300,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset(
                              'assets/images/keep_icon.png',
                              scale: context.width(0.003),
                            ),
                            Text(
                              isMain ? "고정됨" : "메인으로 고정",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: isMain ? Colors.grey[600] : Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  // --- "닫기" 버튼 ---
                  Expanded(
                    child: SizedBox(
                      height: context.height(0.1),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryGradientEnd,
                        ),
                        onPressed: () {
                          context.pop();
                        },
                        child: const Text(
                          "닫기",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
