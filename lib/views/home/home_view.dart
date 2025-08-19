import 'package:animated_digit/animated_digit.dart';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:earned_it/config/design.dart';
import 'package:earned_it/view_models/home_provider.dart';
import 'package:earned_it/view_models/user_provider.dart';
import 'package:earned_it/view_models/wish/wish_provider.dart';
import 'package:earned_it/views/home/home_piece_view.dart';
import 'package:earned_it/views/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

final carouselIndexProvider = StateProvider.autoDispose<int>((ref) => 0);

// 데이터 준비 상태를 알려주는 Provider (autoDispose 유지)
final isHomeReadyProvider = Provider.autoDispose<bool>((ref) {
  final userReady = ref.watch(
    wishViewModelProvider.select((s) => s.starWishes.isNotEmpty),
  );
  final homeReady = ref.watch(
    homeViewModelProvider.select((s) => s.currentEarnedAmount > 0),
  );
  return userReady && homeReady;
});

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    super.initState();
    // 👇 2. initState에서 로딩 상태를 제어하도록 수정
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(userProvider.notifier).loadUser();

      final storage = ref.read(secureStorageProvider);
      String? token = await storage.read(key: 'refreshToken');

      if (token != null && token.isNotEmpty) {
        if (ref.read(userProvider.notifier).state.isearningsPerSecond ==
            false) {
          context.go("/initHome");
        }
      } else {
        context.go("/home");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(userProvider);
    final homeState = ref.watch(homeViewModelProvider);
    final homeProvider = ref.read(homeViewModelProvider.notifier);

    // isHomeReadyProvider를 감시하여 정확한 시점에 로직 실행
    ref.listen<bool>(isHomeReadyProvider, (wasReady, isNowReady) {
      // '준비 안 됨' -> '준비 완료' 상태로 바뀔 때 단 한 번만 실행
      if (!wasReady! && isNowReady) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (!mounted) return;

          final currentHomeState = ref.read(homeViewModelProvider);
          final currentUserState = ref.read(wishViewModelProvider);
          final wishList = currentUserState.starWishes;

          // 👇 2. 위치 계산 로직 보강
          int targetIndex = 0;
          final totalWishlistPrice = wishList.fold<double>(
            0.0,
            (sum, item) => sum + item.price,
          );

          // 모든 아이템을 구매할 수 있는 경우, 마지막 인덱스로 설정
          if (currentHomeState.currentEarnedAmount >= totalWishlistPrice) {
            targetIndex = wishList.isNotEmpty ? wishList.length - 1 : 0;
          } else {
            // 그렇지 않다면, 현재 진행 중인 아이템을 찾음
            double cumulativePrice = 0;
            for (int i = 0; i < wishList.length; i++) {
              cumulativePrice += wishList[i].price;
              if (currentHomeState.currentEarnedAmount < cumulativePrice) {
                targetIndex = i;
                break;
              }
            }
          }

          homeProvider.carouselController.jumpToPage(targetIndex);
          ref.read(carouselIndexProvider.notifier).state = targetIndex;
        });
      }
    });

    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        title: Image.asset(
          Theme.of(context).brightness == Brightness.dark
              ? "assets/images/logo_light.png"
              : "assets/images/logo_light_color.png",
          width: context.width(0.3),
        ),
        centerTitle: false,
        actionsPadding: EdgeInsets.symmetric(horizontal: context.middlePadding),
        actions: [
          AnimatedToggleSwitch.dual(
            current: homeState.toggleIndex,
            first: 0,
            second: 1,
            onChanged: (value) => homeProvider.updateToggleIndex(value),
            spacing: 0,
            height: 40,
            styleBuilder:
                (value) => ToggleStyle(
                  borderColor:
                      Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
                  indicatorColor: Colors.white,
                  backgroundColor:
                      value == 0 ? primaryGradientStart : primaryGradientEnd,
                ),
            iconBuilder:
                (value) =>
                    value == 0
                        ? Icon(
                          Icons.local_mall,
                          color: primaryGradientStart,
                          size: context.width(0.06),
                        )
                        : Icon(
                          Icons.extension,
                          color: primaryGradientEnd,
                          size: context.width(0.06),
                        ),
            textBuilder:
                (value) =>
                    value == 0
                        ? const Icon(
                          Icons.extension,
                          color: Color.fromARGB(255, 202, 202, 202),
                          size: 20.0,
                        )
                        : const Icon(
                          Icons.local_mall,
                          color: Color.fromARGB(255, 202, 202, 202),
                          size: 20.0,
                        ),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          _buildTopSection(context, ref),
          Expanded(
            child:
                homeState.toggleIndex == 0
                    ? _buildWishlist(context, ref)
                    : const HomePieceView(),
          ),
          SizedBox(height: context.height(0.02)),
        ],
      ),
    );
  }

  // (이하 다른 메서드들은 변경사항 없음)
  Widget _buildTopSection(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(userProvider);
    final homeState = ref.watch(homeViewModelProvider);
    final decimalFormat = NumberFormat('#,##0.00', 'ko_KR');

    return Padding(
      padding: EdgeInsets.only(
        top: context.height(0.015),
        left: context.middlePadding,
        right: context.middlePadding,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text.rich(
            TextSpan(
              style: TextStyle(
                fontSize: context.height(0.02),
                fontWeight: FontWeight.bold,
              ),
              children: [
                if (userState.isearningsPerSecond) ...<InlineSpan>[
                  TextSpan(
                    text:
                        '+ ${decimalFormat.format(userState.earningsPerSecond)}',
                    style: TextStyle(
                      fontSize: context.height(0.018),
                      fontWeight: FontWeight.w100,
                      color: Colors.grey,
                    ),
                  ),
                  TextSpan(
                    text: '₩ /sec',
                    style: TextStyle(
                      fontSize: context.height(0.015),
                      fontWeight: FontWeight.w100,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ],
            ),
          ),
          Text(
            "금월 누적 금액",
            style: TextStyle(
              fontSize: context.height(0.02),
              fontWeight: FontWeight.bold,
              color:
                  Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
            ),
          ),
          SizedBox(height: context.height(0.005)),
          userState.isearningsPerSecond
              ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: <Widget>[
                  AnimatedDigitWidget(
                    value: homeState.currentEarnedAmount.toInt(),
                    textStyle: TextStyle(
                      fontSize: context.height(0.035),
                      fontWeight: FontWeight.bold,
                      color:
                          Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black,
                    ),
                    enableSeparator: true,
                  ),
                  Text(
                    " 원",
                    style: TextStyle(
                      fontSize: context.height(0.02),
                      color:
                          Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black,
                    ),
                  ),
                ],
              )
              : Text(
                "설정된 금액이 없습니다.",
                style: TextStyle(
                  fontSize: context.height(0.018),
                  color: Colors.grey,
                ),
              ),
        ],
      ),
      // child: Row(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   children: [
      //     userState.isearningsPerSecond
      //         ? _buildAmountImage(context, homeState.currentEarnedAmount)
      //         : ElevatedButton(
      //           onPressed: () => context.push('/setSalary'),
      //           child: const Text("월 수익 설정하기"),
      //         ),
      //   ],
      // ),
    );
  }

  Widget _buildWishlist(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(wishViewModelProvider);
    final homeProvider = ref.read(homeViewModelProvider.notifier);
    final carouselIndex = ref.watch(carouselIndexProvider);
    final wishList = userState.starWishes;
    final currencyFormat = NumberFormat.decimalPattern('ko_KR');

    if (wishList.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Lottie.asset(
              'assets/lottie/empty_wish.json',
              filterQuality: FilterQuality.high,
              width: context.width(0.4),
              height: context.width(0.4),
              fit: BoxFit.contain,
            ),
            SizedBox(height: context.height(0.03)),
            Text(
              "등록된 Star 리스트가 없습니다.",
              style: TextStyle(
                color: Colors.grey,
                fontSize: context.regularFont,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );
    }

    final displayInfo = _calculateDisplayInfo(ref, carouselIndex);
    final item = wishList[carouselIndex];
    final progressColor = _getProgressColor(displayInfo.progress);

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        SizedBox(height: context.height(0.03)),
        if (item.bought)
          SizedBox(
            width: context.width(0.3),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(width: 2, color: primaryGradientEnd),
                borderRadius: BorderRadius.circular(12.0),
              ),
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.check,
                    color: primaryGradientStart,
                    size: context.width(0.04),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    "구매 완료",
                    style: TextStyle(
                      color: primaryGradientStart,
                      fontSize: context.width(0.035),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        Expanded(
          child: CarouselSlider.builder(
            carouselController: homeProvider.carouselController,
            itemCount: wishList.length,
            itemBuilder: (context, index, realIndex) {
              final currentItem = wishList[index];
              return ClipRRect(
                borderRadius: BorderRadius.circular(context.height(0.01)),
                child: Opacity(
                  opacity: index != carouselIndex ? 0.5 : 1.0,
                  child: Image.network(
                    currentItem.itemImage,
                    width: context.height(0.25),
                    height: context.height(0.25),
                    fit: BoxFit.cover,
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
              );
            },
            options: CarouselOptions(
              initialPage: ref.read(carouselIndexProvider),
              aspectRatio: 16 / 9,
              height: MediaQuery.of(context).size.height * 0.333,
              viewportFraction: 0.65,
              enableInfiniteScroll: false,
              enlargeCenterPage: true,
              enlargeFactor: 0.55,
              enlargeStrategy: CenterPageEnlargeStrategy.zoom,
              onPageChanged:
                  (index, reason) =>
                      ref.read(carouselIndexProvider.notifier).state = index,
            ),
          ),
        ),
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: context.width(0.8)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                item.vendor,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: MediaQuery.of(context).size.width * 0.04,
                ),
              ),
              Text(
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                item.name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color:
                      Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
                  fontSize: MediaQuery.of(context).size.width * 0.05,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: context.height(0.03)),
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: context.width(0.8)),
          child: Column(
            children: [
              LinearProgressIndicator(
                minHeight: context.height(0.015),
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                backgroundColor:
                    Theme.of(context).brightness == Brightness.dark
                        ? const Color.fromARGB(97, 75, 75, 75)
                        : const Color.fromARGB(255, 234, 234, 234),
                color: progressColor,
                value: displayInfo.progress,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${currencyFormat.format(item.price)}원',
                    style: const TextStyle(color: Colors.grey),
                  ),
                  Text(
                    '${(displayInfo.progress * 100).toStringAsFixed(2)}%',
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: context.height(0.02)),
        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: context.width(0.6),
            minHeight: context.height(0.06),
          ),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              side: BorderSide(
                color:
                    displayInfo.progress >= 1.0
                        ? progressColor
                        : Colors.transparent,
                width: 2,
              ),
              disabledBackgroundColor:
                  Theme.of(context).brightness == Brightness.dark
                      ? const Color.fromARGB(97, 75, 75, 75)
                      : const Color.fromARGB(255, 234, 234, 234),
              backgroundColor: const Color.fromARGB(255, 242, 254, 242),
              shadowColor: Colors.transparent,
              elevation: 0,
            ),
            onPressed:
                displayInfo.progress >= 1.0
                    ? () => _launchURL(item.url, item.name)
                    : null,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  displayInfo.progress >= 1.0
                      ? Icons.shopping_bag
                      : Icons.timer_outlined,
                  color:
                      displayInfo.progress >= 1.0
                          ? const Color.fromARGB(255, 62, 62, 62)
                          : Colors.grey,
                  size: context.width(0.04),
                ),
                const SizedBox(width: 8),
                Text(
                  item.url.isEmpty && displayInfo.progress >= 1.0
                      ? '${displayInfo.timeText} ( 다나와 )'
                      : displayInfo.timeText,
                  style: TextStyle(
                    color:
                        displayInfo.progress >= 1.0
                            ? Colors.black
                            : Colors.grey,
                    fontSize: context.width(0.037),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: context.height(0.03)),
      ],
    );
  }

  ({double progress, String timeText}) _calculateDisplayInfo(
    WidgetRef ref,
    int itemIndex,
  ) {
    final userState = ref.read(userProvider);
    final wishState = ref.read(wishViewModelProvider);
    final homeState = ref.read(homeViewModelProvider);
    final wishList = wishState.starWishes;

    if (wishList.isEmpty) return (progress: 0.0, timeText: '');

    double moneyAvailableForItem = homeState.currentEarnedAmount;
    for (int i = 0; i < itemIndex; i++) {
      moneyAvailableForItem -= wishList[i].price;
    }

    if (moneyAvailableForItem < 0) moneyAvailableForItem = 0;

    final currentItemPrice = wishList[itemIndex].price;
    final progress = (moneyAvailableForItem / currentItemPrice).clamp(0.0, 1.0);

    String timeText;
    final moneyStillNeeded = currentItemPrice - moneyAvailableForItem;

    if (moneyStillNeeded <= 0) {
      timeText = "구매하기";
    } else {
      if (userState.isearningsPerSecond == false) {
        timeText = '월 수익 설정 시, 활성화 됩니다.';
      } else {
        final totalSeconds =
            (moneyStillNeeded / userState.earningsPerSecond).round();
        final duration = Duration(seconds: totalSeconds);

        final int years = duration.inDays ~/ 365;
        final int months = (duration.inDays % 365) ~/ 30;
        final int days = (duration.inDays % 365) % 30;
        final int hours = duration.inHours % 24;
        final int minutes = duration.inMinutes % 60;
        final int seconds = duration.inSeconds % 60;

        if (years > 0)
          timeText = '$years년 ${months}개월';
        else if (months > 0)
          timeText = '$months개월 ${days}일';
        else if (days > 0)
          timeText = '$days일 ${hours}시간';
        else if (hours > 0)
          timeText = '$hours시간 ${minutes}분';
        else if (minutes > 0)
          timeText = '$minutes분 ${seconds}초';
        else
          timeText = '$seconds초';
      }
    }
    return (progress: progress, timeText: timeText);
  }

  Future<void> _launchURL(String url, String name) async {
    // 1. 최종적으로 사용할 URL을 담을 변수 선언
    String targetUrl;

    if (url.isEmpty) {
      // 2. url이 비어있으면, 검색어를 인코딩하여 구글 검색 URL을 만듭니다.
      final encodedName = Uri.encodeComponent(name);
      targetUrl = "https://search.danawa.com/dsearch.php?k1=$encodedName";
    } else {
      // 3. url이 있으면 그대로 사용합니다.
      targetUrl = url;
    }

    // 4. 최종적으로 만들어진 targetUrl을 파싱하여 실행합니다.
    final uri = Uri.parse(targetUrl);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $targetUrl');
    }
  }

  Color _getProgressColor(double progress) {
    if (progress == 1.0) return Colors.green;
    if (progress >= 0.8) return Colors.purple;
    if (progress >= 0.5) return Colors.blue;
    if (progress >= 0.31) return Colors.orange;
    return Colors.red;
  }

  Widget _buildAmountImage(BuildContext context, double currentAmount) {
    final int amount = currentAmount.toInt();
    String? imagePath;

    if (amount >= 50000)
      imagePath = "assets/images/money/money_largeMiddle.png";
    else if (amount >= 10000)
      imagePath = "assets/images/money/money_largeSmall.png";
    else if (amount >= 5000)
      imagePath = "assets/images/money/money_middle.png";
    else if (amount >= 1000)
      imagePath = "assets/images/money/money_middleSmall.png";
    else if (amount >= 10)
      imagePath = "assets/images/money/money_small.png";
    else
      return const SizedBox.shrink();

    return Image.asset(
      imagePath,
      width: context.height(0.08),
      height: context.height(0.08),
    );
  }
}
