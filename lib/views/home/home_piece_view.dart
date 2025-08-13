import 'package:earned_it/config/design.dart';
import 'package:earned_it/config/toastMessage.dart';
import 'package:earned_it/view_models/home_provider.dart';
import 'package:earned_it/view_models/piece_provider.dart';
import 'package:earned_it/view_models/user_provider.dart';
import 'package:earned_it/views/navigation_view.dart';
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
  void initState() {
    super.initState();
    // 모달이 열릴 때 보상 후보 데이터를 불러옵니다.
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   ref.read(pieceProvider.notifier).loadRecentPiece(context);
    // });
  }

  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(userProvider);
    final pieceState = ref.watch(pieceProvider);
    final homeState = ref.watch(homeViewModelProvider); // 👈 2. homeState watch
    final currencyFormat = NumberFormat.decimalPattern('ko_KR');

    // 👇 3. 구매 가능한 조각 수 계산
    int buyablePieces = 0;
    if (pieceState.recentlyPiece != null &&
        pieceState.recentlyPiece!.price! > 0) {
      // 현재 누적 금액을 조각 가격으로 나누어 구매 가능한 개수를 계산 (소수점 버림)
      buyablePieces =
          (homeState.currentEarnedAmount / pieceState.recentlyPiece!.price!)
              .floor();
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.middlePadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child:
                pieceState.recentlyPiece != null
                    ? Column(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.all(
                              Radius.circular(18.0),
                            ),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: context.width(0.03),
                            vertical: context.width(0.02),
                          ),
                          // 👇 4. 계산된 조각 수를 Text 위젯에 반영
                          child: Text(
                            "x ${currencyFormat.format(buyablePieces)}",
                            style: TextStyle(
                              fontSize: context.width(0.035),
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: context.width(0.6),
                          height: context.width(0.6),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(
                                  context.height(0.01),
                                ),
                                child: Image.network(
                                  pieceState.recentlyPiece!.image!,
                                  width: context.height(0.3),
                                  height: context.height(0.3),
                                  fit: BoxFit.contain,
                                  loadingBuilder: (
                                    context,
                                    child,
                                    loadingProgress,
                                  ) {
                                    if (loadingProgress == null) return child;
                                    return Center(
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        value:
                                            loadingProgress
                                                        .expectedTotalBytes !=
                                                    null
                                                ? loadingProgress
                                                        .cumulativeBytesLoaded /
                                                    loadingProgress
                                                        .expectedTotalBytes!
                                                : null,
                                      ),
                                    );
                                  },
                                  errorBuilder:
                                      (context, error, stackTrace) =>
                                          const Icon(
                                            Icons.image_not_supported,
                                            size: 50,
                                            color: Colors.grey,
                                          ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          pieceState.recentlyPiece!.vendor!,
                          style: TextStyle(fontSize: context.width(0.04)),
                        ),
                        Text(
                          pieceState.recentlyPiece!.name!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: context.width(0.05),
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: context.height(0.02)),
                        Text(
                          "25.06 기준 ${currencyFormat.format(pieceState.recentlyPiece!.price)}원",
                          style: TextStyle(
                            fontSize: context.width(0.04),
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(height: context.height(0.02)),
                        ElevatedButton(
                          onPressed: () {
                            if (!userState.isCheckedIn) {
                              ref.read(isOpenCheckedIn.notifier).state = true;
                            } else {
                              toastMessage(
                                context,
                                '출석 체크는 하루에 한번 가능합니다.',
                                type: ToastmessageType.errorType,
                              );
                            }
                          },
                          child: const Text("출석체크하고 보상받기"),
                        ),
                        SizedBox(height: context.height(0.005)),
                        const Text(
                          "*매 일 1번만 획득 가능",
                          style: TextStyle(color: Colors.grey),
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
                          '최근에 설정한 조각이 없습니다. \n',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: context.regularFont,
                            fontWeight: FontWeight.bold,
                            height: 1.0,
                          ),
                        ),
                        Text(
                          textAlign: TextAlign.center,
                          '"퍼즐 페이지"에서 획득한 조각을 설정해주세요.',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: context.width(0.035),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: context.height(0.03)),
                        ElevatedButton(
                          onPressed: () {
                            ref.read(isOpenCheckedIn.notifier).state = true;
                          },
                          child: const Text("출석체크하기"),
                        ),
                      ],
                    ),
          ),
        ],
      ),
    );
  }
}
