import 'package:baseproject/base/custom_base_view_model.dart';
import 'package:baseproject/models/user/user_create_model.dart';
import 'package:flutter/cupertino.dart';

class ProfileViewModel extends CustomBaseViewModel {
  var formKeyForEditProfile = GlobalKey<FormState>();
  String? userName;

  getUserData() async {
    UserCreateModel? _userBasicDataOfflineModel =
        await getDataManager().getUserModel();
    if (_userBasicDataOfflineModel != null) {
      userName = _userBasicDataOfflineModel.name;
      notifyListeners();
    }
  }

}
