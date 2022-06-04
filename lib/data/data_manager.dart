import 'package:baseproject/app/locator.dart';
import 'package:baseproject/data/prefs/shared_preference_service.dart';
import 'package:baseproject/models/user/user_create_model.dart';
import 'package:baseproject/utils/api_utils/api_result/api_result.dart';

import 'data_manager_helper.dart';
import 'network/api_service/users/user_api_service.dart';

class DataManager implements DataManagerHelper {
  final UserApiService _userApiServices = locator<UserApiService>();
  final SharedPreferenceService _sharedPreferenceService = locator<SharedPreferenceService>();

  @override
  Future<ApiResult<bool>> createUser(UserCreateModel userCreateModel) {
    return _userApiServices.createUser(userCreateModel);
  }

  @override
  Future<ApiResult<UserCreateModel>> getUserData() {
    return _userApiServices.getUserData();
  }

  @override
  Future<UserCreateModel?> getUserModel() {
    return _sharedPreferenceService.getUserModel();
  }

  @override
  Future<bool> saveUserModel(UserCreateModel _userCreateModel) {
    return _sharedPreferenceService.saveUserModel(_userCreateModel);
  }


  @override
  Future<bool> clearSharedPreference() {
    return _sharedPreferenceService.clearSharedPreference();
  }

  @override
  Future<ApiResult<UserCreateModel>> updateFirebaseNotificationToken(String updatedToken) {
    return _userApiServices.updateFirebaseNotificationToken(updatedToken);
  }

}
