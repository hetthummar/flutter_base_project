import 'dart:convert';

import 'package:baseproject/const/shared_pref_const.dart';
import 'package:baseproject/data/prefs/shared_preference_helper.dart';
import 'package:baseproject/models/user/user_create_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceService implements SharedPreferenceHelper {

  @override
  Future<bool> saveUserModel(UserCreateModel _userCreateModel) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(
        SharedPrefConst.userModel,
        jsonEncode(
          _userCreateModel.toJson(),
        ),
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> clearSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.clear();
  }

  @override
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
