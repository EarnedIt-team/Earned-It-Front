import 'dart:async';
import 'package:earned_it/config/design.dart';
import 'package:earned_it/models/rank/rank_model.dart';
import 'package:earned_it/view_models/rank_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

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
      ref.read(rankViewModelProvider.notifier).loadRankData(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDarkMode ? Colors.black : lightColor2;

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

    // 1. 시상대의 최대/최소 높이를 미리 정의합니다.
    final maxPodiumHeight = screenHeight * 0.22; // 1등이 차지할 최대 높이
    final minPodiumHeight = screenHeight * 0.03; // 점수가 0점에 가까울 때의 최소 높이

    // 2. 랭킹 1위의 점수를 최대 점수로 설정합니다. (리스트가 비어있을 경우 에러 방지)
    final maxScore = top10.isNotEmpty ? top10[0].score : 1;

    // 데이터에서 1, 2, 3위 찾기
    final ranker1 = top10.isNotEmpty ? top10[0] : null;
    final ranker2 = top10.length > 1 ? top10[1] : null;
    final ranker3 = top10.length > 2 ? top10[2] : null;

    // 3. 각 랭커의 점수 비율에 따라 높이를 동적으로 계산합니다.
    // (점수 / 최대점수) 비율을 높이 범위에 적용
    final height1 = ranker1 != null ? maxPodiumHeight : 0.0;
    final height2 =
        ranker2 != null
            ? minPodiumHeight +
                (ranker2.score / maxScore) * (maxPodiumHeight - minPodiumHeight)
            : 0.0;
    final height3 =
        ranker3 != null
            ? minPodiumHeight +
                (ranker3.score / maxScore) * (maxPodiumHeight - minPodiumHeight)
            : 0.0;

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
              height: height2, // ✨ 계산된 높이 전달
              color: const Color.fromARGB(255, 236, 128, 111),
              screenWidth: screenWidth,
            ),
          // 1위
          if (ranker1 != null)
            _buildPodiumItem(
              ranker: ranker1,
              height: height1, // ✨ 계산된 높이 전달
              color: primaryGradientEnd, // 금색
              screenWidth: screenWidth,
            ),
          // 3위
          if (ranker3 != null)
            _buildPodiumItem(
              ranker: ranker3,
              height: height3, // ✨ 계산된 높이 전달
              color: const Color.fromARGB(255, 151, 105, 98), // 동색
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
    return InkWell(
      onTap:
          ranker.public!
              ? () {
                context.push(
                  '/profile/${ranker.userId}?isPublic=${ranker.public}}',
                );
              }
              : null,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          CircleAvatar(
            radius: ranker.rank == 1 ? 30 : 25, // 테두리를 위해 약간 더 크게
            backgroundColor:
                ranker.public!
                    ? primaryGradientStart
                    : Colors.transparent, // public일 때만 색상 적용
            child: CircleAvatar(
              radius: ranker.rank == 1 ? 28 : 23,
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
      ),
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
            return InkWell(
              onTap:
                  ranker.public!
                      ? () {
                        context.push(
                          '/profile/${ranker.userId}?isPublic=${ranker.public}}',
                        );
                      }
                      : null,
              child: Container(
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
                      radius: 20, // 테두리를 위해 약간 더 크게
                      backgroundColor:
                          ranker.public!
                              ? primaryGradientStart
                              : Colors.transparent,
                      child: CircleAvatar(
                        radius: 18,
                        backgroundImage:
                            ranker.profileImage != null
                                ? NetworkImage(ranker.profileImage!)
                                : null,
                        backgroundColor: Colors.grey.shade300,
                        child:
                            ranker.profileImage == null
                                ? Icon(
                                  Icons.person,
                                  color: Colors.grey.shade600,
                                )
                                : null,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        ranker.nickname, // 실제 닉네임 데이터 사용
                        style: TextStyle(
                          fontSize: context.width(0.035),
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
              ),
            );
          },
          separatorBuilder: (context, index) => const SizedBox(height: 10),
        ),
      ],
    );
  }
}
