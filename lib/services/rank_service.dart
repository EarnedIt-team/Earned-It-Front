import 'package:dio/dio.dart';
import 'package:earned_it/main.dart';
import 'package:earned_it/models/api_response.dart';
import 'package:earned_it/services/rest_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final rankServiceProvider = Provider<RankService>((ref) {
  return RankService(restClient);
});

class RankService {
  final RestClient _restClient;

  RankService(this._restClient);

  /// 랭킹 정보를 불러옵니다.
  Future<ApiResponse> loadRank({required String accessToken}) async {
    try {
      String token = "Bearer $accessToken";

      final ApiResponse response = await _restClient.loadRankInfo(token);

      if (response.code != "SUCCESS") {
        throw Exception(response.message);
      }
      return response;
    } on DioException catch (e) {
      throw Exception(e.response?.data["message"] ?? "요청 처리 중 에러가 발생했습니다.");
    } catch (e) {
      throw Exception("서버에서 에러가 발생했습니다.");
    }
  }
}
