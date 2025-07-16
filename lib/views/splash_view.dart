import 'package:earned_it/config/design.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SplashView extends ConsumerStatefulWidget {
  const SplashView({super.key});

  @override
  ConsumerState<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView> {
  @override
  void initState() {
    super.initState();
    _navigateToOnboarding(); // 온보딩 이동
  }

  // 온보딩 이동
  void _navigateToOnboarding() async {
    // 2초 대기
    await Future.delayed(const Duration(seconds: 2));

    // 위젯이 여전히 마운트되어 있는지 확인 (화면이 전환되기 전에 위젯이 dispose될 수 있으므로)
    if (mounted) {
      // GoRouter를 사용하여 온보딩 화면으로 이동
      context.go("/onboarding");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "assets/images/time.png",
              fit: BoxFit.contain,
              width: context.width(0.3),
              height: context.height(0.3),
            ),
            SizedBox(height: context.height(0.005)),
            Text(
              "Earned !t",
              style: TextStyle(
                fontSize: context.middleFont,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
