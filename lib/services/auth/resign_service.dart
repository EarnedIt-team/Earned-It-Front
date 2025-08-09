import 'package:dio/dio.dart';
import 'package:earned_it/main.dart';
import 'package:earned_it/models/api_response.dart';
import 'package:earned_it/services/rest_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final reSignServiceProvider = Provider<reSignService>((ref) {
  return reSignService(restClient);
});

class reSignService {
  final RestClient _restClient;

  reSignService(this._restClient);

  /// 현재 계정의 회원탈퇴 요청을 서버에게 전달합니다.
  Future<void> reSign(String accessToken) async {
    try {
      String token = "Bearer $accessToken";

      final ApiResponse response = await _restClient.resign(token);
      // 통신은 성공했지만, 처리가 되지 않았을 때
      if (response.code != "SUCCESS") {
        throw Exception(response.message);
      }
      // 400 에러 등
    } on DioException catch (e) {
      throw Exception(e.response!.data["message"]);
    } catch (e) {
      // DioException이 아닌 다른 예외 발생 시 (네트워크 연결 끊김 등)
      throw Exception("서버에서 에러가 발생했습니다.");
    }
  }
}
