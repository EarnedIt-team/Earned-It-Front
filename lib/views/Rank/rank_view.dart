import 'dart:async';
import 'package:earned_it/config/design.dart';
import 'package:earned_it/models/rank/rank_model.dart';
import 'package:earned_it/view_models/rank_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

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
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // view model의 현재 상태를 읽어옵니다.
      final rankState = ref.read(rankViewModelProvider);
      final lastUpdated = rankState.lastUpdated;
      final now = DateTime.now();

      // 마지막 업데이트 시간이 null(최초 로드)이거나,
      // 마지막 업데이트 날짜와 현재 날짜가 다를 경우에만 데이터를 새로 불러옵니다.
      print("마지막 업데이트 : $lastUpdated");
      if (lastUpdated == null ||
          lastUpdated.year != now.year ||
          lastUpdated.month != now.month ||
          lastUpdated.day != now.day) {
        ref.read(rankViewModelProvider.notifier).loadRankData(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDarkMode ? Colors.black : lightColor2;
    final remainingTime = ref.watch(timerProvider);

    // RankViewModel의 상태를 watch
    final rankState = ref.watch(rankViewModelProvider);
    final myRank = rankState.myRank;
    final top10 = rankState.top10;

    // 로딩 중일 때 표시할 UI (데이터가 비어있을 때만 전체 화면 로딩)
    if (rankState.isLoading && top10.isEmpty) {
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
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

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
        actionsPadding: EdgeInsets.symmetric(horizontal: context.width(0.04)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.width(0.04)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: context.height(0.01)),
              // My Rank 섹션 데이터 바인딩
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    "My Rank",
                    style: TextStyle(
                      fontSize: context.width(0.05),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    myRank != null
                        ? "${NumberFormat('#,###').format(myRank.score)}P"
                        : "...",
                    style: TextStyle(
                      fontSize: context.width(0.03),
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 3),
                  Text(
                    myRank != null ? "${myRank.rank}등" : "...",
                    style: TextStyle(
                      fontSize: context.width(0.05),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              _buildTopRankersPodium(context, top10), // top10 데이터 전달
              SizedBox(height: context.height(0.03)),
              _buildRankList(top10), // top10 데이터 전달
            ],
          ),
        ),
      ),
    );
  }

  // 상위 3명 시상대 위젯
  Widget _buildTopRankersPodium(BuildContext context, List<RankModel> top10) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // 데이터에서 1, 2, 3위 찾기
    final ranker1 = top10.isNotEmpty ? top10[0] : null;
    final ranker2 = top10.length > 1 ? top10[1] : null;
    final ranker3 = top10.length > 2 ? top10[2] : null;

    return SizedBox(
      height: screenHeight * 0.35,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // 2위
          if (ranker2 != null)
            _buildPodiumItem(
              ranker: ranker2,
              height: screenHeight * 0.16,
              color: const Color(0xFFC0C0C0), // 은색
              screenWidth: screenWidth,
            ),
          // 1위
          if (ranker1 != null)
            _buildPodiumItem(
              ranker: ranker1,
              height: screenHeight * 0.22,
              color: const Color(0xFFFFD700), // 금색
              screenWidth: screenWidth,
            ),
          // 3위
          if (ranker3 != null)
            _buildPodiumItem(
              ranker: ranker3,
              height: screenHeight * 0.1,
              color: const Color(0xFFCD7F32), // 동색
              screenWidth: screenWidth,
            ),
        ],
      ),
    );
  }

  // 시상대 개별 아이템 위젯
  Widget _buildPodiumItem({
    required RankModel ranker,
    required double height,
    required Color color,
    required double screenWidth,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        CircleAvatar(
          radius: ranker.rank == 1 ? 30 : 25,
          backgroundImage:
              ranker.profileImage != null
                  ? NetworkImage(ranker.profileImage!)
                  : null,
          backgroundColor: Colors.grey.shade300,
          child:
              ranker.profileImage == null
                  ? Icon(
                    Icons.person,
                    size: ranker.rank == 1 ? 35 : 30,
                    color: Colors.grey.shade600,
                  )
                  : null,
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: context.width(0.25),
          child: Text(
            ranker.nickname,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: context.width(0.035),
            ),
            maxLines: 2, // 최대 2줄까지 표시
            overflow: TextOverflow.ellipsis, // 2줄을 넘어가면 말줄임표(...) 표시
          ),
        ),
        const SizedBox(height: 5),
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
                '${ranker.rank}등',
                style: TextStyle(
                  fontSize: context.width(0.065),
                  fontWeight: FontWeight.bold,
                  color: Colors.white.withOpacity(0.9), // 수정된 부분
                  shadows: [
                    Shadow(
                      color: Colors.black.withOpacity(0.2), // 수정된 부분
                      blurRadius: 4,
                      offset: const Offset(2, 2),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              Text(
                '${NumberFormat('#,###').format(ranker.score)} P',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white.withOpacity(0.9), // 수정된 부분
                  shadows: [
                    Shadow(
                      color: Colors.black.withOpacity(0.2), // 수정된 부분
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

  // 4~10위 리스트 위젯
  Widget _buildRankList(List<RankModel> top10) {
    // 4위부터 10위까지의 리스트 (데이터가 3개 초과일 경우에만)
    final remainingRankers =
        top10.length > 3 ? top10.sublist(3) : <RankModel>[];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "TOP 10",
          style: TextStyle(
            fontSize: context.width(0.05),
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          "점수를 측정하는 방식은 다음과 같습니다.",
          style: TextStyle(fontSize: context.width(0.032), color: Colors.grey),
        ),
        Text(
          "• 테마 완성 시 +100pt\n• 조각 획득 시, 희귀도(S,A,B)에 따라 +10 / 7 / 5pt\n• 출석 시 +10pt",
          style: TextStyle(fontSize: context.width(0.032), color: Colors.grey),
        ),
        const SizedBox(height: 12),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: remainingRankers.length, // 데이터 길이에 맞춤
          itemBuilder: (context, index) {
            final ranker = remainingRankers[index];
            return Container(
              padding: EdgeInsets.symmetric(
                horizontal: context.middlePadding,
                vertical: context.middlePadding / 2,
              ),
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
                      '${ranker.rank}', // 실제 랭킹 데이터 사용
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: context.width(0.045),
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  CircleAvatar(
                    radius: 22,
                    backgroundImage:
                        ranker.profileImage != null
                            ? NetworkImage(ranker.profileImage!)
                            : null,
                    backgroundColor: Colors.grey.shade300,
                    child:
                        ranker.profileImage == null
                            ? Icon(Icons.person, color: Colors.grey.shade600)
                            : null,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      ranker.nickname, // 실제 닉네임 데이터 사용
                      style: TextStyle(
                        fontSize: context.width(0.03),
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    '${NumberFormat('#,###').format(ranker.score)} P', // 실제 점수 데이터 사용
                    style: TextStyle(
                      fontSize: context.width(0.04),
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
