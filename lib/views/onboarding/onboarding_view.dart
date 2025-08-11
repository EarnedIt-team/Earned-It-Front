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
                ],
              ),
            ),
            Positioned(
              bottom: context.height(0.045),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(4, (int index) {
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
                              ? Theme.of(context).brightness == Brightness.dark
                                  ? primaryGradientEnd
                                  : Colors.black
                              : const Color.fromARGB(255, 210, 210, 210),
                    ),
                  );
                }),
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
        // Column(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   crossAxisAlignment: CrossAxisAlignment.center,
        //   children: <Widget>[
        //     // PageView가 차지할 공간을 확장하기 위해 Expanded
        //     Expanded(
        //       child: PageView(
        //         controller: _pageController,
        //         onPageChanged: (int index) {
        //           setState(() {
        //             _currentPage = index;
        //           });
        //         },
        //         children: const <Widget>[
        //           // 첫 번째 온보딩 페이지
        //           OnboardingPage(
        //             imagePath: "assets/images/onboarding/page1.png",
        //             title: "환영합니다!",
        //             description: "시간을 돈으로 바꾸는 새로운 경험을 시작해보세요.",
        //           ),
        //           // 두 번째 온보딩 페이지
        //           OnboardingPage(
        //             imagePath: "assets/images/time.png",
        //             title: "동기부여를 제공",
        //             description: "매달 구매하고 싶은 위시리스트를 등록하세요.",
        //           ),
        //           // 세 번째 온보딩 페이지
        //           OnboardingPage(
        //             imagePath: "assets/images/time.png",
        //             title: "무엇이 가능할까?",
        //             description: "누적된 금액으로 무엇을 할 수 있을까요?",
        //           ),
        //         ],
        //       ),
        //     ),
        //     // pageView indicator
        //     Row(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: List.generate(3, (int index) {
        //         return Container(
        //           margin: EdgeInsets.symmetric(
        //             horizontal: context.width(0.01),
        //           ),
        //           width: context.width(0.025),
        //           height: context.width(0.025),
        //           decoration: BoxDecoration(
        //             shape: BoxShape.circle,
        //             color:
        //                 _currentPage == index
        //                     ? primaryColor
        //                     : const Color.fromARGB(255, 210, 210, 210),
        //           ),
        //         );
        //       }),
        //     ),
        //     SizedBox(height: context.height(0.05)), // indicator 와 버튼 사이 간격
        //     // 회원가입 & 로그인
        //     Padding(
        //       padding: EdgeInsets.all(context.middlePadding),
        //       child: Column(
        //         children: <Widget>[
        //           SizedBox(
        //             width: double.infinity,
        //             child: ElevatedButton(
        //               style: ElevatedButton.styleFrom(
        //                 side: const BorderSide(
        //                   width: 0.5,
        //                   color: Color.fromARGB(255, 159, 114, 37),
        //                 ),
        //                 backgroundColor: primaryColor,
        //                 padding: EdgeInsets.symmetric(
        //                   vertical: context.buttonPadding,
        //                 ),
        //               ),
        //               onPressed: () {
        //                 context.push("/sign");
        //               },
        //               child: Text(
        //                 "회원가입",
        //                 style: TextStyle(
        //                   fontSize: context.regularFont,
        //                   color: Colors.black,
        //                 ),
        //               ),
        //             ),
        //           ),
        //           SizedBox(height: context.height(0.01)), // 버튼 간 간격
        //           SizedBox(
        //             width: double.infinity,
        //             child: ElevatedButton(
        //               style: ElevatedButton.styleFrom(
        //                 side: const BorderSide(
        //                   width: 0.5,
        //                   color: Colors.grey,
        //                 ),
        //                 backgroundColor: Colors.white,
        //                 padding: EdgeInsets.symmetric(
        //                   vertical: context.buttonPadding,
        //                 ),
        //               ),
        //               onPressed: () {
        //                 context.push("/login");
        //               },
        //               child: Text(
        //                 "기존 계정으로 로그인",
        //                 style: TextStyle(
        //                   fontSize: context.regularFont,
        //                   color: Colors.black,
        //                 ),
        //               ),
        //             ),
        //           ),
        //         ],
        //       ),
        //     ),
        //   ],
        // ),
      ),
    );
  }
}
