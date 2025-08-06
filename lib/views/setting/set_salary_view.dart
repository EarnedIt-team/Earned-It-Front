import 'package:earned_it/config/design.dart';
import 'package:earned_it/view_models/setting/set_Salary_provider.dart';
import 'package:earned_it/view_models/user_provider.dart';
import 'package:earned_it/views/loading_overlay_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class SetSalaryView extends ConsumerWidget {
  const SetSalaryView({super.key});

  // Cupertino 스타일로 일(day) 선택기를 띄우는 함수
  Future<void> _selectDayCupertino(BuildContext context, WidgetRef ref) async {
    final setSalaryProvider = ref.read(setSalaryViewModelProvider.notifier);
    final currentState = ref.read(setSalaryViewModelProvider);

    int tempSelectedDay = currentState.selectedDay;

    await showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: context.height(0.35),
          color: CupertinoColors.systemBackground.resolveFrom(context),
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: CupertinoColors.separator.resolveFrom(context),
                      width: 0.0,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    CupertinoButton(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 10.0,
                      ),
                      onPressed: () {
                        Navigator.pop(context); // 취소
                      },
                      child: const Text(
                        '취소',
                        style: TextStyle(color: CupertinoColors.systemRed),
                      ),
                    ),
                    CupertinoButton(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 10.0,
                      ),
                      onPressed: () {
                        setSalaryProvider.updateSelectedDay(
                          tempSelectedDay,
                        ); // ViewModel에 업데이트
                        Navigator.pop(context); // 선택 완료
                      },
                      child: const Text(
                        '선택',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: CupertinoPicker(
                  magnification: 1.22,
                  squeeze: 1.2,
                  useMagnifier: true,
                  itemExtent: 32.0,
                  scrollController: FixedExtentScrollController(
                    initialItem:
                        (currentState.selectedDay > 0 &&
                                currentState.selectedDay <= 31)
                            ? currentState.selectedDay - 1
                            : 0,
                  ),
                  onSelectedItemChanged: (int selectedItem) {
                    tempSelectedDay = selectedItem + 1;
                  },
                  children: List<Widget>.generate(31, (int index) {
                    return Center(
                      child: Text(
                        '${index + 1}일',
                        style: const TextStyle(fontSize: 22.0),
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // build 메서드에 WidgetRef ref 추가
    final salaryState = ref.watch(setSalaryViewModelProvider);
    final setSalaryProvider = ref.read(setSalaryViewModelProvider.notifier);
    final userState = ref.read(userProvider);

    final numberFormat = NumberFormat('#,###', 'ko_KR');

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Stack(
        children: <Widget>[
          Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              title: const Text(
                "월 수익 설정",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              centerTitle: false,
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: context.middlePadding,
                vertical: context.middlePadding,
              ),
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                  bottom:
                      MediaQuery.of(context).padding.bottom +
                      context.height(0.15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          "월 급여",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: context.width(0.045),
                          ),
                        ),
                        if (userState.isearningsPerSecond)
                          Text(
                            " [ 현재 : ${numberFormat.format(userState.monthlySalary)}원 ]",
                            style: TextStyle(
                              fontSize: context.width(0.03),
                              color: const Color.fromARGB(255, 118, 118, 118),
                            ),
                          ),
                      ],
                    ),
                    // 월 급여 TextField
                    TextField(
                      textAlign: TextAlign.end,
                      controller: setSalaryProvider.salaryController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: '월 급여를 입력하세요.',
                        suffixText:
                            setSalaryProvider.salaryController.text.isNotEmpty
                                ? '원'
                                : null,
                        // ViewModel의 에러 메시지를 TextField에 연결
                        errorText: salaryState.salaryErrorText,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          "급여 날짜",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: context.width(0.045),
                          ),
                        ),
                        if (userState.isearningsPerSecond)
                          Text(
                            " [ 현재 : 매 달 ${userState.payday}일 ]",
                            style: TextStyle(
                              fontSize: context.width(0.03),
                              color: const Color.fromARGB(255, 118, 118, 118),
                            ),
                          ),
                      ],
                    ),
                    TextField(
                      textAlign: TextAlign.end,
                      controller:
                          setSalaryProvider
                              .paydayController, // ViewModel의 컨트롤러 사용
                      readOnly: true,
                      onTap: () => _selectDayCupertino(context, ref), // ref를 전달
                      decoration: const InputDecoration(
                        hintText: '월급날짜를 선택하세요 (예: 매 달 25일)',
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: SafeArea(
              child: Padding(
                padding: EdgeInsets.only(
                  left: context.middlePadding,
                  right: context.middlePadding,
                  bottom: context.height(0.01),
                ),
                child: SizedBox(
                  width: double.infinity,
                  height: context.height(0.06),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                    ),
                    onPressed:
                        salaryState.isButtonEnabled
                            ? () {
                              setSalaryProvider.completeSetup(context);
                            }
                            : null,
                    child: Text(
                      "설정 완료",
                      style: TextStyle(
                        color:
                            salaryState.isButtonEnabled
                                ? Colors.black
                                : Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          // 로딩 오버레이 (월 수익 설정)
          if (salaryState.isLoading) // isLoading이 true일 때만 표시
            overlayView(),
        ],
      ),
    );
  }
}
