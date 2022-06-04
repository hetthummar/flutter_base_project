import 'dart:io';

import 'package:dio/dio.dart';

import '../../../models/app_models/api_error_model.dart';

class ApiException {

  String defaultErrorMessage = "Some problem occurred Please Try again";
  String serverOrNoInternetError = "Problem connecting to the server. Please try again.";

  ApiErrorModel getApiErrorModel(error) {
    if (error is Exception) {
      if (error is DioError) {
        DioError _error = error;

        if ((_error.type == DioErrorType.other && error.toString().contains("SocketException")) || _error.type == DioErrorType.connectTimeout) {
          return ApiErrorModel(1, serverOrNoInternetError,
              unexpectedError: true);
        } else if (_error.type == DioErrorType.response) {
          return ApiErrorModel(
              _error.response!.statusCode!, _error.response!.statusMessage!,
              unexpectedError: true);
        } else {
          return ApiErrorModel(0, defaultErrorMessage, unexpectedError: true);
        }
      } else if (error is SocketException) {
        return ApiErrorModel(1, serverOrNoInternetError,
            unexpectedError: true);
      } else {
        return ApiErrorModel(0, defaultErrorMessage, unexpectedError: true);
      }
    } else {
      return ApiErrorModel(0, defaultErrorMessage, unexpectedError: true);
    }
  }
}
