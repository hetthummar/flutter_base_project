import 'package:baseproject/models/app_models/api_error_model.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_result.freezed.dart';

@freezed
abstract class ApiResult<T> with _$ApiResult<T> {
  const factory ApiResult.success({required T data}) = Success<T>;
  const factory ApiResult.failure({required ApiErrorModel error}) = Failure<T>;
}
