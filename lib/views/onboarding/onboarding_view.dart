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
                    title: "시간은,\n금이다",
                    description:
                        "Time is gold !\n\n큰 돈이 떨어져 있어도, 그 시간에 더 큰 가치를 벌 수 있다면 줍지 않는다는 워렌 버핏의 명언을 아시나요?\n\n지금 이 순간에도, 당신의 시간은 돈으로 변하고 있습니다.",
                  ),
                  OnboardingPage(
                    imagePath: "assets/images/onboarding/page2.png",
                    title: "연봉, 월급, 일급 ...\n그리고 초 수익?",
                    description:
                        "언드잇에서는 매 분, 심지어 매 초\n\n당신의 누적 수익이 실시간으로 증가합니다.\n\n세상에 없던 개념, 초 수익. 언드잇 에서만 경험하세요.\n분명 시간의 귀중함을, 그리고 따라오는 돈의 관계를 느낄 수 있을 거에요.",
                  ),
                  OnboardingPage(
                    imagePath: "assets/images/onboarding/page3.png",
                    title: "당신의 목표,\n지금 어디까지 왔나요?",
                    description:
                        "숨 쉬는 매 순간 목표에 가까워지고 있습니다.\n\n꼭 판매하는 물품이 아니어도 괜찮아요.\n\n여러분의 소중한 위시리스트를 설정하면, 이번 월 수익에서 위시아이템 금액 달성까지 얼마나 벌었는지 보여드립니다. 덤으로 구매 체크를 통해 리스트를 관리해보세요.",
                  ),
                  OnboardingPage(
                    imagePath: "assets/images/onboarding/page4.png",
                    title: "자주 볼 수록\n의지는 더 강해지니까",
                    description:
                        '"내 수익, 국밥 몇 그릇 정도 벌었을까?"\n\n퍼즐 조각에는 다양한 실제 아이템이 배치되어있어요.\n출석체크 등을 통해 조각을 랜덤으로 획득해보세요.\n획득한 조각을 내 누적 수익으로 환산해서 볼 수 있어요. 당신의 열정을 보여주세요.',
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
                  child: Column(
                    children: [
                      SizedBox(
                        width: context.width(1),
                        height: context.height(0.065),
                        child: ElevatedButton(
                          onPressed: () {
                            context.go("/home");
                          },
                          child: Text(
                            "Earned it 시작하기",
                            style: TextStyle(fontSize: context.width(0.045)),
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          context.go("/login");
                        },
                        child: Text(
                          "기존 계정으로 로그인",
                          style: TextStyle(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.grey
                                    : Colors.grey[300],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            if (_currentPage < 4)
              Positioned(
                right: 30,
                top: 80,
                child: IconButton(
                  onPressed: () {
                    context.go("/home");
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
