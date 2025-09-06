import 'dart:async';
import 'package:earned_it/config/design.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 다음 정각까지 남은 시간을 1초마다 제공하는 StreamProvider
final timerProvider = StreamProvider<String>((ref) {
  return Stream.periodic(const Duration(seconds: 1), (_) {
    final now = DateTime.now();
    // 다음 날 자정(00:00:00) 계산
    final tomorrow = DateTime(now.year, now.month, now.day + 1);
    final difference = tomorrow.difference(now);

    // 남은 시간을 HH:MM:SS 형식으로 변환
    final hours = difference.inHours;
    final minutes = difference.inMinutes % 60;
    final seconds = difference.inSeconds % 60;

    final hoursStr = hours.toString().padLeft(2, '0');
    final minutesStr = minutes.toString().padLeft(2, '0');
    final secondsStr = seconds.toString().padLeft(2, '0');

    return '$hoursStr:$minutesStr:$secondsStr';
  });
});

class RankView extends ConsumerStatefulWidget {
  const RankView({super.key});

  @override
  ConsumerState<RankView> createState() => _RankViewState();
}

class _RankViewState extends ConsumerState<RankView> {
  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDarkMode ? Colors.black : lightColor2;
    final mediaQuery = MediaQuery.of(context);
    // timerProvider를 감시하여 실시간으로 시간 데이터를 받아옵니다.
    final remainingTime = ref.watch(timerProvider);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: backgroundColor,
        elevation: 0,
        title: const Row(
          children: [
            Icon(Icons.leaderboard),
            SizedBox(width: 10),
            Text("랭킹", style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        centerTitle: false,
        actions: <Widget>[
          Row(
            children: [
              const Icon(Icons.timelapse),
              const SizedBox(width: 5),
              // StreamProvider의 상태에 따라 다른 UI를 보여줍니다.
              remainingTime.when(
                data:
                    (time) => Text(
                      time,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                loading:
                    () => const Text(
                      "00:00:00",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                error:
                    (err, stack) => const Text(
                      "Error",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
              ),
            ],
          ),
        ],
        actionsPadding: EdgeInsets.symmetric(
          horizontal: mediaQuery.size.width * 0.04,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: mediaQuery.size.width * 0.04,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: mediaQuery.size.height * 0.01),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    "My Rank",
                    style: TextStyle(
                      fontSize: mediaQuery.size.width * 0.05,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    "2,350,100P",
                    style: TextStyle(
                      fontSize: mediaQuery.size.width * 0.03,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 3),
                  Text(
                    "1등",
                    style: TextStyle(
                      fontSize: mediaQuery.size.width * 0.05,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              _buildTopRankersPodium(context),
              SizedBox(height: mediaQuery.size.height * 0.03),
              _buildRankList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopRankersPodium(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      height: screenHeight * 0.35,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildPodiumItem(
            rank: 2,
            height: screenHeight * 0.16,
            color: const Color(0xFFC0C0C0), // 은색
            name: "User B",
            screenWidth: screenWidth,
          ),
          _buildPodiumItem(
            rank: 1,
            height: screenHeight * 0.22,
            color: const Color(0xFFFFD700), // 금색
            name: "User A",
            screenWidth: screenWidth,
          ),
          _buildPodiumItem(
            rank: 3,
            height: screenHeight * 0.1,
            color: const Color(0xFFCD7F32), // 동색
            name: "User C",
            screenWidth: screenWidth,
          ),
        ],
      ),
    );
  }

  Widget _buildPodiumItem({
    required int rank,
    required double height,
    required Color color,
    required String name,
    required double screenWidth,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        CircleAvatar(
          radius: rank == 1 ? 30 : 25,
          backgroundColor: Colors.grey.shade300,
          child: Icon(
            Icons.person,
            size: rank == 1 ? 35 : 30,
            color: Colors.grey.shade600,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          name,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 4),
        Container(
          width: screenWidth / 3.5,
          height: height,
          decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$rank등',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white.withOpacity(0.9),
                  shadows: [
                    Shadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 4,
                      offset: const Offset(2, 2),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              Text(
                '2,350,100 P',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white.withOpacity(0.9),
                  shadows: [
                    Shadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 4,
                      offset: const Offset(2, 2),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRankList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "TOP 10",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const Text(
          "점수를 측정하는 방식은 다음과 같습니다.",
          style: TextStyle(fontSize: 13, color: Colors.grey),
        ),
        const Text(
          "• 테마 완성 시 +100pt\n• 조각 획득 시, 희귀도(S,A,B)에 따라 +10 / 7 / 5pt\n• 출석 시 +10pt",
          style: TextStyle(fontSize: 13, color: Colors.grey),
        ),
        const SizedBox(height: 12),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 7,
          itemBuilder: (context, index) {
            final rank = index + 4;
            return Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              decoration: BoxDecoration(
                color:
                    Theme.of(context).brightness == Brightness.dark
                        ? Colors.grey.shade900
                        : Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 30,
                    child: Text(
                      '$rank',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: Colors.grey.shade300,
                    child: Icon(Icons.person, color: Colors.grey.shade600),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'User ${String.fromCharCode(68 + index)}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const Text(
                    '1,234 P',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (context, index) => const SizedBox(height: 10),
        ),
      ],
    );
  }
}
