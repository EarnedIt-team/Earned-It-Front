import 'package:action_slider/action_slider.dart';
import 'package:earned_it/config/design.dart';
import 'package:earned_it/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:url_launcher/url_launcher.dart';

Future<bool?> agreementModal(BuildContext context, String token) {
  return showModalBottomSheet<bool>(
    context: context,
    isScrollControlled: true, // 내용이 많아도 잘리지 않도록 설정
    enableDrag: false,
    builder: (BuildContext context) {
      return SafeArea(
        child: Padding(
          padding: EdgeInsets.all(context.middlePadding),
          child: Column(
            mainAxisSize: MainAxisSize.min, // << 중요: 내용에 맞춰 높이 자동 조절
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // 1. 제목
              const Text(
                "약관 동의",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              // 2. 약관 요약 내용
              const Text(
                "Earned It(언드잇)’의 원활한 서비스 이용을 위해 약관 동의를 받고 있습니다. 아래 내용에 동의해 주셔야 전체 서비스를 이용하실 수 있어요.",
              ),
              const SizedBox(height: 8),

              // 3. 전체 약관 보기 버튼 (실제 동작하도록 수정)
              TextButton(
                onPressed: () async {
                  final Uri url = Uri.parse(
                    'https://github.com/EarnedIt-team',
                  ); // 실제 약관 URL로 변경
                  if (!await launchUrl(url)) {
                    throw Exception('Could not launch $url');
                  }
                },
                // 시각적 터치 영역을 확보하기 위해 패딩 조정
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  alignment: Alignment.centerLeft,
                ),
                child: const Text(
                  "서비스 이용 약관 전문 보기",
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              ),
              const SizedBox(height: 32),

              // 4. 동의 액션 슬라이더 (핵심 기능 수정)
              ActionSlider.standard(
                sliderBehavior: SliderBehavior.stretch,
                // 배경색 및 전경색 테마 적용
                backgroundColor: Colors.grey.shade200,
                toggleColor: Colors.green,
                action: (ActionSliderController controller) async {
                  controller.loading(); // 로딩 애니메이션 시작
                  await Future.delayed(const Duration(seconds: 1)); // 처리 시간 흉내

                  try {
                    final List<Map<String, dynamic>> requestBody =
                        <Map<String, dynamic>>[
                          {"type": "SERVICE_REQUIRED", "isChecked": true},
                        ];
                    print("토큰 $token");
                    final response = await restClient.agreedTerms(
                      "Bearer $token",
                      requestBody,
                    );

                    if (response.code == "SUCCESS") {
                      controller.success(); // 성공 애니메이션 시작
                      await Future.delayed(const Duration(milliseconds: 1000));
                      if (context.mounted) {
                        Navigator.pop(context, true);
                      }
                    }
                  } catch (e) {
                    print("에러 발생 $e");
                    controller.failure();
                    await Future.delayed(const Duration(milliseconds: 1000));
                    if (context.mounted) {
                      Navigator.pop(context, false);
                    }
                  }
                },
                child: const Text('밀어서 약관에 동의하기'),
              ),
            ],
          ),
        ),
      );
    },
  );
}
