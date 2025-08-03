import 'package:dio/dio.dart';
import 'package:earned_it/main.dart';
import 'package:earned_it/models/api_response.dart';
import 'package:earned_it/models/wish/wish_model.dart';
import 'package:earned_it/services/rest_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final wishServiceProvider = Provider<WishService>((ref) {
  return WishService(restClient);
});

class WishService {
  final RestClient _restClient;

  WishService(this._restClient);

  /// 위시아이템을 서버에 추가합니다.
  Future<ApiResponse> addWishItem(
    String accessToken,
    WishModel wishItem,
  ) async {
    try {
      String token = "Bearer $accessToken";

      final Map<String, dynamic> requestBody = <String, dynamic>{
        "name": wishItem.name,
        "vendor": wishItem.vendor,
        "price": wishItem.price,
        "itemImage": wishItem.itemImage,
        "url": wishItem.url,
        "starred": wishItem.starred,
      };

      final ApiResponse response = await _restClient.addWishItem(
        token,
        requestBody,
      );
      // 통신은 성공했지만, 처리가 되지 않았을 때
      if (response.code != "SUCCESS") {
        throw Exception(response.message);
      }
      return response;
      // 400 에러 등
    } on DioException catch (e) {
      throw Exception(e.response!.data["message"]);
    } catch (e) {
      // DioException이 아닌 다른 예외 발생 시 (네트워크 연결 끊김 등)
      throw Exception("서버에서 에러가 발생했습니다.");
    }
  }
}
