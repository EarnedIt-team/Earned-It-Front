import 'package:earned_it/models/wish/wish_add_state.dart';
import 'package:earned_it/models/wish/wish_model.dart';
import 'package:earned_it/view_models/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

// 2. 로직을 처리하는 Notifier(ViewModel) 클래스
class WishAddViewModel extends AutoDisposeNotifier<WishAddState> {
  // UI에서 사용할 컨트롤러들을 Notifier가 관리
  late final TextEditingController nameController;
  late final TextEditingController vendorController;
  late final TextEditingController priceController;
  late final TextEditingController urlController;
  final ImagePicker _picker = ImagePicker();

  @override
  WishAddState build() {
    // 컨트롤러 초기화
    nameController = TextEditingController();
    vendorController = TextEditingController();
    priceController = TextEditingController();
    urlController = TextEditingController();

    // 특정 컨트롤러의 텍스트 변경을 감지하여 버튼 활성화 상태 업데이트
    nameController.addListener(_updateCanSubmit);
    priceController.addListener(_updateCanSubmit);

    // Notifier가 소멸될 때 컨트롤러도 함께 해제
    ref.onDispose(() {
      nameController.removeListener(_updateCanSubmit);
      priceController.removeListener(_updateCanSubmit);
      nameController.dispose();
      vendorController.dispose();
      priceController.dispose();
      urlController.dispose();
    });

    return const WishAddState();
  }

  // 버튼 활성화 여부를 업데이트하는 내부 함수
  void _updateCanSubmit() {
    final canSubmit =
        nameController.text.isNotEmpty && priceController.text.isNotEmpty;
    state = state.copyWith(canSubmit: canSubmit);
  }

  // 이미지 선택 로직
  Future<void> pickImage() async {
    try {
      final pickedImage = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        state = state.copyWith(itemImage: pickedImage);
      }
    } catch (e) {
      debugPrint('Image picking error: $e');
    }
  }

  // TOP5 체크박스 토글 로직
  void toggleIsTop5(bool? value) {
    state = state.copyWith(isTop5: value ?? false);
  }

  // 위시리스트 추가 로직
  void addDummyWishlist() {
    final dummyData = [
      const WishModel(
        name: '2020년형 MacBook Pro 13.3인치 256GB',
        vendor: 'APPLE',
        price: 1678530,
        itemImage: 'macbook',
        url: 'https://ko.aliexpress.com/item/1005005626333589.html',
      ),
      const WishModel(
        name: '아이폰 15 Pro 256GB',
        vendor: 'APPLE',
        price: 1298000,
        itemImage: 'iphone',
        url: 'https://www.coupang.com/vp/products/7630888734',
      ),
      const WishModel(
        name: '닌텐도 스위치 OLED',
        vendor: 'NINTENDO',
        price: 377470,
        itemImage: 'switch',
        url: 'https://prod.danawa.com/info/?pcode=14678627',
      ),
    ];

    final currentWishes = ref.read(userProvider).totalWishes;
    final updatedWishes = [...currentWishes, ...dummyData];

    ref.read(userProvider.notifier).updateTotalWishes(updatedWishes);
  }
}

// 3. Provider 정의
final wishAddViewModelProvider =
    NotifierProvider.autoDispose<WishAddViewModel, WishAddState>(
      WishAddViewModel.new,
    );
