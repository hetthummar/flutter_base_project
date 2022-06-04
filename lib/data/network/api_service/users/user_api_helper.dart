
import '../../../../models/user/user_create_model.dart';
import '../../../../utils/api_utils/api_result/api_result.dart';

abstract class UserApiHelper {

  Future<ApiResult<bool>> createUser(
    UserCreateModel userCreateModel,
  );

  Future<ApiResult<UserCreateModel>> updateFirebaseNotificationToken(
      String updatedToken,
      );

  Future<ApiResult<UserCreateModel>> getUserData();

}
