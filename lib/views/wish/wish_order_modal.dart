import 'package:earned_it/config/design.dart';
import 'package:earned_it/view_models/wish/wish_order_provider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

// ConsumerWidget 대신 ConsumerStatefulWidget으로 변경
class WishOrderModal extends ConsumerStatefulWidget {
  const WishOrderModal({super.key});

  @override
  ConsumerState<WishOrderModal> createState() => _WishOrderModalState();
}

class _WishOrderModalState extends ConsumerState<WishOrderModal> {
  int? _selectedWishId; // ✅ 여기에 선택된 아이템 ID를 저장할 변수 선언

  @override
  Widget build(BuildContext context) {
    // ... 기존 build 메서드 내용
    final state = ref.watch(wishOrderViewModelProvider);
    final notifier = ref.read(wishOrderViewModelProvider.notifier);
    final currencyFormat = NumberFormat.decimalPattern('ko_KR');

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color:
            Theme.of(context).brightness == Brightness.dark
                ? lightDarkColor
                : lightColor2,
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(context.middlePadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              // --- 헤더 ---
              Text(
                textAlign: TextAlign.center,
                "Star 위시리스트 순서 변경",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color:
                      Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                textAlign: TextAlign.center,
                "아이템을 길게 눌러 순서를 변경하세요.",
                style: TextStyle(
                  color:
                      Theme.of(context).brightness == Brightness.dark
                          ? Colors.grey
                          : Colors.black,
                  fontSize: context.width(0.035),
                ),
              ),
              Text(
                textAlign: TextAlign.center,
                "*2개 이상의 아이템이 존재해야 변경이 가능합니다.",
                style: TextStyle(
                  color: Colors.orange,
                  fontWeight: FontWeight.bold,
                  fontSize: context.width(0.032),
                ),
              ),
              const SizedBox(height: 16),

              // --- 순서 변경 리스트 ---
              // 리스트가 길어질 경우를 대비해 높이 제한 및 스크롤 적용
              // --- 순서 변경 리스트 ---
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.5,
                ),
                child: ReorderableListView.builder(
                  shrinkWrap: true,
                  itemCount: state.currentList.length,
                  itemBuilder: (context, index) {
                    final item = state.currentList[index];

                    // ✅ 기존 Card와 ListTile 부분을 Container + InkWell + Column/Row로 대체
                    final isSelected = _selectedWishId == item.wishId;

                    return Card(
                      // Card 위젯은 그대로 유지하여 elevation 효과를 줍니다.
                      color: Colors.transparent, // Card의 색상은 투명하게
                      elevation: 0,
                      key: ValueKey(item.wishId),
                      margin: const EdgeInsets.symmetric(
                        vertical: 4,
                      ), // Card 간격 조절 (선택 사항)
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            _selectedWishId = item.wishId;
                          });
                        },
                        borderRadius: BorderRadius.circular(8.0), // 탭 효과를 둥글게
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 16,
                          ), // ListTile의 기본 패딩과 유사하게 조절
                          decoration: BoxDecoration(
                            color:
                                isSelected
                                    ? Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors
                                            .blueGrey
                                            .shade800 // 다크 모드 선택 색상
                                        : Colors.blue.withOpacity(
                                          0.2,
                                        ) // 라이트 모드 선택 색상
                                    : Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? const Color.fromARGB(
                                      125,
                                      87,
                                      80,
                                      68,
                                    ) // 다크 모드 기본색상
                                    : Colors.transparent, // 라이트 모드 기본색상
                            borderRadius: BorderRadius.circular(8.0),
                            border: Border.all(
                              color:
                                  isSelected
                                      ? primaryGradientEnd // 선택됐을 때 테두리 색상
                                      : Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.white
                                      : const Color.fromARGB(
                                        255,
                                        132,
                                        132,
                                        132,
                                      ),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.drag_handle,
                                color:
                                    isSelected
                                        ? Colors
                                            .white // 선택됐을 때 아이콘 색상
                                        : Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors.white
                                        : Colors.black,
                              ),
                              const SizedBox(
                                width: 16,
                              ), // leading 아이콘과 텍스트 사이 간격
                              Expanded(
                                child: Text(
                                  item.name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color:
                                        isSelected
                                            ? Colors
                                                .white // 선택됐을 때 텍스트 색상
                                            : Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? Colors.white
                                            : Colors.black,
                                  ),
                                ),
                              ),
                              Text(
                                '${currencyFormat.format(item.price)}원',
                                style: TextStyle(
                                  fontSize: context.width(0.035),
                                  color:
                                      isSelected
                                          ? Colors
                                              .white // 선택됐을 때 텍스트 색상
                                          : Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? Colors.white
                                          : Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  onReorder: notifier.reorderList,
                ),
              ),
              const SizedBox(height: 24),

              // --- 하단 버튼 ---
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: state.canSubmit ? notifier.resetOrder : null,
                      child: const Text("초기화"),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryGradientEnd,
                      ),
                      onPressed:
                          state.canSubmit
                              ? () => notifier.submitOrder(context)
                              : null,
                      child: const Text(
                        "완료",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
