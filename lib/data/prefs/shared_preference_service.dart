import 'dart:convert';
import 'package:baseproject/const/shared_pref_const.dart';
import 'package:baseproject/models/user/user_create_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceService {
  Future<bool> saveUserModel(UserCreateModel userCreateModel) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(
        SharedPrefConst.userModel,
        jsonEncode(
          userCreateModel.toJson(),
        ),
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> clearSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.clear();
  }

  Future<UserCreateModel?> getUserModel() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? resultInString = prefs.getString(SharedPrefConst.userModel);
      if (resultInString == null) return null;
      return UserCreateModel.fromJson(jsonDecode(resultInString));
    } catch (e) {
      return null;
    }
  }
}
