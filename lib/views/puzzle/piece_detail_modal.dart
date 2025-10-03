import 'package:earned_it/config/design.dart';
import 'package:earned_it/models/piece/piece_info_model.dart';
import 'package:earned_it/services/piece_service.dart';
import 'package:earned_it/view_models/home_provider.dart';
import 'package:earned_it/view_models/piece_provider.dart';
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

    final bool isMain = pieceInfo.mainPiece ?? false;

    return Container(
      decoration: BoxDecoration(
        color:
            Theme.of(context).brightness == Brightness.dark
                ? lightDarkColor
                : lightColor2,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(context.middlePadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (isMain)
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: primaryGradientStart),
                    borderRadius: const BorderRadius.all(Radius.circular(18.0)),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: context.width(0.03),
                    vertical: context.width(0.01),
                  ),
                  // 👇 4. 계산된 조각 수를 Text 위젯에 반영
                  child: Row(
                    spacing: 5,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        'assets/images/keep_icon.png',
                        scale: context.width(0.004),
                        color: primaryGradientStart,
                      ),
                      Text(
                        "메인으로 고정됨",
                        style: TextStyle(
                          fontSize: context.width(0.03),
                          color: primaryGradientStart,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
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
                              : const Center(
                                child: CircularProgressIndicator(),
                              ),
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
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              // 가격 및 획득일
              Text(
                textAlign: TextAlign.center,
                '${currencyFormat.format(pieceInfo.price ?? 0)}원',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
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
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 12,
                ),
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

              // 하단 버튼 영역
              SizedBox(
                height: context.height(0.06),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    // "메인으로 고정" 버튼
                    if (!isMain)
                      Expanded(
                        child: SizedBox(
                          height: context.height(0.1),
                          child: ElevatedButton(
                            onPressed:
                                isMain
                                    ? null
                                    : () {
                                      ref
                                          .read(pieceProvider.notifier)
                                          .pinPieceToMain(
                                            context,
                                            pieceInfo.pieceId!,
                                          );
                                    },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  isMain
                                      ? Colors.grey
                                      : const Color.fromARGB(
                                        255,
                                        255,
                                        136,
                                        117,
                                      ),
                              disabledBackgroundColor: Colors.grey,
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
                                    color:
                                        isMain
                                            ? Colors.grey[800]
                                            : Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    if (!isMain) const SizedBox(width: 16),
                    // "닫기" 버튼
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
      ),
    );
  }
}
