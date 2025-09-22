import 'package:earned_it/models/wish/wish_search_state.dart';
import 'package:earned_it/view_models/wish/wish_search_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class WishSimpleSearchView extends ConsumerStatefulWidget {
  const WishSimpleSearchView({super.key});

  @override
  ConsumerState<WishSimpleSearchView> createState() =>
      _WishSimpleSearchViewState();
}

class _WishSimpleSearchViewState extends ConsumerState<WishSimpleSearchView> {
  // ViewModel로부터 컨트롤러를 가져오기 위한 변수
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    // ViewModel에 생성된 컨트롤러를 가져옵니다.
    _searchController =
        ref.read(wishSearchViewModelProvider.notifier).searchController;
    // 컨트롤러의 내용이 변경될 때마다 suffixIcon을 업데이트하기 위해 리스너를 추가합니다.
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    // 위젯이 제거될 때 리스너를 함께 제거하여 메모리 누수를 방지합니다.
    _searchController.removeListener(_onSearchChanged);
    super.dispose();
  }

  // 텍스트가 변경될 때마다 setState를 호출하여 UI(suffixIcon)를 다시 그리도록 합니다.
  void _onSearchChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // ViewModel의 상태와 인스턴스를 가져옵니다.
    final searchState = ref.watch(wishSearchViewModelProvider);
    final searchViewModel = ref.read(wishSearchViewModelProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: const Text(
          "상품 검색",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(), // 키보드 바깥 터치 시 숨김
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _searchController, // ViewModel의 컨트롤러 사용
                autofocus: true,
                decoration: InputDecoration(
                  hintText: '상품 키워드를 입력하세요.',
                  hintStyle: const TextStyle(color: Colors.grey),
                  suffixIcon:
                      _searchController.text.isNotEmpty
                          ? IconButton(
                            icon: const Icon(Icons.search),
                            onPressed:
                                searchViewModel.searchProducts, // 검색 함수 호출
                          )
                          : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                onSubmitted:
                    (_) => searchViewModel.searchProducts(), // 엔터 시 검색 함수 호출
              ),
              const SizedBox(height: 20),
              Expanded(
                child: _buildSearchResults(searchState), // 상태에 따라 결과 UI 빌드
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 검색 상태에 따라 다른 UI를 보여주는 헬퍼 위젯
  Widget _buildSearchResults(WishSearchState state) {
    // 1. 로딩 중일 때
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    // 2. 에러가 발생했을 때
    if (state.errorMessage != null) {
      return Center(
        child: Text(
          '오류가 발생했습니다.\n${state.errorMessage}',
          textAlign: TextAlign.center,
        ),
      );
    }

    // 3. 검색 결과가 없을 때 (초기 화면 포함)
    if (state.products.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 60, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              // searchInfo가 null이면 아직 검색 전, null이 아니면 검색 후 결과 없음
              state.searchInfo == null
                  ? '원하는 상품을 검색해보세요.'
                  : '검색 결과가 없습니다.\n다른 키워드로 검색해보세요.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
          ],
        ),
      );
    }

    // 4. 검색 결과가 있을 때
    return ListView.builder(
      itemCount: state.products.length,
      itemBuilder: (context, index) {
        final product = state.products[index];
        final formattedPrice = NumberFormat('#,###').format(product.price);
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 6.0),
          child: ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                product.imageUrl,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
                errorBuilder:
                    (context, error, stackTrace) =>
                        const Icon(Icons.image_not_supported),
              ),
            ),
            title: Text(
              product.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(
              '${product.maker ?? ''}\n${formattedPrice}원',
              style: const TextStyle(color: Colors.grey),
            ),
            isThreeLine: true,
            onTap: () {
              // TODO: 이 상품을 위시리스트에 추가하는 로직 구현
              print('선택된 상품: ${product.name}');
              // 예: context.pop(product);
            },
          ),
        );
      },
    );
  }
}
