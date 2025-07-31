import 'package:animated_digit/animated_digit.dart';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:earned_it/config/design.dart';
import 'package:earned_it/view_models/home_provider.dart';
import 'package:earned_it/view_models/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

final carouselIndexProvider = StateProvider.autoDispose<int>((ref) => 0);

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(userProvider);
    final homeState = ref.watch(homeViewModelProvider);
    final homeProvider = ref.read(homeViewModelProvider.notifier);
    final carouselIndex = ref.watch(carouselIndexProvider);
    final wishList = userState.starWishes;

    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        title: Image.asset(
          Theme.of(context).brightness == Brightness.dark
              ? "assets/images/logo_dark.png"
              : "assets/images/logo_light.png",
          width: context.width(0.35),
        ),
        centerTitle: false,
        actionsPadding: const EdgeInsets.symmetric(horizontal: 30),
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
                  borderColor: Colors.black,
                  indicatorColor: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: context.shadowColor,
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: const Offset(0, 1.5),
                    ),
                  ],
                  backgroundColor: value == 0 ? Colors.green : Colors.blue,
                ),
            iconBuilder:
                (value) =>
                    value == 0
                        ? const Icon(
                          Icons.local_mall,
                          color: Colors.green,
                          size: 25.0,
                        )
                        : const Icon(
                          Icons.extension,
                          color: Colors.blue,
                          size: 25.0,
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
                    : _buildPuzzle(),
          ),
          SizedBox(height: context.height(0.02)),
        ],
      ),
    );
  }

  Widget _buildTopSection(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(userProvider);
    final homeState = ref.watch(homeViewModelProvider);

    return Padding(
      padding: EdgeInsets.only(
        top: context.height(0.015),
        left: context.middlePadding,
        right: context.middlePadding,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(
                TextSpan(
                  style: TextStyle(
                    fontSize: context.height(0.02),
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    const TextSpan(text: '금월 누적 금액'),
                    if (userState.isearningsPerSecond) ...<InlineSpan>[
                      TextSpan(
                        text:
                            '  ( ${userState.earningsPerSecond.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: context.height(0.018),
                          fontWeight: FontWeight.w100,
                          color: Colors.grey,
                        ),
                      ),
                      TextSpan(
                        text: '₩ /sec )',
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
              SizedBox(height: context.height(0.005)),
              userState.isearningsPerSecond
                  ? Row(
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
                        style: TextStyle(fontSize: context.height(0.02)),
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
          userState.isearningsPerSecond
              ? _buildAmountImage(context, homeState.currentEarnedAmount)
              : ElevatedButton(
                onPressed: () => context.push('/setSalary'),
                child: const Text("월 수익 설정하기"),
              ),
        ],
      ),
    );
  }

  Widget _buildWishlist(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(userProvider);
    final homeProvider = ref.read(homeViewModelProvider.notifier);
    final carouselIndex = ref.watch(carouselIndexProvider);
    final wishList = userState.starWishes;
    final currencyFormat = NumberFormat.decimalPattern('ko_KR');

    // 위시리스트가 비어있을 때,
    if (wishList.isEmpty) {
      return Center(
        child: Column(
          spacing: context.height(0.03),
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Lottie.asset(
              'assets/lottie/empty_wish.json',
              filterQuality: FilterQuality.high,
              width: context.width(0.4),
              height: context.width(0.4),
              fit: BoxFit.contain,
            ),
            Text(
              "등록된 TOP5 리스트가 없습니다.",
              style: TextStyle(
                color: Colors.grey,
                fontSize: context.regularFont,
                fontWeight: FontWeight.bold,
              ),
            ),
            ElevatedButton(onPressed: () {}, child: const Text("위시리스트 추가")),
          ],
        ),
      );
    }

    final displayInfo = _calculateDisplayInfo(ref, carouselIndex);
    final item = wishList[carouselIndex];
    final progressColor = _getProgressColor(displayInfo.progress);

    return Column(
      children: <Widget>[
        Expanded(
          child: CarouselSlider.builder(
            carouselController: homeProvider.carouselController,
            itemCount: wishList.length,
            itemBuilder: (context, index, realIndex) {
              final currentItem = wishList[index];
              return Opacity(
                opacity: index != carouselIndex ? 0.5 : 1.0,
                // 이미지는 임시로 고정
                child: Image.asset(
                  'assets/images/iphone.png',
                  height: context.height(0.3),
                  errorBuilder:
                      (context, error, stackTrace) => const Icon(
                        Icons.image_not_supported,
                        size: 50,
                        color: Colors.grey,
                      ),
                ),
              );
            },
            options: CarouselOptions(
              initialPage: carouselIndex,
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
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.8,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                item.vendor,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: MediaQuery.of(context).size.width * 0.04,
                ),
              ),
              Text(
                item.name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.05,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
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
            maxWidth: context.width(0.7),
            minHeight: context.height(0.055),
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
              backgroundColor: Colors.white,
            ),
            onPressed:
                displayInfo.progress >= 1.0 ? () => _launchURL("") : null,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  displayInfo.progress >= 1.0
                      ? Icons.shopping_cart
                      : Icons.timer_outlined,
                  color:
                      displayInfo.progress >= 1.0 ? Colors.black : Colors.grey,
                ),
                const SizedBox(width: 8),
                Text(
                  displayInfo.timeText,
                  style: TextStyle(
                    color:
                        displayInfo.progress >= 1.0
                            ? Colors.black
                            : Colors.grey,
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

  Widget _buildPuzzle() {
    return const Center(child: Text("퍼즐"));
  }

  ({double progress, String timeText}) _calculateDisplayInfo(
    WidgetRef ref,
    int itemIndex,
  ) {
    final userState = ref.read(userProvider);
    final homeState = ref.read(homeViewModelProvider);
    final wishList = userState.starWishes;

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

  Future<void> _launchURL(String url) async {
    if (url.isEmpty) return;
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
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
