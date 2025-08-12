import 'package:earned_it/config/design.dart';
import 'package:earned_it/view_models/auth/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';

final secureStorageProvider = Provider<FlutterSecureStorage>((ref) {
  return const FlutterSecureStorage();
});

class SplashView extends ConsumerStatefulWidget {
  const SplashView({super.key});

  @override
  ConsumerState<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView> {
  @override
  void initState() {
    super.initState();
    // 위젯이 빌드된 후 토큰 확인 및 네비게이션을 스케줄링
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkTokenAndNavigate();
    });
  }

  // 토큰 확인 및 화면 전환 함수
  Future<void> _checkTokenAndNavigate() async {
    // 2초 대기 (스플래시 화면 표시 시간)
    await Future.delayed(const Duration(seconds: 2));

    // 위젯이 여전히 마운트되어 있는지 확인 (화면 전환 전에 위젯이 dispose될 수 있으므로)
    if (!mounted) {
      return; // 마운트되지 않았다면 더 이상 진행하지 않음
    }

    // Riverpod을 통해 FlutterSecureStorage 인스턴스 가져오기
    final storage = ref.read(secureStorageProvider);
    // refreshToken 불러오기
    String? token = await storage.read(key: 'refreshToken');

    if (token != null && token.isNotEmpty) {
      // refreshToken이 존재하면 autoLogin 호출
      // loginViewModelProvider를 읽어와서 autoLogin 메서드를 호출합니다.
      ref.read(loginViewModelProvider.notifier).autoLogin(context, token);
    } else {
      // refreshToken이 없거나 비어있으면 온보딩 화면으로 이동
      context.go("/onboarding");
    }
  }

  @override
  Widget build(BuildContext context) {
    // 1. Scaffold를 Container로 감싸줍니다.
    return Container(
      // 2. Container의 decoration에 정의해둔 primaryGradient를 적용합니다.
      decoration:
          Theme.of(context).brightness != Brightness.dark
              ? primaryGradient
              : null,
      child: Scaffold(
        // 3. Scaffold의 배경은 투명하게 만들어 Container의 그라데이션이 보이도록 합니다.
        backgroundColor:
            Theme.of(context).brightness == Brightness.dark
                ? Colors.black
                : Colors.transparent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: context.height(0.005)),
              Image.asset(
                Theme.of(context).brightness == Brightness.dark
                    ? "assets/images/logo_color.png"
                    : "assets/images/logo_no_color.png",
                width: context.width(0.6),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
