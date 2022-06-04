import 'package:dio/dio.dart';

import '../../../../app/locator.dart';
import '../../../../const/end_points_const.dart';
import '../../../../models/user/user_create_model.dart';
import '../../../../utils/api_utils/api_exception/api_exception.dart';
import '../../../../utils/api_utils/api_result/api_result.dart';
import '../../../../utils/client.dart';
import 'user_api_helper.dart';

class UserApiService implements UserApiHelper{

  Client _client = locator<Client>();

  UserApiService() {
    _client =  Client();
  }

  @override
  Future<ApiResult<bool>> createUser(UserCreateModel userCreateModel) async{

    try {
      await _client.builder().build().post(EndPointsConst.addUser,data: userCreateModel.toJson());
      return const ApiResult.success(data: true);
    } catch (e) {
       return ApiResult.failure(error: ApiException().getApiErrorModel(e));
    }

  }

  @override
  Future<ApiResult<UserCreateModel>> updateFirebaseNotificationToken(String updatedNotificationToken) async {
    try {
      Client tempClient = await _client.builder().setProtectedApiHeader();
      Map<String,String> updatedMap = {};
      updatedMap.putIfAbsent("firebase_notification_token_id", () => updatedNotificationToken);

      Response _response = await tempClient.build().patch(EndPointsConst.updateUser,data: updatedMap);
      UserCreateModel _userCreateModel = UserCreateModel.fromJson(_response.data['data']);

      return ApiResult.success(data: _userCreateModel);
    } catch (e) {
      return ApiResult.failure(error: ApiException().getApiErrorModel(e));
    }
  }

  @override
  Future<ApiResult<UserCreateModel>> getUserData()async {

    Client tempClient = await _client.builder().setProtectedApiHeader();

    try {
      Response _response = await tempClient.build().get(EndPointsConst.getUser);
        UserCreateModel _userCreateModel = UserCreateModel.fromJson(_response.data['data']);
        return ApiResult.success(data: _userCreateModel);
    } catch (e) {
      return ApiResult.failure(error: ApiException().getApiErrorModel(e));
    }
  }

}