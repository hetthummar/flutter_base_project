import 'package:baseproject/models/user/user_create_model.dart';

abstract class SharedPreferenceHelper{
  Future<bool> saveUserModel(UserCreateModel _userCreateModel);
  Future<UserCreateModel?> getUserModel();
  Future<bool> clearSharedPreference();

}