// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiResponse<T> _$ApiResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) => ApiResponse<T>(
  status: json['status'] as String?,
  statusCode: (json['statusCode'] as num?)?.toInt(),
  code: json['code'] as String?,
  message: json['message'] as String?,
  data: _$nullableGenericFromJson(json['data'], fromJsonT),
  error:
      json['error'] == null
          ? null
          : ApiError.fromJson(json['error'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ApiResponseToJson<T>(
  ApiResponse<T> instance,
  Object? Function(T value) toJsonT,
) => <String, dynamic>{
  'status': instance.status,
  'statusCode': instance.statusCode,
  'code': instance.code,
  'message': instance.message,
  'data': _$nullableGenericToJson(instance.data, toJsonT),
  'error': instance.error,
};

T? _$nullableGenericFromJson<T>(
  Object? input,
  T Function(Object? json) fromJson,
) => input == null ? null : fromJson(input);

Object? _$nullableGenericToJson<T>(
  T? input,
  Object? Function(T value) toJson,
) => input == null ? null : toJson(input);

ApiError _$ApiErrorFromJson(Map<String, dynamic> json) => ApiError(
  code: (json['code'] as num?)?.toInt(),
  message: json['message'] as String?,
);

Map<String, dynamic> _$ApiErrorToJson(ApiError instance) => <String, dynamic>{
  'code': instance.code,
  'message': instance.message,
};
