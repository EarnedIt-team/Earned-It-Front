import 'package:earned_it/views/home/home_view.dart';
import 'package:earned_it/views/auth/login/forgot_password_view.dart';
import 'package:earned_it/views/auth/login/login_view.dart';
import 'package:earned_it/views/navigation_view.dart';
import 'package:earned_it/views/onboarding/onboarding_view.dart';
import 'package:earned_it/views/auth/signup/sign_view.dart';
import 'package:earned_it/views/setting/set_salary_view.dart';
import 'package:earned_it/views/splash_view.dart';
import 'package:flutter/widgets.dart';

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
    // 온보딩 화면 (onboarding)
    GoRoute(
      path: '/onboarding',
      builder:
          (BuildContext context, GoRouterState state) => const OnboardingView(),
    ),
    // 회원가입 (sign)
    GoRoute(
      path: '/sign',
      builder: (BuildContext context, GoRouterState state) => const SignView(),
    ),
    // 로그인 (login)
    GoRoute(
      path: '/login',
      builder: (BuildContext context, GoRouterState state) => const LoginView(),
    ),
    // 비밀번호 찾기 (forgot password)
    GoRoute(
      path: '/forgot_password',
      builder:
          (BuildContext context, GoRouterState state) =>
              const ForgotPasswordView(),
    ),
    // 홈 화면 (home)
    GoRoute(
      path: '/home',
      builder:
          (BuildContext context, GoRouterState state) => const NavigationView(),
    ),
    // 메인화면 (main)
    GoRoute(
      path: '/main',
      builder: (BuildContext context, GoRouterState state) => const HomeView(),
    ),
    // 월 수익 설정 (setSalary)
    GoRoute(
      path: '/setSalary',
      builder:
          (BuildContext context, GoRouterState state) => const SetSalaryView(),
    ),
  ],
);
