import 'dart:async';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:earned_it/models/home/home_state.dart';
import 'package:earned_it/view_models/user_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeViewModelProvider =
    NotifierProvider.autoDispose<HomeViewModel, HomeState>(HomeViewModel.new);

class HomeViewModel extends AutoDisposeNotifier<HomeState> {
  final CarouselSliderController carouselController =
      CarouselSliderController();
  Timer? _timer;

  @override
  HomeState build() {
    ref.onDispose(() {
      _timer?.cancel();
    });

    ref.listen(userProvider, (previous, next) {
      final wasEarning = previous?.isearningsPerSecond ?? false;
      final isEarning = next.isearningsPerSecond;

      if (isEarning && !wasEarning) {
        startEarningTimer(next.payday, next.earningsPerSecond);
      } else if (!isEarning && wasEarning) {
        _timer?.cancel();
        state = state.copyWith(currentEarnedAmount: 0.0);
      }
    });

    final userState = ref.read(userProvider);
    if (userState.isearningsPerSecond) {
      Future(
        () => startEarningTimer(userState.payday, userState.earningsPerSecond),
      );
    }

    return const HomeState();
  }

  void updateToggleIndex(int index) {
    state = state.copyWith(toggleIndex: index);
  }

  void startEarningTimer(int payday, double earningsPerSecond) {
    _timer?.cancel();
    final now = DateTime.now();
    DateTime lastPayday;

    if (now.day >= payday) {
      lastPayday = DateTime(now.year, now.month, payday);
    } else {
      lastPayday = DateTime(now.year, now.month - 1, payday);
    }

    final initialElapsedSeconds = now.difference(lastPayday).inSeconds;
    state = state.copyWith(
      currentEarnedAmount: initialElapsedSeconds * earningsPerSecond,
    );

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      state = state.copyWith(
        currentEarnedAmount: state.currentEarnedAmount + earningsPerSecond,
      );
    });
  }
}
