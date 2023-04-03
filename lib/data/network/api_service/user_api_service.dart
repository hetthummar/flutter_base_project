import 'package:baseproject/app/locator.dart';
import 'package:baseproject/const/end_points_const.dart';
import 'package:baseproject/models/user/user_create_model.dart';
import 'package:baseproject/utils/api_utils/api_exception/api_exception.dart';
import 'package:baseproject/utils/client.dart';
import 'package:baseproject/utils/results/api_result/api_result.dart';
import 'package:dio/dio.dart';

class UserApiService {
  Client _client = locator<Client>();

  UserApiService() {
    _client = Client();
  }

  Future<ApiResult<bool>> createUser(UserCreateModel userCreateModel) async {
    try {
      await _client
          .builder()
          .build()
          .post(EndPointsConst.addUser, data: userCreateModel.toJson());
      return const ApiResult.success(data: true);
    } catch (e) {
      return ApiResult.failure(error: ApiException().getApiErrorModel(e));
    }
  }

  Future<ApiResult<UserCreateModel>> updateFirebaseNotificationToken(
      String updatedNotificationToken) async {
    try {
      Client tempClient = await _client.builder().setProtectedApiHeader();
      Map<String, String> updatedMap = {};
      updatedMap.putIfAbsent(
          "firebase_notification_token_id", () => updatedNotificationToken);

      Response response = await tempClient
          .build()
          .patch(EndPointsConst.updateUser, data: updatedMap);
      UserCreateModel userCreateModel =
          UserCreateModel.fromJson(response.data['data']);

      return ApiResult.success(data: userCreateModel);
    } catch (e) {
      return ApiResult.failure(error: ApiException().getApiErrorModel(e));
    }
  }

  Future<ApiResult<UserCreateModel>> getUserData() async {
    Client tempClient = await _client.builder().setProtectedApiHeader();

    try {
      Response response = await tempClient.build().get(EndPointsConst.getUser);
      UserCreateModel userCreateModel =
          UserCreateModel.fromJson(response.data['data']);
      return ApiResult.success(data: userCreateModel);
    } catch (e) {
      return ApiResult.failure(error: ApiException().getApiErrorModel(e));
    }
  }
}
