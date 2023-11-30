import 'package:fajrApp/base/custom_base_view_model.dart';
import 'package:fajrApp/models/user/user_create_model.dart';
import 'package:flutter/cupertino.dart';

class ProfileViewModel extends CustomBaseViewModel {
  var formKeyForEditProfile = GlobalKey<FormState>();
  String? userName;

  getUserData() async {
    UserCreateModel? userBasicDataOfflineModel =
        await getSharedPreferenceService().getUserModel();
    if (userBasicDataOfflineModel != null) {
      userName = userBasicDataOfflineModel.name;
      notifyListeners();
    }
  }
}
