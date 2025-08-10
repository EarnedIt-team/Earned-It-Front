import 'package:earned_it/config/design.dart';
import 'package:earned_it/models/piece/theme_model.dart';
import 'package:earned_it/view_models/piece_provider.dart';
import 'package:earned_it/view_models/user_provider.dart';
import 'package:earned_it/views/navigation_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:toastification/toastification.dart';

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

    // 위젯이 처음 그려진 후, 퍼즐 데이터를 불러옵니다.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(pieceProvider.notifier).loadPuzzleList(context);
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
      floatingActionButton: AnimatedOpacity(
        opacity: _showFab ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 300),
        child: FloatingActionButton(
          onPressed: _scrollToTop,
          child: const Icon(Icons.arrow_upward),
        ),
      ),
      body:
          themes.isEmpty
              ? _buildEmptyState(context, ref) // 데이터가 없을 때 UI
              : _buildPuzzleContent(context, themes), // 데이터가 있을 때 UI
    );
  }

  // --- 1. 퍼즐 데이터가 있을 때의 전체 UI ---
  Widget _buildPuzzleContent(BuildContext context, List<ThemeModel> themes) {
    return SingleChildScrollView(
      controller: _scrollController,
      padding: EdgeInsets.symmetric(horizontal: context.middlePadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ListView.builder를 사용하여 각 테마를 순서대로 표시
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

  // --- 2. 각 테마 섹션 (헤더 + 그리드) ---
  Widget _buildThemeSection(BuildContext context, ThemeModel theme) {
    final currencyFormat = NumberFormat.decimalPattern('ko_KR');
    return Padding(
      padding: const EdgeInsets.only(top: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- 테마 헤더 ---
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                theme.themeName,
                style: TextStyle(
                  fontSize: context.height(0.025),
                  fontWeight: FontWeight.bold,
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
          // --- 퍼즐 조각 그리드 ---
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

  // --- 3. 각 퍼즐 조각 아이템 ---
  Widget _buildPuzzlePiece(BuildContext context, SlotModel slot) {
    return ElevatedButton(
      onPressed:
          slot.isCollected
              ? null
              : () {
                // TODO: 획득하지 않은 조각 탭 시 동작 구현
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
        // isCollected 여부와 image URL 유무에 따라 다른 위젯 표시
        child:
            slot.isCollected && slot.image != null && slot.image!.isNotEmpty
                ? ClipRRect(
                  borderRadius: BorderRadius.circular(10.5),
                  child: Image.network(
                    slot.image!,
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder:
                        (context, error, stackTrace) =>
                            const Icon(Icons.error_outline, color: Colors.grey),
                  ),
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

  // --- 4. 퍼즐 데이터가 없을 때의 UI ---
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
                ref.read(isOpenCheckedIn.notifier).state = true;
              } else {
                toastification.show(
                  context: context,
                  type: ToastificationType.error,
                  style: ToastificationStyle.flat,
                  title: const Text('출석 체크는 하루에 한번 가능합니다.'),
                  autoCloseDuration: const Duration(seconds: 3),
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
