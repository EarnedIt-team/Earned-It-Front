import 'package:earned_it/models/wish/wish_model.dart';
import 'package:earned_it/views/home/home_view.dart';
import 'package:earned_it/views/auth/login/forgot_password_view.dart';
import 'package:earned_it/views/auth/login/login_view.dart';
import 'package:earned_it/views/navigation_view.dart';
import 'package:earned_it/views/onboarding/onboarding_view.dart';
import 'package:earned_it/views/puzzle/puzzle_view.dart';
import 'package:earned_it/views/auth/signup/sign_view.dart';
import 'package:earned_it/views/setting/set_salary_view.dart';
import 'package:earned_it/views/setting/setting_view.dart';
import 'package:earned_it/views/splash_view.dart';
import 'package:earned_it/views/wish/wish_add_view.dart';
import 'package:earned_it/views/wish/wish_all_view.dart';
import 'package:earned_it/views/wish/wish_edit_view.dart';
import 'package:earned_it/views/wish/wish_search_view.dart';
import 'package:earned_it/views/wish/wish_view.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:go_router/go_router.dart';

final container = ProviderContainer();

final GoRouter routes = GoRouter(
  initialLocation: '/',
  debugLogDiagnostics: true,
  routes: <RouteBase>[
    // =================================================
    // 셸(Shell) 외부의 경로들 (인증, 온보딩 등)
    // =================================================
    GoRoute(
      path: '/',
      builder:
          (BuildContext context, GoRouterState state) => const SplashView(),
    ),
    GoRoute(
      path: '/onboarding',
      builder:
          (BuildContext context, GoRouterState state) => const OnboardingView(),
    ),
    GoRoute(
      path: '/sign',
      builder: (BuildContext context, GoRouterState state) => const SignView(),
    ),
    GoRoute(
      path: '/login',
      builder: (BuildContext context, GoRouterState state) => const LoginView(),
    ),
    GoRoute(
      path: '/forgot_password',
      builder:
          (BuildContext context, GoRouterState state) =>
              const ForgotPasswordView(),
    ),
    GoRoute(
      path: '/setSalary',
      builder:
          (BuildContext context, GoRouterState state) => const SetSalaryView(),
    ),
    GoRoute(
      path: '/addWish',
      builder:
          (BuildContext context, GoRouterState state) => const WishAddView(),
    ),
    GoRoute(
      path: '/editWish',
      builder: (BuildContext context, GoRouterState state) {
        // extra로 전달된 WishModel 객체를 추출합니다.
        final wishItem = state.extra as WishModel;
        // WishEditView에 추출한 객체를 전달하여 화면을 생성합니다.
        return WishEditView(wishItem: wishItem);
      },
    ),
    GoRoute(
      path: '/wishSearch',
      builder:
          (BuildContext context, GoRouterState state) => const WishSearchView(),
    ),
    GoRoute(
      path: '/wishALL',
      builder:
          (BuildContext context, GoRouterState state) => const WishAllView(),
    ),
    // =================================================
    // 셸(Shell) 경로: 하단 네비게이션 바가 유지되는 화면들
    // =================================================
    ShellRoute(
      builder: (BuildContext context, GoRouterState state, Widget child) {
        // NavigationView가 공통 UI(셸) 역할을 합니다.
        return NavigationView(child: child);
      },
      // 셸 내부에 표시될 자식 경로들
      routes: <RouteBase>[
        GoRoute(
          path: '/home', // 이전의 '/', '/main'을 '/home'으로 통일합니다.
          pageBuilder:
              (context, state) => CustomTransitionPage<void>(
                key: state.pageKey,
                child: const HomeView(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) =>
                        FadeTransition(opacity: animation, child: child),
              ),
        ),
        GoRoute(
          path: '/wish',
          pageBuilder:
              (context, state) => CustomTransitionPage<void>(
                key: state.pageKey,
                child: const WishView(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) =>
                        FadeTransition(opacity: animation, child: child),
              ),
        ),
        GoRoute(
          path: '/puzzle',
          pageBuilder:
              (context, state) => CustomTransitionPage<void>(
                key: state.pageKey,
                child: const PuzzleView(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) =>
                        FadeTransition(opacity: animation, child: child),
              ),
        ),
        GoRoute(
          path: '/setting',
          pageBuilder:
              (context, state) => CustomTransitionPage<void>(
                key: state.pageKey,
                child: const SettingView(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) =>
                        FadeTransition(opacity: animation, child: child),
              ),
        ),
      ],
    ),
  ],
);
