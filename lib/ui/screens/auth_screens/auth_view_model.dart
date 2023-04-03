import 'package:baseproject/app/locator.dart';
import 'package:baseproject/app/routes/setup_routes.router.dart';
import 'package:baseproject/base/custom_base_view_model.dart';
import 'package:baseproject/models/app_models/api_error_model.dart';
import 'package:baseproject/models/login_models/facebook_login_model.dart';
import 'package:baseproject/models/login_models/google_login_model.dart';
import 'package:baseproject/models/user/user_create_model.dart';
import 'package:baseproject/services/firebase_analytics_service.dart';
import 'package:baseproject/utils/results/api_result/api_result.dart';
import 'package:baseproject/utils/results/boolean_result/boolean_result.dart';
import 'package:stacked/stacked.dart';

import '../../../const/enums/login_method_enum.dart';
import '../../../models/login_models/apple_login_model.dart';

class AuthViewModel extends IndexTrackingViewModel {
  
  CustomBaseViewModel customBaseViewModel = locator<CustomBaseViewModel>();
  
  gotoSignUpScreen() {
    customBaseViewModel
        .getNavigationService()
        .navigateTo(Routes.signUpView);
  }

  createAccountWithGoogle() async {
    customBaseViewModel.showProgressBar();

    BooleanResult<GoogleLoginModel> googleLoginModelResult =
        await customBaseViewModel.getAuthService().signInWithGoogle();

    googleLoginModelResult.when(success: (GoogleLoginModel googleLoginModel) {
      handleSocialLoginFlow(googleLoginModel: googleLoginModel);
    }, failure: (String error) async {
      await customBaseViewModel.getAuthService().logOut();
      await customBaseViewModel.stopProgressBar();
    });
  }

  createAccountWithFacebook() async {
    customBaseViewModel.showProgressBar();

    BooleanResult<FacebookLoginModel> facebookLoginModel =
        await customBaseViewModel.getAuthService().signInWithFacebook();

    facebookLoginModel.when(success: (FacebookLoginModel facebookLoginModel) {
      handleSocialLoginFlow(facebookLoginModel: facebookLoginModel);
    }, failure: (String error) async {
      await customBaseViewModel.getAuthService().logOut();
      await customBaseViewModel.stopProgressBar();
    });
  }

  createAccountWithApple() async {
    customBaseViewModel.showProgressBar();

    BooleanResult<AppleLoginModel> appleLoginModelResult =
        await customBaseViewModel.getAuthService().signInWithApple();

    appleLoginModelResult.when(success: (AppleLoginModel appleLoginModel) {
      handleSocialLoginFlow(appleLoginModel: appleLoginModel);
    }, failure: (String error) async {
      await customBaseViewModel.getAuthService().logOut();
      await customBaseViewModel.stopProgressBar();
    });
  }

  handleSocialLoginFlow(
      {GoogleLoginModel? googleLoginModel,
      AppleLoginModel? appleLoginModel,
      FacebookLoginModel? facebookLoginModel}) async {

    String tokenId =
        (await customBaseViewModel.getAuthService().getIdToken())!;

    String notificationToken =
        await customBaseViewModel.getNotificationService().getFcmToken();

    if (notificationToken == "") {
      customBaseViewModel.stopProgressBar();
      await customBaseViewModel.getAuthService().logOut();
      return;
    }

    UserCreateModel userCreateModel;
    loginMethodEnum _loginMethodEnum;

    if (googleLoginModel != null) {
      userCreateModel = UserCreateModel(
          id: googleLoginModel.firebaseId,
          firebaseTokenId: tokenId,
          accountCreationMethod: loginMethodEnum.google.name,
          name: googleLoginModel.displayName,
          email: googleLoginModel.email,
          googleId: googleLoginModel.googleLoginId,
          firebaseNotificationTokenId: notificationToken);

      _loginMethodEnum = loginMethodEnum.google;
    } else if (facebookLoginModel != null) {
      userCreateModel = UserCreateModel(
          id: facebookLoginModel.firebaseId,
          firebaseTokenId: tokenId,
          accountCreationMethod: loginMethodEnum.facebook.name,
          name: facebookLoginModel.displayName,
          email: facebookLoginModel.email,
          facebookId: facebookLoginModel.facebookLoginId,
          firebaseNotificationTokenId: notificationToken);

      _loginMethodEnum = loginMethodEnum.facebook;
    } else {
      //replace this model with apple
      userCreateModel = UserCreateModel(
          id: appleLoginModel!.firebaseId,
          firebaseTokenId: tokenId,
          accountCreationMethod: loginMethodEnum.apple.name,
          name: appleLoginModel.displayName,
          email: appleLoginModel.email,
          appleId: appleLoginModel.appleLoginId,
          firebaseNotificationTokenId: notificationToken);

      _loginMethodEnum = loginMethodEnum.apple;
    }

    ApiResult<bool> createUserResult = await customBaseViewModel
        .getUserApiService()
        .createUser(userCreateModel);

    FirebaseAnalyticsService firebaseAnalyticsService =
        customBaseViewModel.getAnalyticsService();

    createUserResult.when(success: (bool result) async {
      bool result = await customBaseViewModel
          .getSharedPreferenceService()
          .saveUserModel(userCreateModel);
      if (result) {
        await firebaseAnalyticsService.logSignUpEvent(_loginMethodEnum);
        customBaseViewModel.stopProgressBar();
        customBaseViewModel
            .getNavigationService()
            .pushNamedAndRemoveUntil(Routes.mainScreenView);
      }
    }, failure: (ApiErrorModel _errorModel) async {
      if (_errorModel.statusCode == 409) {
        String fcmToken =
            await customBaseViewModel.getNotificationService().getFcmToken();

        if (fcmToken == "null") {
          customBaseViewModel.showErrorDialog();
          return;
        }

        ApiResult<UserCreateModel> updateUserResult = await customBaseViewModel
            .getUserApiService()
            .updateFirebaseNotificationToken(fcmToken);

        updateUserResult.when(
            success: (UserCreateModel userUpdatedModel) async {
          bool result = await customBaseViewModel
              .getSharedPreferenceService()
              .saveUserModel(userUpdatedModel);
          if (result) {
            await firebaseAnalyticsService.logLoginEvent(_loginMethodEnum);
            customBaseViewModel.stopProgressBar();
            customBaseViewModel
                .getNavigationService()
                .pushNamedAndRemoveUntil(Routes.mainScreenView);
          } else {
            await customBaseViewModel.getAuthService().logOut();
            customBaseViewModel.showErrorDialog();
          }
        }, failure: (ApiErrorModel errorModel) async {
          await customBaseViewModel.getAuthService().logOut();
          customBaseViewModel.showErrorDialog();
        });
      } else {
        await customBaseViewModel.getAuthService().logOut();
        await customBaseViewModel.showErrorDialog(
            description: _errorModel.errorMessage);
      }
    });
  }

  gotoLoginScreen() {
    customBaseViewModel
        .getNavigationService()
        .navigateTo(Routes.loginView);
  }
}
