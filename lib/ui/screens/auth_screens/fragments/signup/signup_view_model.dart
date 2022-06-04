import 'package:baseproject/app/routes/setup_routes.router.dart';
import 'package:baseproject/base/custom_base_view_model.dart';
import 'package:baseproject/models/app_models/api_error_model.dart';
import 'package:baseproject/models/user/user_create_model.dart';
import 'package:baseproject/utils/api_utils/api_result/api_result.dart';

import '../../../../../const/enums/login_method_enum.dart';

class SignUpViewModel extends CustomBaseViewModel {
  String enteredEmail = "";
  String enteredPassword = "";
  int selectedScreen = 0;

  changeSelectedScreen(int screenNumber) {
    selectedScreen = screenNumber;
    notifyListeners();
  }

  submitPassword(String password) async {
    enteredEmail = enteredEmail.trim();
    password = password.trim();

    showProgressBar();
    String response = await getAuthService()
        .signUpWithEmailAndPassword(enteredEmail, password);

    String notificationToken = await getNotificationService().getFcmToken();

    if (response == "Success") {
      String userId = (await getAuthService().getUserid())!;
      String firebaseTokenId = (await getAuthService().getIdToken())!;

      UserCreateModel _userCreateModel = UserCreateModel(
          id: userId,
          firebaseTokenId: firebaseTokenId,
          email: enteredEmail,
          accountCreationMethod: loginMethodEnum.email.name,
          firebaseNotificationTokenId: notificationToken
      );

      ApiResult<bool> createUserResult =
      await getDataManager().createUser(_userCreateModel);

      createUserResult.when(success: (bool result) async {
        bool result = await getDataManager().saveUserModel(_userCreateModel);
        if (result) {
          await getAnalyticsService().logSignUpEvent(loginMethodEnum.email);
          stopProgressBar();
          getNavigationService().clearStackAndShow(Routes.mainScreenView);
        }
      }, failure: (ApiErrorModel errorModel) {
        stopProgressBar();
        if (errorModel.statusCode == 409) {
          showErrorDialog(
              title: "Already Exist",
              description: "This email id is already exist please login");
        } else {
          showErrorDialog();
        }
      });
    } else {
      showErrorDialog(description: response);
    }
  }

  backBtnPressed() {
    if (selectedScreen == 1) {
      selectedScreen = 0;
      notifyListeners();
    } else {
      getNavigationService().back();
    }
  }
}
