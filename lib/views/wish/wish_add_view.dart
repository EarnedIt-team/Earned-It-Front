import 'dart:io';
import 'package:earned_it/config/design.dart';
import 'package:earned_it/models/wish/wish_search_state.dart';
import 'package:earned_it/services/wish_service.dart';
import 'package:earned_it/view_models/wish/wish_add_provider.dart';
import 'package:earned_it/view_models/wish/wish_provider.dart';
import 'package:earned_it/views/loading_overlay_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

// 커스텀 포맷터는 그대로 유지
class NumberInputFormatter extends TextInputFormatter {
  final NumberFormat _formatter = NumberFormat.decimalPattern('ko_KR');
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) return newValue.copyWith(text: '');
    final plainNumber = newValue.text.replaceAll(',', '');
    final number = int.tryParse(plainNumber) ?? 0;
    final formatted = _formatter.format(number);
    return newValue.copyWith(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

class WishAddView extends ConsumerWidget {
  const WishAddView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wishState = ref.watch(wishViewModelProvider);
    final wishAddState = ref.watch(wishAddViewModelProvider);
    final wishAddNotifier = ref.read(wishAddViewModelProvider.notifier);

    final priceText = wishAddNotifier.priceController.text;
    final priceValue = int.tryParse(priceText.replaceAll(',', '')) ?? 0;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Stack(
        children: [
          Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              scrolledUnderElevation: 0,
              title: const Text(
                "위시아이템 추가",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              centerTitle: false,
              actions: <Widget>[
                IconButton(
                  onPressed: () async {
                    // 1. '/simpleAddWish' 경로로 이동하고, ProductModel 타입의 결과를 기다립니다.
                    final result = await context.push<ProductModel>(
                      '/simpleAddWish',
                    );

                    // 2. 결과가 null이 아니고 (사용자가 상품을 선택했고),
                    //    현재 위젯이 화면에 아직 있다면 ViewModel 함수를 호출합니다.
                    if (result != null && context.mounted) {
                      ref
                          .read(wishAddViewModelProvider.notifier)
                          .populateFromProduct(result);
                    }
                  },
                  icon: const Icon(Icons.search),
                  tooltip: "간편 위시아이템 추가",
                ),
              ],
              actionsPadding: EdgeInsets.symmetric(
                horizontal: context.middlePadding / 2,
              ),
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: context.middlePadding),
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(vertical: context.middlePadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "이미지",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: context.width(0.04),
                        color:
                            Theme.of(context).brightness == Brightness.dark
                                ? Colors.white
                                : Colors.black,
                      ),
                    ),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: () => wishAddNotifier.pickImage(context),
                      child: AspectRatio(
                        aspectRatio: 16 / 9,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(
                              context,
                            ).colorScheme.secondary.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Theme.of(
                                context,
                              ).colorScheme.secondary.withValues(alpha: 0.3),
                            ),
                          ),
                          child:
                              wishAddState.itemImage != null
                                  ? ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.file(
                                      File(wishAddState.itemImage!.path),
                                      fit: BoxFit.contain,
                                    ),
                                  )
                                  : const Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.add_photo_alternate_outlined,
                                          size: 40,
                                          color: Colors.grey,
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          "탭하여 이미지 추가",
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                  ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      "이름",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: context.width(0.04),
                        color:
                            Theme.of(context).brightness == Brightness.dark
                                ? Colors.white
                                : Colors.black,
                      ),
                    ),
                    TextField(
                      maxLength: 50,
                      textAlign: TextAlign.end,
                      controller: wishAddNotifier.nameController,
                      decoration: const InputDecoration(
                        hintText: '제품명을 입력하세요.',
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      "금액",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: context.width(0.04),
                        color:
                            Theme.of(context).brightness == Brightness.dark
                                ? Colors.white
                                : Colors.black,
                      ),
                    ),
                    TextField(
                      maxLength: 20,
                      textAlign: TextAlign.end,
                      controller: wishAddNotifier.priceController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        NumberInputFormatter(),
                      ],
                      decoration: InputDecoration(
                        hintText: '제품 금액을 입력하세요.',
                        hintStyle: const TextStyle(color: Colors.grey),
                        suffixText:
                            wishAddNotifier.priceController.text.isNotEmpty
                                ? '원'
                                : null,
                        suffixStyle: TextStyle(
                          color:
                              Theme.of(context).brightness == Brightness.dark
                                  ? Colors.white
                                  : Colors.black,
                        ),
                        errorText:
                            wishAddNotifier.priceController.text.isNotEmpty &&
                                    !wishAddState.canSubmit
                                ? wishAddState.priceError
                                : null,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      "회사",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: context.width(0.04),
                        color:
                            Theme.of(context).brightness == Brightness.dark
                                ? Colors.white
                                : Colors.black,
                      ),
                    ),
                    TextField(
                      maxLength: 12,
                      textAlign: TextAlign.end,
                      controller: wishAddNotifier.vendorController,
                      decoration: const InputDecoration(
                        hintText: '브랜드나 제조사를 입력하세요.',
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      "구매 링크 (선택)",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: context.width(0.04),
                        color:
                            Theme.of(context).brightness == Brightness.dark
                                ? Colors.white
                                : Colors.black,
                      ),
                    ),
                    TextField(
                      textAlign: TextAlign.end,
                      controller: wishAddNotifier.urlController,
                      keyboardType: TextInputType.url,
                      decoration: const InputDecoration(
                        hintText: 'ex. https://naver.com',
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                    ),
                    SizedBox(height: context.height(0.03)),
                    Text(
                      '*구매 링크를 입력하지 않으면 추후 "구매하기"를 진행했을 때, 해당 위시아이템 이름을 기반으로 다나와 사이트에 연결됩니다.',
                      style: TextStyle(
                        fontSize: context.width(0.035),
                        color: Colors.grey,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(height: context.height(0.01)),
                    wishState.starWishes.length < 5
                        ? CheckboxListTile(
                          title: Text(
                            "TOP5에 등록하기",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color:
                                  Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? primaryColor
                                      : const Color.fromARGB(255, 216, 155, 50),
                            ),
                          ),
                          subtitle: Text(
                            "나의 대표 위시 아이템으로 등록합니다.",
                            style: TextStyle(
                              color:
                                  Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.white
                                      : Colors.black,
                            ),
                          ),
                          value: wishAddState.isTop5,
                          onChanged: wishAddNotifier.toggleIsTop5,
                          activeColor: primaryGradientStart,
                          controlAffinity: ListTileControlAffinity.leading,
                          contentPadding: EdgeInsets.zero,
                        )
                        : Text(
                          "*Star 위시리스트는 최대 5개만 가능합니다.",
                          style: TextStyle(
                            fontSize: context.width(0.035),
                            fontWeight: FontWeight.bold,
                            color: Colors.deepOrange,
                          ),
                          textAlign: TextAlign.center,
                        ),
                    SizedBox(height: context.height(0.03)),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: SafeArea(
              child: Padding(
                padding: EdgeInsets.only(
                  left: context.middlePadding,
                  right: context.middlePadding,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 10,
                ),
                child: SizedBox(
                  width: double.infinity,
                  height: context.height(0.06),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryGradientEnd,
                    ),
                    // 👇 ViewModel의 canSubmit 상태에 따라 버튼 활성화/비활성화
                    onPressed:
                        wishAddState.canSubmit
                            ? () => wishAddNotifier.submitWishItem(context)
                            : null,
                    child: Text(
                      "추가 하기",
                      style: TextStyle(
                        color:
                            wishAddState.canSubmit ? Colors.black : Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          // 로딩 오버레이
          if (wishAddState.isLoading) overlayView(),
        ],
      ),
    );
  }
}
