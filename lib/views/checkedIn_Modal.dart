import 'package:earned_it/config/design.dart';
import 'package:earned_it/view_models/checkedIn_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class CheckedInModal extends ConsumerStatefulWidget {
  const CheckedInModal({super.key});

  @override
  ConsumerState<CheckedInModal> createState() => _CheckedInModalState();
}

class _CheckedInModalState extends ConsumerState<CheckedInModal> {
  @override
  void initState() {
    super.initState();
    // 모달이 열릴 때 보상 후보 데이터를 불러옵니다.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(checkedInViewModelProvider.notifier).getCandidates(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(checkedInViewModelProvider);
    final notifier = ref.read(checkedInViewModelProvider.notifier);
    final String formattedDate = DateFormat(
      'yyyy. MM. dd',
    ).format(DateTime.now());

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.middlePadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: context.height(0.02)),
            Stack(
              children: <Widget>[
                // 1. 테두리 역할을 하는 Text (뒤에 배치)
                Text(
                  !state.isLoading && state.selectedIndex != null
                      ? "출석 완료!"
                      : "Welcome Back!",
                  style: TextStyle(
                    fontSize: context.width(0.06),
                    fontWeight: FontWeight.bold,
                    // foreground에 Paint를 사용하여 테두리 효과를 줍니다.
                    foreground:
                        Paint()
                          ..style =
                              PaintingStyle
                                  .stroke // 선 스타일
                          ..strokeWidth =
                              2.5 // 테두리 두께
                          ..color = Colors.black, // 테두리 색상
                  ),
                ),
                // 2. 내부 색상을 채우는 Text (위에 배치)
                Text(
                  !state.isLoading && state.selectedIndex != null
                      ? "출석 완료!"
                      : "Welcome Back!",
                  style: TextStyle(
                    fontSize: context.width(0.06),
                    fontWeight: FontWeight.bold,
                    color: primaryGradientStart, // 내부 색상
                  ),
                ),
              ],
            ),
            Text(
              formattedDate,
              style: TextStyle(
                fontSize: context.width(0.03),
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: context.height(0.05)),

            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              // 👇 1. UI 전환 조건을 state.reward != null로 수정
              child:
                  !state.isLoading && state.selectedIndex != null
                      ? _buildRewardView(context)
                      : _buildGiftSelectionView(context, ref),
            ),

            SizedBox(height: context.height(0.03)),
            if (!state.isLoading && state.selectedIndex == null)
              TextButton(
                onPressed:
                    !state.isLoading
                        ? () async {
                          if (state.reward == null) {
                            await notifier.hideForToday();
                          }
                          if (context.mounted) context.pop();
                        }
                        : null,
                child: const Text(
                  textAlign: TextAlign.center,
                  "오늘은 이제 그만보기",
                  style: TextStyle(
                    color: Colors.grey,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.grey,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // --- 선물 선택 UI ---
  Widget _buildGiftSelectionView(BuildContext context, WidgetRef ref) {
    final state = ref.watch(checkedInViewModelProvider);
    final notifier = ref.read(checkedInViewModelProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          textAlign: TextAlign.center,
          "오늘의 방문 보상을 뽑아보세요",
          style: TextStyle(
            fontSize: context.width(0.045),
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: context.height(0.03)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(3, (index) {
            return FloatingActionButton.large(
              backgroundColor: Colors.transparent,
              elevation: 0,
              onPressed:
                  !state.isLoading
                      ? () => notifier.selectGift(context, index)
                      : null,
              child: Lottie.asset(
                'assets/lottie/giftBox.json',
                animate: state.isLoading && state.selectedIndex == index,
                width: context.width(0.3),
                height: context.width(0.3),
              ),
            );
          }),
        ),
      ],
    );
  }

  // --- 보상 결과 UI ---
  Widget _buildRewardView(BuildContext context) {
    final state = ref.watch(checkedInViewModelProvider);
    final currencyFormat = NumberFormat.decimalPattern('ko_KR');

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.middlePadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(context.height(0.01)),
            child: Image.network(
              "${state.candidatesCheckedInList[state.selectedIndex!].image}",
              width: context.height(0.25),
              height: context.height(0.25),
              fit: BoxFit.contain,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    value:
                        loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
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
          SizedBox(height: context.height(0.03)),
          Text(
            textAlign: TextAlign.center,
            "${state.candidatesCheckedInList[state.selectedIndex!].name}",
            style: TextStyle(
              fontSize: context.width(0.05),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: context.height(0.02)),
          Text(
            textAlign: TextAlign.center,
            "2025.06 기준 ${currencyFormat.format(state.candidatesCheckedInList[state.selectedIndex!].price)}원",
            style: TextStyle(fontSize: context.width(0.04), color: Colors.grey),
          ),
          SizedBox(height: context.height(0.03)),
          SizedBox(
            width: double.infinity,
            height: context.height(0.06),
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
        ],
      ),
    );
  }
}
