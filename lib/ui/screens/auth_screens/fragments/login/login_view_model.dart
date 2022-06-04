import 'package:baseproject/app/routes/setup_routes.router.dart';
import 'package:baseproject/base/custom_base_view_model.dart';
import 'package:baseproject/models/app_models/api_error_model.dart';
import 'package:baseproject/models/user/user_create_model.dart';
import 'package:baseproject/utils/api_utils/api_result/api_result.dart';
import 'package:baseproject/utils/app_util.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../../const/enums/login_method_enum.dart';

class LoginViewModel extends CustomBaseViewModel {
  bool isEmailValid = false;
  bool isPasswordValid = false;
  bool continueBtnStatus = false;

  changeEmailValidStatus(bool emailValidInputStatus) {
    isEmailValid = emailValidInputStatus;
    if (isEmailValid && isPasswordValid) {
      continueBtnStatus = true;
    } else {
      continueBtnStatus = false;
    }
    notifyListeners();
  }

  changePasswordValidStatus(bool passwordValidInputStatus) {
    isPasswordValid = passwordValidInputStatus;
    if (isEmailValid && isPasswordValid) {
      continueBtnStatus = true;
    } else {
      continueBtnStatus = false;
    }
    notifyListeners();
  }

  forgotPassword(String email) async {
    email = email.trim();
    // getSnackBarService().showSnackbar(message: "qdqw");

    if (AppUtils().isValidEmail(email)) {
      try {
        showProgressBar();
        await getAuthService().resetPassword(email);
        stopProgressBar();

        getDialogService().showDialog(
            title: "We received your Request",
            description: "An Email has been set for resetting password");
      } on FirebaseException catch (e) {
        stopProgressBar();
        if (e.code == "user-not-found") {
          showErrorDialog(
              title: "Email not registered",
              description:
              "Entered email is not registered. please check your email");
        } else {
          showErrorDialog(
              title: "Problem occured", description: e.message.toString());
        }
      }
      // showSnackBar("Verification mail sent");
    } else {
      showSnackBar("Enter valid email Id");
    }
  }

  loginUser(String email, String password) async {
    email = email.trim();
    password = password.trim();

    showProgressBar();
    String response =
    await getAuthService().signInWithEmailAndPassword(email, password);


    if (response == "Success") {

      String fcmToken = await getNotificationService().getFcmToken();

      if (fcmToken == "null") {
        showErrorDialog();
        return;
      }

      ApiResult<UserCreateModel> updateUserResult =
      await getDataManager().updateFirebaseNotificationToken(fcmToken);

      updateUserResult.when(success: (UserCreateModel userUpdatedModel) async {

        bool result = await getDataManager().saveUserModel(userUpdatedModel);
        if (result) {
          await getAnalyticsService().logLoginEvent(loginMethodEnum.email);
          stopProgressBar();
          getNavigationService().clearStackAndShow(Routes.mainScreenView);
        } else {
          stopProgressBar();
          showErrorDialog();
        }
      }, failure: (ApiErrorModel errorModel) {
        if (errorModel.statusCode == 404) {
          stopProgressBar();

          showErrorDialog(
              title: "Account not Exist",
              description: "Please create account before login");
        } else {
          showErrorDialog(description: errorModel.errorMessage.toString());
        }
      });
    } else {
      if (response.contains("Incorrect email or password")) {
        showErrorDialog(description: response, title: "Login Failed");
      } else {
        showErrorDialog(description: response);
      }
    }
  }
}
