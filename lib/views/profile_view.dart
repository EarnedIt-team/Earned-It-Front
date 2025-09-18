import 'package:earned_it/config/design.dart';
import 'package:earned_it/models/user/profile_user_model.dart';
import 'package:earned_it/models/wish/wish_model.dart';
import 'package:earned_it/view_models/user/profile_provider.dart';
import 'package:earned_it/views/report_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class ProfileView extends ConsumerStatefulWidget {
  final int userId;

  const ProfileView({super.key, required this.userId});

  @override
  ConsumerState<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends ConsumerState<ProfileView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(profileViewModelProvider(widget.userId).notifier)
          .loadProfileData(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final profileState = ref.watch(profileViewModelProvider(widget.userId));
    final userInfo = profileState.userInfo;

    if (profileState.isLoading && userInfo == null) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (userInfo == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('프로필 정보')),
        body: const Center(child: Text('프로필 정보를 불러오는데 실패했습니다.')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Text(
          '${userInfo.nickname}님의 프로필',
          style: TextStyle(
            fontSize: context.width(0.038),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
        actions: [
          FloatingActionButton.small(
            highlightElevation: 0,
            backgroundColor: Colors.transparent,
            elevation: 0,
            onPressed: () {
              showReportModal(context, userIdToReport: widget.userId);
            },
            child: Image.asset(
              'assets/images/siren_icon.png',
              color: Colors.red,
            ),
          ),
        ],
        actionsPadding: EdgeInsets.symmetric(horizontal: context.middlePadding),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.middlePadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            _buildProfileHeader(context, userInfo),
            const SizedBox(height: 30),
            Text(
              'StarWish',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: context.width(0.05),
                color: primaryColor,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child:
                  profileState.starList.isNotEmpty
                      ? _buildWishListView(profileState.starList)
                      : const _EmptyWishlistMessage(),
            ),
          ],
        ),
      ),
    );
  }

  // 상단 프로필 헤더 위젯
  Widget _buildProfileHeader(BuildContext context, ProfileUserModel userInfo) {
    final formattedSalary = NumberFormat(
      '#,###',
    ).format(userInfo.monthlySalary);
    final salaryPerSecond = (userInfo.monthlySalary / (30 * 24 * 60 * 60))
        .toStringAsFixed(2);

    return Row(
      children: [
        // ✨ 1. CircleAvatar를 InkWell로 감싸서 탭 가능하게 만듭니다.
        InkWell(
          // 이미지가 있을 때만 탭 이벤트를 활성화합니다.
          onTap:
              userInfo.profileImage != null
                  ? () => _showImageDialog(context, userInfo.profileImage!)
                  : null,
          customBorder: const CircleBorder(), // 탭 효과를 원형으로 만듭니다.
          child: CircleAvatar(
            backgroundColor: Colors.grey.shade300,
            radius: 45,
            backgroundImage:
                userInfo.profileImage != null
                    ? NetworkImage(userInfo.profileImage!)
                    : null,
            child:
                userInfo.profileImage == null
                    ? Icon(Icons.person, size: 45, color: Colors.grey.shade600)
                    : null,
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "월 급여",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text("$formattedSalary원"),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "초당 수익",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text("${userInfo.amountPerSec.toStringAsFixed(3)}원"),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// 찜 목록을 실제로 그려주는 ListView 위젯
Widget _buildWishListView(List<WishModel> starList) {
  return ListView.builder(
    padding: EdgeInsets.zero,
    itemCount: starList.length,
    itemBuilder: (context, index) {
      final item = starList[index];
      final formattedPrice = NumberFormat('#,###').format(item.price);

      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                _showImageDialog(context, item.itemImage);
              },
              child: Material(
                color: Colors.transparent,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    item.itemImage,
                    width: 90,
                    height: 90,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 90,
                        height: 90,
                        color: Colors.grey[200],
                        child: Icon(
                          Icons.image_not_supported,
                          color: Colors.grey[400],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.vendor,
                    style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${formattedPrice}원',
                    style: TextStyle(
                      fontSize: 15, // context.width(0.04)는 context가 없어서 상수로 변경
                      fontWeight: FontWeight.w500,
                      color: primaryGradientStart,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}

/// 이미지를 확대해서 보여주는 다이얼로그 함수
void _showImageDialog(BuildContext context, String imageUrl) {
  showDialog(
    context: context,
    barrierColor: Colors.black87,
    builder: (BuildContext context) {
      return Dialog(
        elevation: 0,
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(16),
        child: Stack(
          alignment: Alignment.center,
          children: [
            InteractiveViewer(
              panEnabled: true,
              minScale: 0.5,
              maxScale: 4.0,
              child: Image.network(
                imageUrl,
                fit: BoxFit.contain,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value:
                          loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                    ),
                  );
                },
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.white, size: 30),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
      );
    },
  );
}

/// 찜 목록이 비어있을 때 보여주는 안내 메시지 위젯
class _EmptyWishlistMessage extends StatelessWidget {
  const _EmptyWishlistMessage();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.local_mall, size: 50, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            "Star 위시리스트가 없습니다.",
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }
}
