import 'package:earned_it/config/design.dart';
import 'package:flutter/material.dart';

class RankView extends StatefulWidget {
  const RankView({super.key});

  @override
  State<RankView> createState() => _RankViewState();
}

class _RankViewState extends State<RankView> {
  @override
  Widget build(BuildContext context) {
    // 화면의 밝기 모드를 확인합니다.
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    // 배경색을 설정합니다.
    final backgroundColor = isDarkMode ? Colors.black : lightColor2;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: backgroundColor,
        elevation: 0, // AppBar 그림자 제거
        title: const Text("랭킹", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: false,
        actions: const <Widget>[
          Row(
            spacing: 5,
            children: [
              Icon(Icons.timelapse),
              Text("04:23:15", style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ],
        actionsPadding: EdgeInsets.symmetric(horizontal: context.middlePadding),
      ),
      body: SingleChildScrollView(
        // 전체 화면을 스크롤할 수 있도록 합니다.
        // padding: EdgeInsets.symmetric(vertical: context.middlePadding),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.middlePadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1, 2, 3등을 표시하는 포디움 위젯
              SizedBox(height: context.height(0.01)),
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
                    "2,350,100P",
                    style: TextStyle(
                      fontSize: context.width(0.03),
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "1등",
                    style: TextStyle(
                      fontSize: context.width(0.05),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              _buildTopRankersPodium(context),
              SizedBox(height: context.height(0.03)),

              // 4~10등 리스트
              _buildRankList(),
            ],
          ),
        ),
      ),
    );
  }

  // 명예의 전당 (TOP 3) 포디움 위젯
  Widget _buildTopRankersPodium(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      height: screenHeight * 0.35,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // 2등
          _buildPodiumItem(
            rank: 2,
            height: screenHeight * 0.15,
            color: const Color(0xFFC0C0C0), // 은색
            name: "User B",
            screenWidth: screenWidth,
          ),
          // 1등
          _buildPodiumItem(
            rank: 1,
            height: screenHeight * 0.22,
            color: const Color(0xFFFFD700), // 금색
            name: "User A",
            screenWidth: screenWidth,
          ),
          // 3등
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

  // 포디움의 각 항목(순위, 이름, 아바타, 막대)을 구성하는 위젯
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
        // 사용자 아바타
        CircleAvatar(
          radius: rank == 1 ? 30 : 25, // 1등은 더 크게
          backgroundColor: Colors.grey.shade300,
          child: Icon(
            Icons.person,
            size: rank == 1 ? 35 : 30,
            color: Colors.grey.shade600,
          ),
        ),
        const SizedBox(height: 8),
        // 사용자 이름
        Text(
          name,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 4),
        // 순위 막대
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
            spacing: 5,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$rank등',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white.withValues(alpha: 0.9),
                  shadows: [
                    Shadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      blurRadius: 4,
                      offset: const Offset(2, 2),
                    ),
                  ],
                ),
              ),
              Text(
                '2,350,100 P',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white.withValues(alpha: 0.9),
                  shadows: [
                    Shadow(
                      color: Colors.black.withValues(alpha: 0.2),
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

  // 4~10등까지의 랭킹 리스트를 빌드하는 위젯
  Widget _buildRankList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 리스트 뷰의 제목
        const Text(
          "TOP 10",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 7, // 4등부터 10등까지 총 7명
          itemBuilder: (context, index) {
            final rank = index + 4;
            // 각 랭킹 아이템의 UI
            return Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              decoration: BoxDecoration(
                // 다크/라이트 모드에 따라 카드 색상 조정
                color:
                    Theme.of(context).brightness == Brightness.dark
                        ? Colors.grey.shade900
                        : Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  // 순위
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
                  // 아바타
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: Colors.grey.shade300,
                    child: Icon(Icons.person, color: Colors.grey.shade600),
                  ),
                  const SizedBox(width: 12),
                  // 사용자 이름
                  Expanded(
                    child: Text(
                      'User ${String.fromCharCode(68 + index)}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  // 점수 (예시)
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
          separatorBuilder:
              (context, index) => const SizedBox(height: 10), // 아이템 사이 간격
        ),
      ],
    );
  }
}
