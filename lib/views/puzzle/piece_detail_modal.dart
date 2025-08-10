import 'package:earned_it/config/design.dart';
import 'package:earned_it/models/piece/piece_info_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class PieceDetailModal extends StatelessWidget {
  final PieceInfoModel pieceInfo;
  const PieceDetailModal({super.key, required this.pieceInfo});

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.decimalPattern('ko_KR');
    final collectedDate =
        pieceInfo.collectedAt != null
            ? DateFormat(
              'yyyy.MM.dd',
            ).format(DateTime.parse(pieceInfo.collectedAt!))
            : '미획득';

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
                fit: BoxFit.cover,
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
            const SizedBox(height: 24),
            // 닫기 버튼
            SizedBox(
              width: double.infinity,
              height: context.height(0.06),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
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
          ],
        ),
      ),
    );
  }
}
