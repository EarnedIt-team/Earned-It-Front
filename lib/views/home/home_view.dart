import 'package:earned_it/config/design.dart';
import 'package:earned_it/view_models/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  final NumberFormat _numberFormat = NumberFormat('#,###', 'ko_KR');

  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(userProvider);
    final formattedSalary = _numberFormat.format(userState.monthlySalary);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Earned !t",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.middlePadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text(
                        "금월 누적 금액",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      userState.isearningsPerSecond
                          ? Text(
                            "$formattedSalary원",
                            style: const TextStyle(fontSize: 30),
                          )
                          : const Text(
                            "설정된 금액이 없습니다.",
                            style: TextStyle(fontSize: 18, color: Colors.grey),
                          ),
                    ],
                  ),
                  userState.isearningsPerSecond
                      ? Image.asset(
                        "assets/images/money/money_small.png",
                        width: context.height(0.08),
                        height: context.height(0.08),
                      )
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
