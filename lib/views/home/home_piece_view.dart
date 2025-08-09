import 'package:earned_it/config/design.dart';
import 'package:earned_it/models/piece/piece_state.dart';
import 'package:earned_it/view_models/piece_provider.dart';
import 'package:earned_it/view_models/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class HomePieceView extends ConsumerStatefulWidget {
  const HomePieceView({super.key});

  @override
  ConsumerState<HomePieceView> createState() => _HomePieceViewState();
}

class _HomePieceViewState extends ConsumerState<HomePieceView> {
  @override
  Widget build(BuildContext context) {
    final pieceState = ref.watch(pieceProvider);
    final currencyFormat = NumberFormat.decimalPattern('ko_KR');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child:
              pieceState.recentlyPiece != null
                  ? Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(
                          context.height(0.01),
                        ),
                        child: Image.network(
                          pieceState.recentlyPiece!.image,
                          width: context.height(0.3),
                          height: context.height(0.3),
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                value:
                                    loadingProgress.expectedTotalBytes != null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                              ),
                            );
                          },
                          errorBuilder:
                              (context, error, stackTrace) => const Icon(
                                Icons.image_not_supported,
                                size: 50,
                                color: Colors.grey,
                              ),
                        ),
                      ),
                      SizedBox(height: context.height(0.05)),
                      Text(
                        pieceState.recentlyPiece!.vendor,
                        style: TextStyle(fontSize: context.width(0.04)),
                      ),
                      Text(
                        pieceState.recentlyPiece!.name,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: context.width(0.05),
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: context.height(0.05)),
                      Text(
                        "25.06 기준 ${currencyFormat.format(pieceState.recentlyPiece!.price)}원",
                        style: TextStyle(
                          fontSize: context.width(0.04),
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  )
                  : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.asset(
                        'assets/lottie/empty_piece.json',
                        filterQuality: FilterQuality.high,
                        width: context.width(0.3),
                        height: context.width(0.3),
                        fit: BoxFit.contain,
                      ),
                      SizedBox(height: context.height(0.05)),
                      Text(
                        textAlign: TextAlign.center,
                        '최근에 획득한 조각이 없습니다. \n',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: context.regularFont,
                          fontWeight: FontWeight.bold,
                          height: 1.0,
                        ),
                      ),
                      Text(
                        textAlign: TextAlign.center,
                        '출석체크를 통해 무료로 획득 가능합니다.',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: context.width(0.035),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: context.height(0.03)),
                      ElevatedButton(
                        onPressed: () {
                          // 출석체크
                        },
                        child: const Text("출석체크하기"),
                      ),
                    ],
                  ),
        ),
      ],
    );
  }
}
