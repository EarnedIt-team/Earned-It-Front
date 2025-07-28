import 'dart:async';
import 'package:earned_it/config/design.dart';
import 'package:earned_it/view_models/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:animated_digit/animated_digit.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  Timer? _timer;
  double _currentEarnedAmount = 0.0;

  @override
  void initState() {
    super.initState();
    final userState = ref.read(userProvider);
    if (userState.isearningsPerSecond) {
      _startEarningTimer(userState.payday, userState.earningsPerSecond);
    }
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
        setState(() {
          _currentEarnedAmount += earningsPerSecond;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Widget _buildAmountImage(double currentAmount) {
    final int amount = currentAmount.toInt();
    String? imagePath;

    if (amount >= 50000) {
      imagePath = "assets/images/money/money_largeMiddle.png";
    } else if (amount >= 10000) {
      imagePath = "assets/images/money/money_largeSmall.png";
    } else if (amount >= 5000) {
      imagePath = "assets/images/money/money_middle.png";
    } else if (amount >= 1000) {
      imagePath = "assets/images/money/money_middleSmall.png";
    } else if (amount >= 10) {
      imagePath = "assets/images/money/money_small.png";
    } else {
      return const SizedBox.shrink();
    }

    return Image.asset(
      imagePath,
      width: context.height(0.08),
      height: context.height(0.08),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(userProvider);

    ref.listen(userProvider, (previous, next) {
      if (next.isearningsPerSecond && (previous?.isearningsPerSecond != true)) {
        _startEarningTimer(next.payday, next.earningsPerSecond);
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          "assets/images/logo.png",
          width: context.width(0.35),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: context.height(0.01)),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.middlePadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text.rich(
                        TextSpan(
                          style: TextStyle(
                            fontSize: context.height(0.02),
                            fontWeight: FontWeight.bold,
                          ),
                          children: <InlineSpan>[
                            TextSpan(
                              text: '금월 누적 금액',
                              style: TextStyle(fontSize: context.height(0.02)),
                            ),

                            if (userState.isearningsPerSecond) ...<InlineSpan>[
                              TextSpan(
                                text:
                                    '  ${userState.earningsPerSecond.toStringAsFixed(2)}',
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

                      userState.isearningsPerSecond
                          ? Row(
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: <Widget>[
                              AnimatedDigitWidget(
                                value: _currentEarnedAmount.toInt(),
                                textStyle: TextStyle(
                                  fontSize: context.height(0.035),
                                ),
                                enableSeparator: true,
                                separateSymbol: ',',
                              ),
                              Text(
                                " 원",
                                style: TextStyle(
                                  fontSize: context.height(0.02),
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
                  userState.isearningsPerSecond
                      ? _buildAmountImage(_currentEarnedAmount)
                      : ElevatedButton(
                        onPressed: () {
                          context.push('/setSalary');
                        },
                        child: const Text("월 수익 설정"),
                      ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
