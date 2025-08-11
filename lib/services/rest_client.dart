import 'dart:io';

import 'package:dio/dio.dart';
import 'package:earned_it/models/api_response.dart';
import 'package:retrofit/retrofit.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: "")
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  /// 프로필 기본 조회 API
  @GET("/api/profile")
  Future<ApiResponse> loadProfile(@Header("Authorization") String accessToken);

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

  /// 비밀번호 재설정 이메일 전송 요청 API
  @POST("/api/auth/password/email")
  Future<ApiResponse> sendpasswordEmail(@Query('email') String email);

  /// 비밀번호 재설정용 인증 코드 검증 요청 API
  @POST("/api/auth/password/verify")
  Future<ApiResponse> verifyPasswordEmail(@Body() Map<String, String> body);

  /// 비밀번호 재설정 요청 API
  @POST("/api/auth/password/reset")
  Future<ApiResponse> resetPassword(@Body() Map<String, String> body);

  // 로그아웃 API
  @POST("/api/auth/signout")
  Future<ApiResponse> signout(@Header("Authorization") String accessToken);

  // 회원탈퇴 API
  @DELETE("/api/users/me")
  Future<ApiResponse> resign(@Header("Authorization") String accessToken);

  /// 유저 정보 불러오기 API
  @GET("/api/mainpage")
  Future<ApiResponse> loadUserInfo(@Header("Authorization") String accessToken);

  /// 이용 약관 동의 API
  @POST("/api/profile/terms")
  Future<ApiResponse> agreedTerms(
    @Header("Authorization") String accessToken,
    @Body() dynamic body,
  );

  /// 보상 후보 요청 API
  @GET("/api/daily-check/candidates")
  Future<ApiResponse> getCandidates(
    @Header("Authorization") String accessToken,
  );

  /// 보상 선택 API
  @POST("/api/daily-check/select")
  Future<ApiResponse> selectDailyCheck(
    @Header("Authorization") String accessToken,
    @Body() Map<String, dynamic> body,
  );

  /// Star 위시리스트 불러오기 API
  @GET("/api/star")
  Future<ApiResponse> loadStarInfo(@Header("Authorization") String accessToken);

  /// Star 위시리스트 순서 변경 API
  @PATCH("/api/star/order")
  Future<ApiResponse> updateStarWishOrder(
    @Header("Authorization") String accessToken,
    @Body() Map<String, dynamic> body,
  );

  /// 월 수익 설정 API
  @POST("/api/profile/salary")
  Future<ApiResponse> setSalary(
    @Query("userId") String userId,
    @Header("Authorization") String accesstoken,
    @Body() Map<String, int> body,
  );

  /// 닉네임 변경 API
  @PATCH("/api/profile/nickname")
  Future<ApiResponse> setNickName(
    @Header("Authorization") String accesstoken,
    @Body() Map<String, String> body,
  );

  /// 프로필 사진 변경 API
  @PATCH("/api/profile/image")
  @MultiPart()
  Future<ApiResponse> setProfileImage(
    @Header("Authorization") String accesstoken, {
    @Part(name: "profileImage") required File itemImage,
  });

  /// 프로필 사진 삭제 API
  @PATCH("/api/profile/image/delete")
  Future<ApiResponse> deleteProfileImage(
    @Header("Authorization") String accesstoken,
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

  /// 위시아이템 수정 API
  @PATCH("/api/wish/{wishId}")
  @MultiPart()
  Future<ApiResponse> editWishItem(
    @Header("Authorization") String accesstoken,
    @Path("wishId") int wishId, {
    @Part(name: "wish") required String wish,
    @Part(name: "image") File? itemImage,
  });

  /// 위시아이템 Star 여부 수정 API
  @PATCH("/api/star/{wishId}")
  Future<ApiResponse> editStarWishItem(
    @Header("Authorization") String accesstoken,
    @Path("wishId") int wishId,
  );

  /// 위시아이템 구매 여부 수정 API
  @PATCH("/api/wish/{wishId}/toggle-bought")
  Future<ApiResponse> editBoughtWishItem(
    @Header("Authorization") String accesstoken,
    @Path("wishId") int wishId,
  );

  /// 위시아이템 하이라이트(3개) 불러오기 API
  @GET("/api/wish/highlight")
  Future<ApiResponse> loadHighLightWishInfo(
    @Header("Authorization") String accessToken,
  );

  /// 위시리스트 전체 목록 불러오기
  @GET("/api/wish")
  Future<ApiResponse> getWishList(
    @Header("Authorization") String accessToken,
    @Query("page") int page,
    @Query("size") int size,
    @Query("sort") String sort, // 예: "price,asc" 또는 "createdAt,desc"
  );

  /// 가장 최근에 획득한 조각 불러오기 API
  @GET("/api/piece/recent")
  Future<ApiResponse> loadRecentPiece(
    @Header("Authorization") String accessToken,
  );

  /// 퍼즐 리스트 불러오기 API
  @GET("/api/puzzle")
  Future<ApiResponse> loadPieceList(
    @Header("Authorization") String accessToken,
  );

  /// 조각 상세정보 불러오기 API
  @GET("/api/piece/{pieceId}")
  Future<ApiResponse> loadPieceInfo(
    @Header("Authorization") String accesstoken,
    @Path("pieceId") int pieceId,
  );
}
