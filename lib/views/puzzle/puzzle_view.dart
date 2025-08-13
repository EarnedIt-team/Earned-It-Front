import 'package:earned_it/config/design.dart';
import 'package:earned_it/config/toastMessage.dart';
import 'package:earned_it/models/piece/theme_model.dart';
import 'package:earned_it/view_models/piece_provider.dart';
import 'package:earned_it/view_models/user_provider.dart';
import 'package:earned_it/views/navigation_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class PuzzleView extends ConsumerStatefulWidget {
  const PuzzleView({super.key});

  @override
  ConsumerState<PuzzleView> createState() => _PuzzleViewState();
}

class _PuzzleViewState extends ConsumerState<PuzzleView> {
  late final ScrollController _scrollController;
  bool _showFab = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(pieceProvider.notifier).loadPuzzle(context);
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.offset >= 200 && !_showFab) {
      setState(() => _showFab = true);
    } else if (_scrollController.offset < 200 && _showFab) {
      setState(() => _showFab = false);
    }
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final pieceState = ref.watch(pieceProvider);
    final themes = pieceState.pieces;
    final currencyFormat = NumberFormat.decimalPattern('ko_KR');

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
        actions: [
          Text(
            '현재 가치 : ${currencyFormat.format(pieceState.totalAccumulatedValue)} 원',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: context.width(0.04),
            ),
          ),
        ],
        actionsPadding: EdgeInsets.symmetric(horizontal: context.middlePadding),
      ),
      floatingActionButton: AnimatedOpacity(
        opacity: _showFab ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 300),
        child: FloatingActionButton(
          backgroundColor: primaryGradientEnd,
          onPressed: _scrollToTop,
          child: const Icon(Icons.arrow_upward),
        ),
      ),
      body:
          themes.isEmpty && !pieceState.isLoading
              ? _buildEmptyState(context, ref)
              : _buildPuzzleContent(context, ref, themes),
    );
  }

  // --- 1. 퍼즐 데이터가 있을 때의 전체 UI ---
  Widget _buildPuzzleContent(
    BuildContext context,
    WidgetRef ref,
    List<ThemeModel> themes,
  ) {
    final pieceState = ref.watch(pieceProvider);

    // --- 진행률 계산 ---
    final double themeProgress =
        (pieceState.themeCount > 0)
            ? pieceState.completedThemeCount / pieceState.themeCount
            : 0.0;
    final double pieceProgress =
        (pieceState.totalPieceCount > 0)
            ? pieceState.completedPieceCount / pieceState.totalPieceCount
            : 0.0;

    return SingleChildScrollView(
      controller: _scrollController,
      padding: EdgeInsets.symmetric(
        horizontal: context.middlePadding,
        vertical: context.middlePadding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 👇 (핵심 수정) 기존 Text 위젯들을 원형 진행바로 교체
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                spacing: 10,
                children: <Widget>[
                  _buildProgressCircle(
                    context: context,
                    title: "테마",
                    value: themeProgress,
                  ),
                  Text(
                    "${pieceState.completedThemeCount} / ${pieceState.themeCount}",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: context.width(0.04),
                    ),
                  ),
                ],
              ),
              Column(
                spacing: 10,
                children: [
                  _buildProgressCircle(
                    context: context,
                    title: "조각",
                    value: pieceProgress,
                  ),
                  Text(
                    "${pieceState.completedPieceCount} / ${pieceState.totalPieceCount}",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: context.width(0.04),
                    ),
                  ),
                ],
              ),
            ],
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: themes.length,
            itemBuilder: (context, index) {
              final theme = themes[index];
              return _buildThemeSection(context, theme);
            },
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  // --- 2. 원형 진행바 위젯 (신규 추가) ---
  Widget _buildProgressCircle({
    required BuildContext context,
    required String title,
    required double value, // 0.0 ~ 1.0
  }) {
    return SizedBox(
      width: context.width(0.25),
      height: context.width(0.25),
      child: Stack(
        fit: StackFit.expand,
        children: [
          // 배경 트랙
          CircularProgressIndicator(
            value: 1.0,
            strokeWidth: context.width(0.01),
            backgroundColor:
                Theme.of(context).brightness == Brightness.dark
                    ? Colors.grey[800]
                    : Colors.grey[200],
            color: Colors.transparent,
          ),
          // 실제 진행률
          CircularProgressIndicator(
            value: value,
            strokeWidth: context.width(0.02),
            valueColor: const AlwaysStoppedAnimation<Color>(
              primaryGradientStart,
            ),
            strokeCap: StrokeCap.round, // 끝을 둥글게
          ),
          // 중앙 텍스트
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: context.width(0.035),
                    color: Colors.grey,
                  ),
                ),
                Text(
                  '${(value * 100).toStringAsFixed(0)}%',
                  style: TextStyle(
                    fontSize: context.width(0.065),
                    fontWeight: FontWeight.bold,
                    color:
                        Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- 3. 각 테마 섹션 (헤더 + 그리드) ---
  Widget _buildThemeSection(BuildContext context, ThemeModel theme) {
    final currencyFormat = NumberFormat.decimalPattern('ko_KR');
    return Padding(
      padding: const EdgeInsets.only(top: 32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                theme.themeName,
                style: TextStyle(
                  fontSize: context.width(0.045),
                  fontWeight: FontWeight.bold,
                  color:
                      Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
                ),
              ),
              Text(
                theme.totalValue == 0
                    ? "??? 원"
                    : "${currencyFormat.format(theme.totalValue)} 원",
                style: TextStyle(
                  fontSize: context.height(0.018),
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: theme.slots.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {
              final slot = theme.slots[index];
              return _buildPuzzlePiece(context, slot);
            },
          ),
        ],
      ),
    );
  }

  // --- 4. 각 퍼즐 조각 아이템 ---
  Widget _buildPuzzlePiece(BuildContext context, SlotModel slot) {
    return ElevatedButton(
      onPressed:
          slot.isCollected
              ? () => ref
                  .read(pieceProvider.notifier)
                  .loadPieceInfo(context, slot.pieceId!)
              : null,
      style: ElevatedButton.styleFrom(
        backgroundColor:
            Theme.of(context).brightness == Brightness.dark
                ? Colors.grey[800]
                : lightColor,
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
        child:
            slot.isCollected && slot.image != null && slot.image!.isNotEmpty
                ? Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.5),
                      child: Image.network(
                        slot.image!,
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.contain,
                        errorBuilder:
                            (context, error, stackTrace) => const Icon(
                              Icons.error_outline,
                              color: Colors.grey,
                            ),
                      ),
                    ),
                    if (slot.mainPiece!)
                      Positioned(
                        top: 5,
                        left: 5,
                        child: Container(
                          padding: const EdgeInsets.all(5.0), // 원 안의 이미지 여백
                          decoration: const BoxDecoration(
                            color: primaryGradientStart, // 원형 배경색
                            shape: BoxShape.circle, // 모양을 원으로 지정
                          ),
                          child: Image.asset(
                            'assets/images/keep_icon.png',
                            color: Colors.black,
                            width: context.width(0.04), // 아이콘 이미지 크기
                            height: context.width(0.04),
                          ),
                        ),
                      ),
                  ],
                )
                : Image.asset(
                  "assets/images/piece/unknow_piece.png",
                  width: context.width(0.15),
                  color:
                      Theme.of(context).brightness == Brightness.dark
                          ? Colors.grey[600]
                          : Colors.grey[400],
                ),
      ),
    );
  }

  // --- 5. 퍼즐 데이터가 없을 때의 UI ---
  Widget _buildEmptyState(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(userProvider);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Lottie.asset(
            'assets/lottie/empty_piece.json',
            filterQuality: FilterQuality.high,
            width: context.width(0.4),
            height: context.width(0.4),
            fit: BoxFit.contain,
          ),
          SizedBox(height: context.height(0.03)),
          Text(
            "출석해서 첫번째 조각을 획득해보세요.",
            style: TextStyle(
              color: Colors.grey,
              fontSize: context.regularFont,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: context.height(0.02)),
          ElevatedButton(
            onPressed: () {
              if (!userState.isCheckedIn) {
                ref.read(isOpenPieceInfo.notifier).state = true;
              } else {
                toastMessage(
                  context,
                  '출석 체크는 하루에 한번 가능합니다.',
                  type: ToastmessageType.errorType,
                );
              }
            },
            child: const Text("출석체크하기"),
          ),
        ],
      ),
    );
  }
}
