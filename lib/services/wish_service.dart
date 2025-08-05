import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:earned_it/main.dart';
import 'package:earned_it/models/api_response.dart';
import 'package:earned_it/models/wish/wish_model.dart';
import 'package:earned_it/services/rest_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final wishServiceProvider = Provider<WishService>((ref) {
  return WishService(restClient);
});

class WishService {
  final RestClient _restClient;

  WishService(this._restClient);

  /// 위시아이템을 서버에 추가합니다.
  Future<ApiResponse> addWishItem({
    required String accessToken,
    required WishModel wishItem, // ViewModel에서는 WishModel 객체를 받음
    required XFile imageXFile,
  }) async {
    try {
      String token = "Bearer $accessToken";

      // 1. WishModel 객체를 JSON Map으로 변환 후, 다시 JSON 문자열로 인코딩
      final wishJsonString = jsonEncode(wishItem.toJson());

      // 2. XFile을 서버에 보낼 수 있는 File 객체로 변환
      final imageFile = File(imageXFile.path);

      // 3. RestClient의 수정된 메서드 호출
      final ApiResponse response = await _restClient.addWishItem(
        token,
        wish: wishJsonString,
        itemImage: imageFile,
      );

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

  /// 위시리스트 아이템을 서버에서 삭제합니다.
  Future<ApiResponse> deleteWishItem({
    required String accessToken,
    required int wishId,
  }) async {
    try {
      String token = "Bearer $accessToken";
      final ApiResponse response = await _restClient.deleteWishItem(
        token,
        wishId,
      );

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

  /// 선택한 위시아이템의 정보를 수정해서 서버로 전달합니다.
  Future<ApiResponse> editWishItem({
    required String accessToken,
    required int wishId,
    required WishModel updatedWish,
    XFile? newImage,
  }) async {
    try {
      String token = "Bearer $accessToken";
      final wishJsonString = jsonEncode(updatedWish.toJson());
      // 새로 선택된 이미지가 있을 때만 File 객체로 변환
      final imageFile = newImage != null ? File(newImage.path) : null;

      final ApiResponse response = await _restClient.editWishItem(
        token,
        wishId,
        wish: wishJsonString,
        itemImage: imageFile, // nullable한 File 객체 전달
      );

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

  /// 하이라이트 위시 정보를 서버에서 불러옵니다.
  Future<ApiResponse> loadHighLightWish(String accessToken) async {
    try {
      String token = "Bearer $accessToken";

      final ApiResponse response = await _restClient.loadHighLightWishInfo(
        token,
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

  /// 위시리스트 목록을 서버에서 불러옵니다.
  Future<ApiResponse> getWishList({
    required String accessToken,
    required int page,
    required int size,
    required String sort,
  }) async {
    try {
      String token = "Bearer $accessToken";
      final ApiResponse response = await _restClient.getWishList(
        token,
        page,
        size,
        sort,
      );

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
