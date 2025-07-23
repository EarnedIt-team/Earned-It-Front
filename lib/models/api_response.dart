import 'package:json_annotation/json_annotation.dart';

part 'api_response.g.dart';

// API Response 모델
@JsonSerializable(genericArgumentFactories: true)
class ApiResponse<T> {
  final String? status;
  final int? code;
  final T? data; // 제네릭 타입
  final ApiError? error;

  ApiResponse({this.status, this.code, this.data, this.error}); // required 제거

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) => _$ApiResponseFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object Function(T value) toJsonT) =>
      _$ApiResponseToJson(this, toJsonT);
}

@JsonSerializable()
class ApiError {
  final int? code;
  final String? message;

  ApiError({this.code, this.message});

  factory ApiError.fromJson(Map<String, dynamic> json) =>
      _$ApiErrorFromJson(json);

  Map<String, dynamic> toJson() => _$ApiErrorToJson(this);
}
