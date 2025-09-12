import 'package:earned_it/models/user/profile_user_model.dart';
import 'package:earned_it/models/user/simple_user_model.dart';
import 'package:earned_it/view_models/home_provider.dart';
import 'package:earned_it/view_models/user/profile_provider.dart';
import 'package:earned_it/view_models/user/user_provider.dart';
import 'package:earned_it/view_models/wish/wish_order_provider.dart';
import 'package:earned_it/view_models/wish/wish_provider.dart';
import 'dart:math';
import 'package:animated_digit/animated_digit.dart';
import 'package:earned_it/config/design.dart';
import 'package:earned_it/models/wish/wish_model.dart';
import 'package:earned_it/views/navigation_view.dart';
import 'package:earned_it/views/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcaseview.dart';

// 1. (핵심 수정) ShowCaseWidget을 제공하는 새로운 최상위 위젯
class WishView extends StatelessWidget {
  const WishView({super.key});

  @override
  Widget build(BuildContext context) {
    // ShowCaseWidget이 _WishViewInternal의 조상이 되도록 감싸줍니다.
    return ShowCaseWidget(
      onFinish: () async {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('hasSeenWishViewShowcase', true);
      },
      builder: (context) => const _WishViewInternal(),
    );
  }
}

// 2. 기존 WishView의 내용을 내부 위젯으로 변경
class _WishViewInternal extends ConsumerStatefulWidget {
  const _WishViewInternal();

  @override
  ConsumerState<_WishViewInternal> createState() => _WishViewState();
}

