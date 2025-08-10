import 'package:dio/dio.dart';
import 'package:earned_it/main.dart';
import 'package:earned_it/models/api_response.dart';
import 'package:earned_it/services/rest_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final pieceServiceProvider = Provider<PieceService>((ref) {
  return PieceService(restClient);
});

class PieceService {
  final RestClient _restClient;

  PieceService(this._restClient);

  /// 출석보상 후보(3개) 리스트를 가져옵니다.
  Future<ApiResponse> loadRecentPiece({required String accessToken}) async {
    try {
      String token = "Bearer $accessToken";

      final ApiResponse response = await _restClient.loadRecentPiece(token);

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

  /// 퍼즐 리스트를 가져옵니다.
  Future<ApiResponse> loadPuzzle({required String accessToken}) async {
    try {
      String token = "Bearer $accessToken";

      final ApiResponse response = await _restClient.loadPieceList(token);

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
