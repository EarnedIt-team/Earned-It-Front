import 'package:dio/dio.dart';
import 'package:earned_it/main.dart';
import 'package:earned_it/models/api_response.dart';
import 'package:earned_it/services/rest_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userServiceProvider = Provider<UserService>((ref) {
  return UserService(restClient);
});

class UserService {
  final RestClient _restClient;

  UserService(this._restClient);

  /// 유저 정보를 서버에서 불러옵니다.
  Future<ApiResponse> loadUserInfo(String accessToken) async {
    try {
      String token = "Bearer $accessToken";

      final ApiResponse response = await _restClient.loadUserInfo(token);
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