class _WishViewState extends ConsumerState<_WishViewInternal> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _one = GlobalKey();
  final GlobalKey _two = GlobalKey();
  final GlobalKey _three = GlobalKey();
  final GlobalKey _four = GlobalKey();

  // 현재 선택된 유저 ID를 저장하는 상태 변수. null이면 '내 정보'
  int? _selectedUserId;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref
          .read(wishViewModelProvider.notifier)
          .loadMainWishList(userCount: 5);

      _checkAndShowShowcase();
    });
  }

  // 2. 쇼케이스를 보여줄지 확인하고 실행하는 함수
  Future<void> _checkAndShowShowcase() async {
    final prefs = await SharedPreferences.getInstance();
    final hasSeen = prefs.getBool('hasSeenWishViewShowcase') ?? false;
    final wishState = ref.read(wishViewModelProvider);

    // 조건: 가이드를 본 적이 없고, 리스트 중 하나라도 비어있지 않을 때
    if (!hasSeen &&
        (wishState.starWishes.isNotEmpty || wishState.Wishes3.isNotEmpty) &&
        mounted) {
      ShowCaseWidget.of(context).startShowCase([_one, _three]);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // 사용자 탭 이벤트를 처리하는 함수
  void _handleUserTap(int? userId) {
    // userId가 null이면 '내 정보'를 탭한 것이므로 아무것도 하지 않고 종료
    if (userId == null) {
      print("내 프로필 탭");
      return;
    }

    // 다른 사용자를 탭한 경우, go_router를 사용해 프로필 페이지로 이동
    // isPublic 값은 현재 데이터 모델에 없으므로, 'true'로 가정하여 전달합니다.
    const bool isPublic = true;
    context.push('/profile/$userId?isPublic=$isPublic');
  }

  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(userProvider);
    final wishState = ref.watch(wishViewModelProvider);
    final starWishList = wishState.starWishes;
    final HighLightWishList = wishState.Wishes3;
    final userInfo = wishState.userInfo; // 내 정보
    final userList = wishState.userList; // 타 사용자 정보
    final isMyProfileSelected = _selectedUserId == null; // 내 거를 선택했는가?
    final currencyFormat = NumberFormat.decimalPattern('ko_KR');

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Stack(
        children: <Widget>[
          Scaffold(
            backgroundColor:
                Theme.of(context).brightness == Brightness.dark
                    ? Colors.black
                    : lightColor2,
            appBar: AppBar(
              backgroundColor:
                  Theme.of(context).brightness == Brightness.dark
                      ? Colors.black
                      : lightColor2,
              scrolledUnderElevation: 0,
              title: const Row(
                children: <Widget>[
                  Icon(Icons.local_mall),
                  SizedBox(width: 10),
                  Text("위시리스트", style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
              centerTitle: false,
              actions:
                  starWishList.isNotEmpty || HighLightWishList.isNotEmpty
                      ? <Widget>[
                        Showcase(
                          targetBorderRadius: BorderRadius.all(
                            Radius.circular(context.width(0.05)),
                          ),
                          overlayColor:
                              Theme.of(context).brightness == Brightness.dark
                                  ? const Color.fromARGB(255, 46, 46, 46)
                                  : Colors.grey,
                          key: _one,
                          description:
                              'Star 위시리스트 순서를 변경하거나,\n위시 아이템을 추가할 수 있습니다.',
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  ref
                                      .read(wishOrderViewModelProvider.notifier)
                                      .initialize(wishState.starWishes);
                                  ref.read(isOpenSwapList.notifier).state =
                                      true;
                                },
                                icon: const Icon(Icons.reorder),
                              ),
                              IconButton(
                                onPressed: () {
                                  context.push('/addWish');
                                },
                                icon: const Icon(Icons.add),
                              ),
                            ],
                          ),
                        ),
                      ]
                      : null,
              actionsPadding: EdgeInsets.symmetric(
                horizontal: context.middlePadding / 2,
              ),
            ),
            body:
                // --- 리스트가 모두 비어있을 때 ---
                starWishList.isEmpty && HighLightWishList.isEmpty
                    ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Lottie.asset(
                            'assets/lottie/check_wish.json',
                            filterQuality: FilterQuality.high,
                            width: context.width(0.4),
                            height: context.width(0.4),
                            fit: BoxFit.contain,
                          ),
                          SizedBox(height: context.height(0.03)),
                          Text(
                            "나만의 위시리스트를 등록하세요.",
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
                                context.push('/addWish');
                              },
                              child: const Text("위시리스트 추가"),
                            )
                          else
                            Text(
                              "- 로그인이 필요한 서비스 입니다 -",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: context.width(0.035),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                        ],
                      ),
                    )
                    : SingleChildScrollView(
                      controller: _scrollController,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          if (userInfo != null)
                            // 타 사용자 리스트
                            _UserStoryList(
                              userInfo: userInfo,
                              userList: userList,
                              selectedUserId: _selectedUserId,
                              onUserTap: _handleUserTap,
                            ),

                          if (starWishList.isNotEmpty)
                            _StarWishlistSection(starWishList: starWishList),

                          // --- All 위시리스트 섹션 ---
                          if (HighLightWishList.isNotEmpty)
                            Padding(
                              padding: EdgeInsets.only(
                                top: context.middlePadding / 2,
                                left: context.middlePadding / 2,
                                right: context.middlePadding / 2,
                                bottom: context.middlePadding / 2,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1,
                                    color:
                                        Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? Colors.white
                                            : const Color.fromARGB(
                                              255,
                                              178,
                                              178,
                                              178,
                                            ),
                                  ),
                                  color:
                                      Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? lightDarkColor
                                          : Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                padding: EdgeInsets.only(
                                  top: context.middlePadding / 2,
                                  left: context.middlePadding,
                                  right: context.middlePadding,
                                  bottom: context.middlePadding / 2,
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.baseline,
                                      textBaseline: TextBaseline.alphabetic,
                                      children: [
                                        Text(
                                          "ALL",
                                          style: TextStyle(
                                            color:
                                                Theme.of(context).brightness ==
                                                        Brightness.dark
                                                    ? Colors.white
                                                    : Colors.black,
                                            fontSize: context.width(0.07),
                                            fontWeight: FontWeight.w500,
                                            height: 1.0,
                                          ),
                                        ),
                                        Text(
                                          " (${wishState.currentWishCount}/100)",
                                          style: TextStyle(
                                            color:
                                                Theme.of(context).brightness ==
                                                        Brightness.dark
                                                    ? Colors.white
                                                    : Colors.black,
                                            fontSize: context.width(0.035),
                                            fontWeight: FontWeight.w600,
                                            height: 1.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                    TextButton(
                                      style: TextButton.styleFrom(
                                        padding: EdgeInsets.zero,
                                        minimumSize: Size.zero,
                                        tapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                      ),
                                      onPressed: () {
                                        context.push('/wishALL');
                                      },
                                      child: const Text(
                                        "더보기",
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                          // --- All 위시리스트 목록 ---
                          if (HighLightWishList.isNotEmpty)
                            Showcase(
                              targetBorderRadius: BorderRadius.all(
                                Radius.circular(context.width(0.05)),
                              ),
                              overlayColor:
                                  Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? const Color.fromARGB(255, 46, 46, 46)
                                      : Colors.grey,
                              key: _three,
                              tooltipPosition: TooltipPosition.top,
                              description:
                                  '해당 아이템의 정보를 확인할 수 있습니다.\n\n• 스와이프: Star 여부, 구매 여부, 수정, 삭제\n  (스와이프는 ALL에서 동작하지 않습니다.)\n• 터치 시: 위시아이템 상세 정보',
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: HighLightWishList.length,
                                itemBuilder: (context, index) {
                                  final item = HighLightWishList[index];
                                  return _WishlistItem(
                                    item: item,
                                    itemIndex: index,
                                    isStar: false,
                                  );
                                },
                              ),
                            ),
                          SizedBox(height: context.height(0.05)),
                        ],
                      ),
                    ),
          ),
        ],
      ),
    );
  }
}

