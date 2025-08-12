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
    return Container(
      // 2. Container의 decoration에 정의해둔 primaryGradient를 적용합니다.
      decoration:
          Theme.of(context).brightness != Brightness.dark
              ? primaryGradient
              : null,
      child: Scaffold(
        backgroundColor:
            Theme.of(context).brightness == Brightness.dark
                ? Colors.black
                : Colors.transparent,
        // 홈 인디케이터, 내비게이션 바가 가려지는 것을 방지
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            // 👇 Positioned를 Positioned.fill로 변경합니다.
            Positioned.fill(
              bottom: 0,
              child: PageView(
                controller: _pageController,
                onPageChanged: (int index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                children: const <Widget>[
                  OnboardingPage(
                    imagePath: "assets/images/onboarding/page1.png",
                    title: "시간은\n금이다",
                    description:
                        "워렌 버핏이 말했죠.\n큰 돈이 떨어져 있어도, 그 시간에 더 큰 가치를 벌 수 있다면 줍지 않는다고. 지금 이 순간에도, 당신의 시간은 돈으로 변하고 있습니다.",
                  ),
                  OnboardingPage(
                    imagePath: "assets/images/onboarding/page2.png",
                    title: "연봉, 월급, 일급 ...\n그리고 초 수익?",
                    description:
                        "매 분, 매 초, 당신의 수입이 실시간으로 표시됩니다. 세상에 없던 개념, Earned it에서만 경험하세요.",
                  ),
                  OnboardingPage(
                    imagePath: "assets/images/onboarding/page3.png",
                    title: "당신의 목표,\n지금 어디까지 왔나요?",
                    description:
                        "위시리스트를 설정하면, 이번 월급에서 목표 달성까지 얼마나 벌었는지 보여드립니다. 목표를 채우면 바로 구매 완료 표시까지!",
                  ),
                  OnboardingPage(
                    imagePath: "assets/images/onboarding/page4.png",
                    title: "자주 볼 수록\n의지는 더 강해지니까",
                    description:
                        "출석체크로 조각을 랜덤으로 획득하세요. 각 조각에는 실제 수익과 구매 가능한 개수가 표기되는 등 재밌는 통계로 동기부여를 제공합니다.",
                  ),
                  OnboardingPage(
                    imagePath: "",
                    title: "시간은 흘러가지만\n당신의 가치는 쌓입니다",
                    description:
                        '"Earned it - 당신의 시간을 가치로 바꾸세요"\n흘려보낸 시간 속에 숨어있던 가치를 확인하세요.',
                  ),
                ],
              ),
            ),
            if (_currentPage < 4)
              Positioned(
                bottom: context.height(0.045),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (int index) {
                    return Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: context.width(0.01),
                      ),
                      width: context.width(0.015),
                      height: context.width(0.015),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color:
                            _currentPage == index
                                ? Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? primaryGradientEnd
                                    : Colors.black
                                : const Color.fromARGB(255, 210, 210, 210),
                      ),
                    );
                  }),
                ),
              )
            else
              Positioned(
                left: 0,
                right: 0,
                bottom: context.height(0.045),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.middlePadding,
                  ),
                  child: SizedBox(
                    height: context.height(0.065),
                    child: ElevatedButton(
                      onPressed: () {
                        context.push("/sign");
                      },
                      child: Text(
                        "회원가입 후 시작하기",
                        style: TextStyle(fontSize: context.width(0.045)),
                      ),
                    ),
                  ),
                ),
              ),
            Positioned(
              right: 30,
              top: 80,
              child: IconButton(
                onPressed: () {
                  context.go("/login");
                },
                icon: Icon(
                  Icons.close,
                  size: context.width(0.1),
                  color:
                      Theme.of(context).brightness == Brightness.dark
                          ? Colors.grey
                          : const Color.fromARGB(255, 228, 166, 174),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
