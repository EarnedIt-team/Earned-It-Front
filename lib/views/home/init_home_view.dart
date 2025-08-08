import 'package:earned_it/config/design.dart';
import 'package:earned_it/models/user/user_state.dart';
import 'package:earned_it/view_models/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart'; // go_router import
import 'package:lottie/lottie.dart';

class InitHomeView extends ConsumerWidget {
  // ConsumerStatefulWidget 대신 ConsumerWidget 사용
  const InitHomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 👇 1. ref.listen을 사용하여 userProvider의 상태 변화를 감지합니다.
    ref.listen<UserState>(userProvider, (previous, next) {
      // isearningsPerSecond 상태가 false에서 true로 바뀌는 순간을 감지
      final wasEarning = previous?.isearningsPerSecond ?? false;
      final isNowEarning = next.isearningsPerSecond;

      if (!wasEarning && isNowEarning) {
        // 👇 2. 조건이 충족되면 /home으로 페이지를 이동시킵니다.
        context.go("/home");
      }
    });

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              Theme.of(context).brightness == Brightness.dark
                  ? "assets/images/logo_dark.png"
                  : "assets/images/logo_light.png",
              width: context.width(0.35),
            ),
            SizedBox(height: context.height(0.03)),
            Lottie.asset(
              'assets/lottie/isNot_Salary.json',
              filterQuality: FilterQuality.high,
              width: context.width(0.4),
              height: context.width(0.4),
              fit: BoxFit.contain,
            ),
            SizedBox(height: context.height(0.03)),
            Text(
              "설정된 금액이 없습니다.",
              style: TextStyle(
                color: primaryColor,
                fontSize: context.width(0.055),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: context.height(0.005)),
            Text(
              "서비스 이용을 위해서는, 월 수익을 설정하셔야 합니다.",
              style: TextStyle(
                color: Colors.grey,
                fontSize: context.width(0.03),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: context.height(0.06)),
            ElevatedButton(
              onPressed: () {
                // 월 수익 설정 페이지로 이동
                context.push('/setSalary');
              },
              child: const Text("월 수익 설정하기"),
            ),
            TextButton(
              onPressed: () async {
                await const FlutterSecureStorage().deleteAll();
                if (context.mounted) {
                  context.go('/login');
                }
              },
              child: const Text("로그아웃", style: TextStyle(color: Colors.grey)),
            ),
          ],
        ),
      ),
    );
  }
}
