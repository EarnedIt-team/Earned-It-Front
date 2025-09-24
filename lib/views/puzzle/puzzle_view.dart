import 'package:earned_it/config/design.dart';
import 'package:earned_it/config/toastMessage.dart';
import 'package:earned_it/models/piece/theme_model.dart';
import 'package:earned_it/view_models/piece_provider.dart';
import 'package:earned_it/view_models/user/user_provider.dart';
import 'package:earned_it/views/navigation_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcaseview.dart';

// 1. (핵심 수정) ShowCaseWidget을 제공하는 새로운 최상위 위젯
class PuzzleView extends StatelessWidget {
  const PuzzleView({super.key});

  @override
  Widget build(BuildContext context) {
    // ShowCaseWidget이 _PuzzleViewInternal의 조상이 되도록 감싸줍니다.
    return ShowCaseWidget(
      onFinish: () async {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('hasSeenPuzzleShowcase', true);
      },
      builder: (context) => const _PuzzleViewInternal(),
    );
  }
}

// 2. 기존 PuzzleView의 내용을 내부 위젯으로 변경
class _PuzzleViewInternal extends ConsumerStatefulWidget {
  const _PuzzleViewInternal();

  @override
  ConsumerState<_PuzzleViewInternal> createState() => _PuzzleViewState();
}

class _PuzzleViewState extends ConsumerState<_PuzzleViewInternal> {
  late final ScrollController _scrollController;
  bool _showFab = false;