/// 인스타 스토리 형태의 전체 가로 목록을 만드는 위젯
class _UserStoryList extends StatelessWidget {
  final ProfileUserModel userInfo;
  final List<SimpleUserModel> userList;
  final int? selectedUserId;
  final Function(int?) onUserTap;

  const _UserStoryList({
    required this.userInfo,
    required this.userList,
    this.selectedUserId,
    required this.onUserTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: context.middlePadding / 2,
            ),
            child: _StoryCircleItem(
              nickname: userInfo.nickname,
              profileImageUrl: userInfo.profileImage,
              isSelected: selectedUserId == null,
              onTap: () => onUserTap(null),
            ),
          ),
          const VerticalDivider(width: 1, thickness: 1),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(
                horizontal: context.middlePadding / 2,
              ),
              scrollDirection: Axis.horizontal,
              itemCount: userList.length,
              itemBuilder: (context, index) {
                final user = userList[index];
                return _StoryCircleItem(
                  nickname: user.nickname,
                  profileImageUrl: user.profileImage,
                  isSelected: selectedUserId == user.userId,
                  onTap: () => onUserTap(user.userId),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// 프로필 사진과 닉네임을 보여주는 개별 아이템 위젯
class _StoryCircleItem extends StatelessWidget {
  final String? profileImageUrl;
  final String nickname;
  final bool isSelected;
  final VoidCallback onTap;

  const _StoryCircleItem({
    this.profileImageUrl,
    required this.nickname,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final displayedName =
        nickname.length > 5 ? '${nickname.substring(0, 5)}...' : nickname;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: SizedBox(
          width: 70,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(2.0),
                decoration: BoxDecoration(
                  color: isSelected ? primaryColor : Colors.transparent,
                  shape: BoxShape.circle,
                ),
                child: CircleAvatar(
                  radius: context.width(0.08),
                  backgroundColor: Colors.grey.shade300,
                  backgroundImage:
                      profileImageUrl != null
                          ? NetworkImage(profileImageUrl!)
                          : null,
                  child:
                      profileImageUrl == null
                          ? Icon(
                            Icons.person,
                            size: context.width(0.08),
                            color: Colors.grey.shade600,
                          )
                          : null,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                displayedName,
                style: const TextStyle(fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Star 위시리스트의 헤더와 목록을 모두 포함하는 섹션 위젯
class _StarWishlistSection extends ConsumerWidget {
  // Star 위시리스트 데이터를 외부에서 전달받습니다.
  final List<dynamic> starWishList;

  const _StarWishlistSection({required this.starWishList});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ConsumerWidget이므로 ref를 직접 사용할 수 있습니다.
    final homeState = ref.watch(homeViewModelProvider);
    final currencyFormat = NumberFormat.decimalPattern('ko_KR');

    // 합계 금액 계산 로직
    final totalPrice = starWishList.fold<int>(
      0,
      // ✨ item.price를 int로 명시적으로 캐스팅합니다.
      (sum, item) => sum + (item.price as int),
    );
    final double totalDisplayAmount =
        (totalPrice > 0)
            ? min(homeState.currentEarnedAmount, totalPrice.toDouble())
            : homeState.currentEarnedAmount;

    // Column으로 헤더와 리스트를 묶어서 반환합니다.
    return Column(
      children: [
        // --- Star 위시리스트 헤더 ---
        Padding(
          padding: EdgeInsets.all(context.middlePadding / 2),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: primaryColor),
              color:
                  Theme.of(context).brightness == Brightness.dark
                      ? lightDarkColor
                      : Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            padding: EdgeInsets.symmetric(
              vertical: context.middlePadding / 2,
              horizontal: context.middlePadding,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                // ... (기존 헤더의 왼쪽 Row UI)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Star",
                          style: TextStyle(
                            fontSize: context.width(0.07),
                            fontWeight: FontWeight.w500,
                            color: primaryColor,
                            height: 1.0,
                          ),
                        ),
                        Tooltip(
                          message: '메인 화면에 표시되는 최대 5개의 위시아이템입니다.\n\n...',
                          child: Icon(
                            Icons.info_outline,
                            size: context.width(0.04),
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 2),
                    Text(
                      " (${starWishList.length}/5)",
                      style: TextStyle(
                        fontSize: context.width(0.035),
                        fontWeight: FontWeight.w600,
                        height: 1.0,
                      ),
                    ),
                  ],
                ),
                // ... (기존 헤더의 오른쪽 Row UI)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    if (totalPrice > 0)
                      Text(
                        "${currencyFormat.format(totalPrice)} 원 / ",
                        style: TextStyle(
                          fontSize: context.width(0.03),
                          color: Colors.grey,
                          height: 1.5,
                        ),
                      ),
                    totalDisplayAmount >= totalPrice
                        ? Text(
                          "달성 완료",
                          style: TextStyle(
                            fontSize: context.width(0.045),
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                            height: 1.5,
                          ),
                        )
                        : Row(
                          children: [
                            AnimatedDigitWidget(
                              value: totalDisplayAmount.toInt(),
                              enableSeparator: true,
                              textStyle: TextStyle(
                                color:
                                    Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors.white
                                        : Colors.black,
                                fontSize: context.width(0.05),
                                height: 1.5,
                              ),
                            ),
                            Text(
                              " 원",
                              style: TextStyle(
                                fontSize: context.width(0.05),
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                  ],
                ),
              ],
            ),
          ),
        ),

        // --- Star 위시리스트 목록 ---
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: starWishList.length,
          itemBuilder: (context, index) {
            final item = starWishList[index];
            // TODO: item의 타입이 StarWishModel/WishModel 두 가지일 수 있으므로 타입 확인 및 분기 처리가 필요합니다.
            // 아래는 WishModel 기준의 예시입니다.
            if (item is WishModel) {
              return _WishlistItem(item: item, itemIndex: index, isStar: true);
            }
            // StarWishModel을 위한 별도 아이템 위젯 또는 임시 위젯
            return ListTile(title: Text(item.name));
          },
        ),
      ],
    );
  }
}

// 👇 3. 각 리스트 아이템을 별도의 ConsumerWidget으로 분리
class _WishlistItem extends ConsumerWidget {
  final WishModel item;
  final int itemIndex;
  final bool isStar;

  const _WishlistItem({
    super.key,
    required this.item,
    required this.itemIndex,
    required this.isStar,
  });

  // 진행률에 따라 색상을 반환하는 함수
  Color _getProgressColor(double progress) {
    if (progress >= 1.0) return Colors.green; // 100% 달성 시
    if (progress >= 0.8) return Colors.purple;
    if (progress >= 0.5) return Colors.blue;
    if (progress >= 0.3) return Colors.orange;
    return Colors.red;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currencyFormat = NumberFormat.decimalPattern('ko_KR');

    // 각 아이템의 진행률 계산 로직
    double calculateItemDisplayAmount() {
      final homeState = ref.watch(homeViewModelProvider);
      final starWishList = ref.read(wishViewModelProvider).starWishes;

      if (!isStar || starWishList.isEmpty) return 0.0;

      double moneyAvailableForItem = homeState.currentEarnedAmount;
      for (int i = 0; i < itemIndex; i++) {
        moneyAvailableForItem -= starWishList[i].price;
      }
      if (moneyAvailableForItem < 0) moneyAvailableForItem = 0;
      return min(moneyAvailableForItem, item.price.toDouble());
    }

    final itemDisplayAmount = calculateItemDisplayAmount();

    // 1. 진행률 계산 (0.0 ~ 1.0)
    // item.price가 0인 경우 0으로 나누는 오류를 방지합니다.
    final double progress =
        item.price > 0 ? (itemDisplayAmount / item.price) : 0.0;

    // 2. 진행률에 따른 색상 결정
    final progressColor = _getProgressColor(progress);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: context.middlePadding / 2),
      child: Card(
        color:
            Theme.of(context).brightness == Brightness.dark
                ? lightDarkColor
                : Colors.white,
        margin: EdgeInsets.symmetric(vertical: context.height(0.005)),
        elevation: 0,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Slidable(
            key: ValueKey(item.wishId),
            startActionPane:
                isStar
                    ? ActionPane(
                      motion: const DrawerMotion(),
                      extentRatio: 0.5,
                      children: <Widget>[
                        CustomSlidableAction(
                          onPressed: (context) {
                            ref
                                .read(wishViewModelProvider.notifier)
                                .editBoughtWishItem(context, item.wishId);
                          },
                          backgroundColor: primaryGradientStart,
                          // 👇 2. child 속성을 사용하여 위젯을 직접 구성합니다.
                          child: Icon(
                            item.bought
                                ? Icons.check
                                : Icons.shopping_cart_outlined,
                            size: context.width(0.08),
                            color: Colors.white,
                          ),
                        ),
                        CustomSlidableAction(
                          onPressed: (context) {
                            ref
                                .read(wishViewModelProvider.notifier)
                                .editStarWishItem(context, item.wishId);
                          },
                          backgroundColor: const Color.fromARGB(
                            255,
                            231,
                            127,
                            111,
                          ),
                          // 👇 2. child 속성을 사용하여 위젯을 직접 구성합니다.
                          child: Icon(
                            item.starred ? Icons.star : Icons.star_outline,
                            size: context.width(0.08),
                            color: Colors.white,
                          ),
                        ),
                      ],
                    )
                    : null,
            endActionPane:
                isStar
                    ? ActionPane(
                      motion: const DrawerMotion(),
                      extentRatio: 0.5,
                      children: <Widget>[
                        CustomSlidableAction(
                          onPressed:
                              (context) =>
                                  context.push('/editWish', extra: item),
                          backgroundColor: Colors.grey.shade600,
                          foregroundColor: Colors.white,
                          // 👇 2. child 속성을 사용하여 위젯을 직접 구성합니다.
                          child: Text(
                            "수정",
                            style: TextStyle(fontSize: context.width(0.04)),
                          ),
                        ),

                        CustomSlidableAction(
                          onPressed: (context) {
                            showDialog(
                              context: context,
                              builder:
                                  (ctx) => AlertDialog(
                                    title: const Text('삭제 확인'),
                                    content: Text(
                                      "'${item.name}' 항목을 정말로 삭제하시겠습니까?",
                                    ),
                                    actions: [
                                      TextButton(
                                        child: const Text('취소'),
                                        onPressed:
                                            () => Navigator.of(ctx).pop(),
                                      ),
                                      TextButton(
                                        child: const Text(
                                          '삭제',
                                          style: TextStyle(color: Colors.red),
                                        ),
                                        onPressed: () {
                                          ref
                                              .read(
                                                wishViewModelProvider.notifier,
                                              )
                                              .deleteWishItem(
                                                context,
                                                item.wishId,
                                              );
                                          Navigator.of(ctx).pop();
                                        },
                                      ),
                                    ],
                                  ),
                            );
                          },
                          backgroundColor: const Color(0xFFFE4A49),
                          foregroundColor: Colors.white,
                          // 👇 2. child 속성을 사용하여 위젯을 직접 구성합니다.
                          child: Text(
                            "삭제",
                            style: TextStyle(fontSize: context.width(0.04)),
                          ),
                        ),
                      ],
                    )
                    : null,
            child: InkWell(
              onTap: () {
                print(item.createdAt);
                context.push('/wishDetail', extra: item);
              },
              child: Container(
                padding: EdgeInsets.only(
                  left: item.bought || item.starred ? 0 : context.middlePadding,
                  right: context.middlePadding,
                ),
                constraints: BoxConstraints(minHeight: context.height(0.1)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(width: context.middlePadding / 4),
                    Container(
                      color: Colors.transparent,
                      height: context.height(0.08),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (item.starred)
                            Icon(
                              Icons.stars,
                              size: context.width(0.04),
                              color: Colors.amber,
                            ),
                          if (item.bought && item.starred)
                            SizedBox(height: context.height(0.01)),
                          if (item.bought)
                            Icon(
                              Icons.check_circle,
                              size: context.width(0.04),
                              color: Colors.lightBlue,
                            ),
                        ],
                      ),
                    ),
                    SizedBox(width: context.middlePadding / 4),
                    SizedBox(
                      width: context.height(0.08),
                      height: context.height(0.08),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(width: 1, color: Colors.grey),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            item.itemImage,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: Colors.grey.shade200,
                                child: const Icon(
                                  Icons.image_not_supported_outlined,
                                  color: Colors.grey,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),

                    SizedBox(width: context.width(0.03)),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(right: context.width(0.05)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Text(
                                  item.vendor,
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: context.width(0.032),
                                    height: 1,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),

                            Text(
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              item.name,
                              style: TextStyle(
                                color:
                                    Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors.white
                                        : const Color.fromARGB(255, 44, 44, 44),
                                fontWeight: FontWeight.w600,
                                fontSize: context.width(0.04),
                                height: 1.5,
                              ),
                            ),
                            const SizedBox(height: 5),
                            if (isStar)
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                textBaseline: TextBaseline.alphabetic,
                                children: [
                                  Text(
                                    '${currencyFormat.format(itemDisplayAmount.toInt())} 원',
                                    style: TextStyle(
                                      color: progressColor,
                                      fontWeight: FontWeight.w500,
                                      fontSize: context.width(0.04),
                                      height: 1.5,
                                    ),
                                  ),
                                  Text(
                                    ' / ${currencyFormat.format(item.price)} 원',
                                    style: TextStyle(
                                      fontSize: context.width(0.03),
                                      color: Colors.grey,
                                      height: 1.5,
                                    ),
                                  ),
                                ],
                              )
                            else
                              Text(
                                '${currencyFormat.format(item.price)} 원',
                                style: TextStyle(
                                  fontSize: context.width(0.04),
                                  color: Colors.grey,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                    if (isStar)
                      SizedBox(
                        width: context.width(0.1),
                        height: context.width(0.1),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            // 원형 진행률 표시기
                            CircularProgressIndicator(
                              value: progress, // 진행률 (0.0 ~ 1.0)
                              strokeWidth: context.width(0.007), // 선의 두께
                              backgroundColor: Colors.grey[300], // 배경색
                              valueColor: AlwaysStoppedAnimation<Color>(
                                progressColor,
                              ), // 진행 색상
                            ),
                            // 중앙에 진행률 텍스트 표시
                            Center(
                              child: Text(
                                '${(progress * 100).toInt()}',
                                style: TextStyle(
                                  fontSize: context.width(0.035),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
