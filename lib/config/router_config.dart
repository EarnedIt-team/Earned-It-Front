import 'package:earned_it/views/splash_view.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:go_router/go_router.dart';

final GoRouter routes = GoRouter(
  initialLocation: '/',
  debugLogDiagnostics: true, // 라우팅 디버깅 로그 활성화
  routes: <RouteBase>[
    // 초기 화면 (splash screen)
    GoRoute(
      path: '/',
      builder:
          (BuildContext context, GoRouterState state) => const SplashView(),
    ),
  ],
);