  final GlobalKey _one = GlobalKey();
  final GlobalKey _two = GlobalKey();
  final GlobalKey _three = GlobalKey();

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(pieceProvider.notifier).loadPuzzle(context).then((_) {
        _checkAndShowShowcase(); // 최초 가이드라인 실행
      });
    });
  }

  Future<void> _checkAndShowShowcase() async {
    final prefs = await SharedPreferences.getInstance();
    // 'hasSeenPuzzleShowcase' 값이 false이거나 없을 때만 쇼케이스를 시작합니다.
    final hasSeen = prefs.getBool('hasSeenPuzzleShowcase') ?? false;

    if (!hasSeen && mounted) {
      ShowCaseWidget.of(context).startShowCase([_one, _two, _three]);
    }
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

    return Scaffold(
      appBar: _buildAppBar(context, ref),
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

  AppBar _buildAppBar(BuildContext context, WidgetRef ref) {
    final pieceState = ref.watch(pieceProvider);
    return AppBar(
      scrolledUnderElevation: 0,
      title: const Row(
        children: <Widget>[
          Icon(Icons.extension),
          SizedBox(width: 10),
          Text("퍼즐", style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
      centerTitle: false,
      actions: <Widget>[
        Showcase(
          targetBorderRadius: BorderRadius.all(
            Radius.circular(context.width(0.05)),
          ),
          tooltipPosition: TooltipPosition.bottom,
          overlayColor:
              Theme.of(context).brightness == Brightness.dark
                  ? const Color.fromARGB(255, 46, 46, 46)
                  : Colors.grey,
          targetPadding: EdgeInsets.all(context.middlePadding / 2),
          key: _three,
          description: '기준에 따라 획득한 점수로 등수를 매깁니다.\n해당 페이지에서, 다른 사람들과 비교해보세요!',
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: context.middlePadding),
              shadowColor: Colors.transparent,
              elevation: 0,
              backgroundColor:
                  Theme.of(context).brightness == Brightness.dark
                      ? Colors.black
                      : Colors.white,
              side: const BorderSide(width: 1, color: primaryGradientStart),
            ),
            onPressed: () {
              context.push('/rank');
            },
            child: Row(
              spacing: 5,
              children: [
                Icon(
                  Icons.leaderboard,
                  size: context.width(0.04),
                  color: primaryGradientStart,
                ),
                Text(
                  "랭킹",
                  style: TextStyle(
                    fontSize: context.width(0.035),
                    color: primaryGradientStart,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
      actionsPadding: EdgeInsets.symmetric(horizontal: context.middlePadding),
    );
  }

  Widget _buildPuzzleContent(
    BuildContext context,
    WidgetRef ref,
    List<ThemeModel> themes,
  ) {
    final pieceState = ref.watch(pieceProvider);
    final currencyFormat = NumberFormat.decimalPattern('ko_KR');
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
          Row(
            children: [
              Text(
                '현재 가치',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: context.height(0.02),
                  color:
                      Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
                ),
              ),
              const SizedBox(width: 3),
              Tooltip(
                showDuration: const Duration(seconds: 5),
                triggerMode: TooltipTriggerMode.tap,
                message:
                    '획득한 모든 퍼즐 조각의 가치를 합산한 점수입니다.\n*같은 조각을 여러 번 획득해도 금액은 한 번만 계산됩니다.',
                child: Icon(
                  Icons.info_outline,
                  size: context.width(0.04),
                  color: Colors.blue,
                ),
              ),
              const Spacer(),
              Text(
                '${currencyFormat.format(pieceState.totalAccumulatedValue)} 원',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: context.height(0.02),
                  color:
                      Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
                ),
              ),
            ],
          ),
          SizedBox(height: context.height(0.03)),
          Showcase(
            targetBorderRadius: BorderRadius.all(
              Radius.circular(context.width(0.05)),
            ),
            overlayColor:
                Theme.of(context).brightness == Brightness.dark
                    ? const Color.fromARGB(255, 46, 46, 46)
                    : Colors.grey,
            targetPadding: EdgeInsets.all(context.middlePadding / 2),
            key: _one,
            description: '테마와 조각의 전체 진행률을 확인할 수 있습니다.',
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              spacing: context.width(0.03),
              children: [
                Column(
                  children: <Widget>[
                    _buildProgressCircle(
                      context: context,
                      title: "순위",
                      value: 1,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "상위 ${(pieceState.userRank / pieceState.userCount * 100).toStringAsFixed(2)}%",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: context.width(0.04),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    _buildProgressCircle(
                      context: context,
                      title: "테마",
                      value: themeProgress,
                    ),
                    const SizedBox(height: 10),
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
                  children: [
                    _buildProgressCircle(
                      context: context,
                      title: "조각",
                      value: pieceProgress,
                    ),
                    const SizedBox(height: 10),
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
          ),
          SizedBox(height: context.height(0.03)),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: themes.length,
            itemBuilder: (context, index) {
              final theme = themes[index];
              if (index == 0) {
                return Showcase(
                  targetBorderRadius: BorderRadius.all(
                    Radius.circular(context.width(0.05)),
                  ),
                  tooltipPosition: TooltipPosition.top,
                  overlayColor:
                      Theme.of(context).brightness == Brightness.dark
                          ? const Color.fromARGB(255, 46, 46, 46)
                          : Colors.grey,
                  targetPadding: EdgeInsets.all(context.middlePadding / 2),
                  key: _two,
                  description: '각 테마마다 조각이 존재하며,\n획득한 조각은 클릭하면 상세정보로 이동합니다.',
                  child: _buildThemeSection(context, theme),
                );
              }
              return _buildThemeSection(context, theme);
            },
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildProgressCircle({
    required BuildContext context,
    required String title,
    required double value,
  }) {
    final pieceState = ref.watch(pieceProvider);
    final rankValue =
        pieceState.userCount > 0
            ? (pieceState.userCount - pieceState.userRank + 1) /
                pieceState.userCount
            : 0.0;
    return SizedBox(
      width: context.width(0.25),
      height: context.width(0.25),
      child: Stack(
        fit: StackFit.expand,
        children: [
          CircularProgressIndicator(
            value: 1.0,
            strokeWidth: context.width(0.01),
            backgroundColor:
                Theme.of(context).brightness == Brightness.dark
                    ? Colors.grey[800]
                    : Colors.grey[200],
            color: Colors.transparent,
          ),
          CircularProgressIndicator(
            value: title == "순위" ? rankValue : value,
            strokeWidth: context.width(0.02),
            valueColor: const AlwaysStoppedAnimation<Color>(
              primaryGradientStart,
            ),
            strokeCap: StrokeCap.round,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: context.width(0.025)),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: context.width(0.035),
                      color: Colors.grey,
                    ),
                  ),
                  Tooltip(
                    showDuration: const Duration(seconds: 5),
                    triggerMode: TooltipTriggerMode.tap,
                    message:
                        title == "순위"
                            ? '테마 + 조각 + 현재 가치의 점수를 종합하여\n결정된 순위입니다.\n\n*매 정각마다 갱신됩니다.'
                            : title == "테마"
                            ? '각 테마의 퍼즐을 모두 획득하면\n완성한 테마로 기록됩니다.'
                            : '출석체크와 같은 활동으로 획득한\n전체 퍼즐 조각의 수입니다.',
                    child: Icon(
                      Icons.info_outline,
                      size: context.width(0.04),
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
              Text(
                title == "순위"
                    ? '${pieceState.userRank}등'
                    : '${(value * 100).toStringAsFixed(0)}%',
                style: TextStyle(
                  fontSize: context.width(0.055),
                  fontWeight: FontWeight.bold,
                  color:
                      Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildThemeSection(BuildContext context, ThemeModel theme) {
    final currencyFormat = NumberFormat.decimalPattern('ko_KR');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: context.height(0.025)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            theme.totalCount == theme.collectedCount
                ? Row(
                  spacing: 5,
                  children: [
                    const Icon(Icons.check, color: Colors.green),
                    Text(
                      theme.themeName,
                      style: TextStyle(
                        fontSize: context.height(0.02),
                        fontWeight: FontWeight.bold,
                        color:
                            Theme.of(context).brightness == Brightness.dark
                                ? Colors.white
                                : Colors.black,
                      ),
                    ),
                  ],
                )
                : Text(
                  theme.themeName,
                  style: TextStyle(
                    fontSize: context.height(0.02),
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
        SizedBox(height: context.height(0.025)),
      ],
    );
  }

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
                ? lightDarkColor
                : Colors.white,
        padding: EdgeInsets.zero,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color:
                slot.isCollected
                    ? (Theme.of(context).brightness == Brightness.dark
                        ? primaryGradientEnd
                        : const Color.fromARGB(255, 255, 164, 176))
                    : (Theme.of(context).brightness == Brightness.dark
                        ? Colors.grey[700]!
                        : Colors.grey[300]!),
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
                        width: context.width(0.25),
                        height: context.width(0.25),
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
                        top: 0,
                        left: 0,
                        child: Container(
                          padding: const EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: const Color.fromARGB(255, 44, 102, 46),
                            ),
                            color: Colors.green,
                            shape: BoxShape.circle,
                          ),
                          child: Image.asset(
                            'assets/images/keep_icon.png',
                            color: Colors.black,
                            width: context.width(0.04),
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
          if (userState.isLogin == true)
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
            )
          else
            Text(
              "- 로그인이 필요한 서비스 입니다 -",
              style: TextStyle(
                fontSize: context.width(0.035),
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
        ],
      ),
    );
  }
}
