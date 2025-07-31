import 'dart:async';
import 'package:animated_digit/animated_digit.dart';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:earned_it/config/design.dart';
import 'package:earned_it/models/user/user_state.dart';
import 'package:earned_it/services/auth/user_service.dart';
import 'package:earned_it/view_models/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

// ✨ 1. carouselIndex를 위한 StateProvider를 생성합니다.
final carouselIndexProvider = StateProvider<int>((ref) => 0);

class WishlistItem {
  final String name;
  final String company;
  final int price;
  final String link;
  final String image;

  WishlistItem({
    required this.name,
    required this.company,
    required this.price,
    required this.link,
    required this.image,
  });
}

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  final CarouselSliderController carouselSliderController =
      CarouselSliderController();
  final NumberFormat _currencyFormat = NumberFormat.decimalPattern('ko_KR');

  List<WishlistItem> _wishlistItems = <WishlistItem>[];
  Timer? _timer;
  double _currentEarnedAmount = 0.0;
  int _toggleIndex = 0;

  @override
  void initState() {
    super.initState();

    ref.read(userProvider.notifier).loadUser();

    _loadInitialWishlist();
    final userState = ref.read(userProvider);
    if (userState.isearningsPerSecond) {
      _startEarningTimer(userState.payday, userState.earningsPerSecond);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _loadInitialWishlist() {
    _wishlistItems = [
      WishlistItem(
        name: '2020년형 MacBook Pro 13.3인치 256GB',
        company: 'APPLE',
        price: 1678530,
        link: 'https://ko.aliexpress.com/item/1005005626333589.html',
        image: 'macbook',
      ),
      WishlistItem(
        name: '아이폰 15 Pro 256GB',
        company: 'APPLE',
        price: 1298000,
        link: 'https://www.coupang.com/vp/products/7630888734',
        image: 'iphone',
      ),
      WishlistItem(
        name: '닌텐도 스위치 OLED',
        company: 'NINTENDO',
        price: 377470,
        link: 'https://prod.danawa.com/info/?pcode=14678627',
        image: 'switch',
      ),
    ];
  }

  ({double progress, String timeText}) _calculateDisplayInfo(int itemIndex) {
    if (_wishlistItems.isEmpty) return (progress: 0.0, timeText: '');

    double moneyAvailableForItem = _currentEarnedAmount;
    for (int i = 0; i < itemIndex; i++) {
      moneyAvailableForItem -= _wishlistItems[i].price;
    }

    if (moneyAvailableForItem < 0) moneyAvailableForItem = 0;

    final currentItemPrice = _wishlistItems[itemIndex].price;
    final progress = (moneyAvailableForItem / currentItemPrice).clamp(0.0, 1.0);

    String timeText;
    final moneyStillNeeded = currentItemPrice - moneyAvailableForItem;

    if (moneyStillNeeded <= 0) {
      timeText = "구매하기";
    } else {
      final userState = ref.read(userProvider);
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

  void _jumpToInProgressItem() {
    if (!mounted || _wishlistItems.isEmpty) return;

    int targetIndex = _wishlistItems.length - 1;
    for (int i = 0; i < _wishlistItems.length; i++) {
      if (_calculateDisplayInfo(i).progress < 1.0) {
        targetIndex = i;
        break;
      }
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        carouselSliderController.jumpToPage(targetIndex);
      }
    });
  }

  void _startEarningTimer(int payday, double earningsPerSecond) {
    _timer?.cancel();
    final now = DateTime.now();
    DateTime lastPayday;

    if (now.day >= payday) {
      lastPayday = DateTime(now.year, now.month, payday);
    } else {
      lastPayday = DateTime(now.year, now.month - 1, payday);
    }

    final initialElapsedSeconds = now.difference(lastPayday).inSeconds;
    _currentEarnedAmount = initialElapsedSeconds * earningsPerSecond;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() => _currentEarnedAmount += earningsPerSecond);
      }
    });

    _jumpToInProgressItem();
  }

  Future<void> _launchURL(String url) async {
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

  Widget _buildAmountImage(double currentAmount) {
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

  Widget _buildTopSection(UserState userState) {
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
                        value: _currentEarnedAmount.toInt(),
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
              ? _buildAmountImage(_currentEarnedAmount)
              : ElevatedButton(
                onPressed: () => context.push('/setSalary'),
                child: const Text("월 수익 설정하기"),
              ),
        ],
      ),
    );
  }

  Widget _buildWishlist() {
    if (_wishlistItems.isEmpty) {
      return const Center(child: Text("위시리스트를 추가해주세요."));
    }

    // ✨ 3. build 메소드에서 carouselIndexProvider를 watch합니다.
    final carouselIndex = ref.watch(carouselIndexProvider);

    final displayInfo = _calculateDisplayInfo(carouselIndex);
    final item = _wishlistItems[carouselIndex];
    final progressColor = _getProgressColor(displayInfo.progress);

    return Column(
      children: <Widget>[
        Expanded(
          child: CarouselSlider.builder(
            carouselController: carouselSliderController,
            itemCount: _wishlistItems.length,
            itemBuilder: (context, index, realIndex) {
              final currentItem = _wishlistItems[index];
              final progress = _calculateDisplayInfo(index).progress;
              // ✨ _carouselIndex 대신 provider에서 가져온 carouselIndex를 사용
              return Opacity(
                opacity: index != carouselIndex ? 0.5 : 1.0,
                child: Image.asset(
                  'assets/images/${currentItem.image}.png',
                  height: context.height(0.3),
                ),
              );
            },
            options: CarouselOptions(
              // ✨ 4. 페이지에 다시 돌아왔을 때 저장된 인덱스에서 시작하도록 설정
              initialPage: carouselIndex,
              aspectRatio: 16 / 9,
              height: MediaQuery.of(context).size.height * 0.333,
              viewportFraction: 0.65,
              enableInfiniteScroll: false,
              enlargeCenterPage: true,
              enlargeFactor: 0.55,
              enlargeStrategy: CenterPageEnlargeStrategy.zoom,
              // ✨ 5. 페이지가 변경될 때 setState 대신 provider의 상태를 변경
              onPageChanged:
                  (index, reason) =>
                      ref.read(carouselIndexProvider.notifier).state = index,
            ),
          ),
        ),
        // ... 아래 UI 로직은 carouselIndex를 사용하므로 자동으로 업데이트됩니다 ...
        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.8,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                item.company,
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
                    '${_currencyFormat.format(item.price)}원',
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
                displayInfo.progress >= 1.0
                    ? () => _launchURL(item.link)
                    : null,
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

  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(userProvider);

    // ✨ carouselIndexProvider를 여기서 watch할 필요는 없습니다.
    // ✨ _buildWishlist 내부에서 직접 watch하여 사용합니다.

    ref.listen(userProvider, (previous, next) {
      if (next.isearningsPerSecond && (previous?.isearningsPerSecond != true)) {
        _startEarningTimer(next.payday, next.earningsPerSecond);
      } else if (!next.isearningsPerSecond &&
          previous?.isearningsPerSecond == true) {
        _timer?.cancel();
        setState(() => _currentEarnedAmount = 0.0);
      }
    });

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
            current: _toggleIndex,
            first: 0,
            second: 1,
            onChanged: (value) => setState(() => _toggleIndex = value),
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
          _buildTopSection(userState),
          Expanded(
            child: _toggleIndex == 0 ? _buildWishlist() : _buildPuzzle(),
          ),
          SizedBox(height: context.height(0.02)),
        ],
      ),
    );
  }
}
