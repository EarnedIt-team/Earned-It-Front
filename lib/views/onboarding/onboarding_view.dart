import 'package:earned_it/config/design.dart';
import 'package:earned_it/views/onboarding/onboarding_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// 온보딩 화면을 위한 간단한 플레이스홀더 위젯
class OnboardingView extends StatefulWidget {
  // StatefulWidget으로 변경
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final PageController _pageController = PageController(); // PageView 컨트롤러
  int _currentPage = 0; // 현재 페이지 인덱스

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 홈 인디케이터, 내비게이션 바가 가려지는 것을 방지
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // PageView가 차지할 공간을 확장하기 위해 Expanded
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (int index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                children: const <Widget>[
                  // 첫 번째 온보딩 페이지
                  OnboardingPage(
                    imagePath: "assets/images/time.png",
                    title: "환영합니다!",
                    description: "시간을 돈으로 바꾸는 새로운 경험을 시작해보세요.",
                  ),
                  // 두 번째 온보딩 페이지
                  OnboardingPage(
                    imagePath: "assets/images/time.png",
                    title: "동기부여를 제공",
                    description: "매달 구매하고 싶은 위시리스트를 등록하세요.",
                  ),
                  // 세 번째 온보딩 페이지
                  OnboardingPage(
                    imagePath: "assets/images/time.png",
                    title: "무엇이 가능할까?",
                    description: "누적된 금액으로 무엇을 할 수 있을까요?",
                  ),
                ],
              ),
            ),
            // pageView indicator
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (int index) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: context.width(0.01)),
                  width: context.width(0.025),
                  height: context.width(0.025),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color:
                        _currentPage == index
                            ? primaryColor
                            : const Color.fromARGB(255, 210, 210, 210),
                  ),
                );
              }),
            ),
            SizedBox(height: context.height(0.05)), // indicator 와 버튼 사이 간격
            // 회원가입 & 로그인
            Padding(
              padding: EdgeInsets.all(context.middlePadding),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        side: const BorderSide(
                          width: 0.5,
                          color: Color.fromARGB(255, 159, 114, 37),
                        ),
                        backgroundColor: primaryColor,
                        padding: EdgeInsets.symmetric(
                          vertical: context.buttonPadding,
                        ),
                      ),
                      onPressed: () {
                        context.push("/sign");
                      },
                      child: Text(
                        "회원가입",
                        style: TextStyle(
                          fontSize: context.regularFont,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: context.height(0.01)), // 버튼 간 간격
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        side: const BorderSide(width: 0.5, color: Colors.grey),
                        backgroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(
                          vertical: context.buttonPadding,
                        ),
                      ),
                      onPressed: () {
                        context.push("/login");
                      },
                      child: Text(
                        "기존 계정으로 로그인",
                        style: TextStyle(
                          fontSize: context.regularFont,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
