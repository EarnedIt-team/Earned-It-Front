import 'dart:io';

import 'package:dio/dio.dart';
import 'package:earned_it/models/api_response.dart';
import 'package:retrofit/retrofit.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: "")
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  /// 이메일 인증 코드 요청 API
  @POST("/api/auth/email/send")
  Future<ApiResponse> sendEmail(@Query('email') String email);

  /// 인증 코드 검사 API
  @POST("/api/auth/email/verify")
  Future<ApiResponse> verifyEmail(@Body() Map<String, String> body);

  /// 회원가입 API
  @POST("/api/auth/signup")
  Future<ApiResponse> signUpUser(@Body() Map<String, dynamic> body);

  /// 로그인 API (자체 로그인)
  @POST("/api/auth/signin")
  Future<ApiResponse> selflogin(@Body() Map<String, String> body);

  /// 로그인 API (카카오 로그인)
  @POST("/api/auth/signin/kakao")
  Future<ApiResponse> kakaologin(@Body() Map<String, String> body);

  /// 로그인 API (애플 로그인)
  @POST("/api/auth/signin/apple")
  Future<ApiResponse> applelogin(@Body() Map<String, String> body);

  /// 로그인 연장 API (토큰 검사 및 재발행)
  /// 해당 API는 "자동 로그인"과 토큰 재발행을 위한 용도입니다.
  @POST("/api/auth/refresh")
  Future<ApiResponse> checkToken(@Header("Authorization") String refreshtoken);

  /// 유저 정보 불러오기 API
  @GET("/api/mainpage")
  Future<ApiResponse> loadUserInfo(@Header("Authorization") String accessToken);

  /// 이용 약관 동의 API
  @POST("/api/profile/terms")
  Future<ApiResponse> agreedTerms(
    @Header("Authorization") String accessToken,
    @Body() dynamic body,
  );

  /// 월 수익 설정 API
  @POST("/api/profile/salary")
  Future<ApiResponse> setSalary(
    @Query("userId") String userId,
    @Header("Authorization") String accesstoken,
    @Body() Map<String, int> body,
  );

  /// 위시아이템 추가 API
  @POST("/api/wish")
  @MultiPart()
  Future<ApiResponse> addWishItem(
    @Header("Authorization") String accesstoken, {
    @Part(name: "wish") required String wish,
    @Part(name: "image") required File itemImage,
  });

  /// 위시아이템 삭제 API
  @DELETE("/api/wish/{wishId}")
  Future<ApiResponse> deleteWishItem(
    @Header("Authorization") String accesstoken,
    @Path("wishId") int wishId,
  );

  @PATCH("/api/wish/{wishId}")
  @MultiPart()
  Future<ApiResponse> editWishItem(
    @Header("Authorization") String accesstoken,
    @Path("wishId") int wishId, {
    @Part(name: "wish") required String wish,
    @Part(name: "image") File? itemImage,
  });
}
