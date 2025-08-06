import 'package:earned_it/config/design.dart';
import 'package:flutter/material.dart';

class PuzzleView extends StatefulWidget {
  const PuzzleView({super.key});

  @override
  State<PuzzleView> createState() => _PuzzleViewState();
}

class _PuzzleViewState extends State<PuzzleView> {
  // 1. 스크롤 위치를 감지하기 위한 ScrollController 생성
  late final ScrollController _scrollController;
  // 2. FloatingActionButton의 표시 여부를 관리할 상태 변수
  bool _showFab = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    // 3. 스크롤이 움직일 때마다 _scrollListener 함수를 실행하도록 등록
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    // 4. 위젯이 사라질 때 컨트롤러와 리스너를 메모리에서 해제
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  // 5. 스크롤 위치를 감지하여 _showFab 상태를 변경하는 함수
  void _scrollListener() {
    // 200픽셀 이상 스크롤을 내렸는지 확인
    if (_scrollController.offset >= 200 && !_showFab) {
      setState(() {
        _showFab = true;
      });
    } else if (_scrollController.offset < 200 && _showFab) {
      setState(() {
        _showFab = false;
      });
    }
  }

  // 6. 화면 최상단으로 스크롤을 이동시키는 함수
  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500), // 0.5초 동안 부드럽게 이동
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: const Row(
          children: <Widget>[
            Icon(Icons.extension),
            SizedBox(width: 10),
            Text("퍼즐", style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        centerTitle: false,
      ),
      // 7. FloatingActionButton 추가
      floatingActionButton: AnimatedOpacity(
        opacity: _showFab ? 1.0 : 0.0, // _showFab 값에 따라 투명도 조절
        duration: const Duration(milliseconds: 300), // 0.3초 동안 부드럽게 나타나고 사라짐
        child: FloatingActionButton(
          onPressed: _scrollToTop,
          child: const Icon(Icons.arrow_upward),
        ),
      ),
      body: SingleChildScrollView(
        controller: _scrollController, // 8. 컨트롤러를 SingleChildScrollView에 연결
        padding: EdgeInsets.symmetric(horizontal: context.middlePadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "현재까지 누적 금액",
              style: TextStyle(
                fontSize: context.height(0.02),
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "123,345,678원",
              style: TextStyle(fontSize: context.height(0.035)),
            ),
            const SizedBox(height: 10),
            Text(
              "완성한 테마 : 3 / 6 (50%)",
              style: TextStyle(fontSize: context.height(0.015)),
            ),
            Text(
              "획득한 조각 : 3 / 30 (75%)",
              style: TextStyle(fontSize: context.height(0.015)),
            ),
            const SizedBox(height: 24),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 30,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                return ElevatedButton(
                  onPressed: () {
                    // TODO: 퍼즐 조각 탭 시 동작 구현
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Theme.of(context).brightness == Brightness.dark
                            ? Colors.grey[800]
                            : Colors.grey[200],
                    padding: EdgeInsets.zero,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(
                        color:
                            Theme.of(context).brightness == Brightness.dark
                                ? Colors.grey[700]!
                                : Colors.grey[300]!,
                        width: 1.5,
                      ),
                    ),
                  ),
                  child: Center(
                    child: Image.asset(
                      "assets/images/piece/unknow_piece.png",
                      width: context.width(0.15),
                      color:
                          Theme.of(context).brightness == Brightness.dark
                              ? Colors.grey[600]
                              : Colors.grey[400],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
