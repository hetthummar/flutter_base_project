import 'package:baseproject/app/routes/setup_routes.router.dart';
import 'package:baseproject/base/custom_base_view_model.dart';
import 'package:baseproject/base/custom_index_tracking_view_model.dart';
import 'package:baseproject/models/app_models/api_error_model.dart';
import 'package:baseproject/models/login_models/facebook_login_model.dart';
import 'package:baseproject/models/login_models/google_login_model.dart';
import 'package:baseproject/models/user/user_create_model.dart';
import 'package:baseproject/services/firebase_analytics_service.dart';
import 'package:baseproject/utils/api_utils/api_result/api_result.dart';
import 'package:baseproject/utils/api_utils/boolean_result/boolean_result.dart';

import '../../../const/enums/login_method_enum.dart';
import '../../../models/login_models/apple_login_model.dart';

class AuthViewModel extends CustomIndexTrackingViewModel {
  gotoSignUpScreen() {
    getCustomBaseViewModel()
        .getNavigationService()
        .navigateTo(Routes.signUpView);
  }

  createAccountWithGoogle() async {
    CustomBaseViewModel _customBaseViewModel = getCustomBaseViewModel();
    _customBaseViewModel.showProgressBar();

    BooleanResult<GoogleLoginModel> _googleLoginModelResult =
        await _customBaseViewModel.getAuthService().signInWithGoogle();

    _googleLoginModelResult.when(success: (GoogleLoginModel googleLoginModel) {
      handleSocialLoginFlow(googleLoginModel: googleLoginModel);
    }, failure: (String error) async{
      await _customBaseViewModel.getAuthService().logOut();
      await _customBaseViewModel.stopProgressBar();
    });
  }

  createAccountWithFacebook() async {
    CustomBaseViewModel _customBaseViewModel = getCustomBaseViewModel();
    _customBaseViewModel.showProgressBar();

    BooleanResult<FacebookLoginModel> _facebookLoginModel =
        await _customBaseViewModel.getAuthService().signInWithFacebook();

    _facebookLoginModel.when(success: (FacebookLoginModel _facebookLoginModel) {
      handleSocialLoginFlow(facebookLoginModel: _facebookLoginModel);
    }, failure: (String error) async{
      await _customBaseViewModel.getAuthService().logOut();
      await  _customBaseViewModel.stopProgressBar();
    });
  }

  createAccountWithApple() async {
    // String redirectAppleUri = "https://vocalgauge-14f92.firebaseapp.com/__/auth/handler";
    CustomBaseViewModel _customBaseViewModel = getCustomBaseViewModel();
    _customBaseViewModel.showProgressBar();

    BooleanResult<AppleLoginModel> _appleLoginModelResult =
    await _customBaseViewModel.getAuthService().signInWithApple();

    _appleLoginModelResult.when(success: (AppleLoginModel appleLoginModel) {
      handleSocialLoginFlow(appleLoginModel: appleLoginModel);
    }, failure: (String error) async {
      await _customBaseViewModel.getAuthService().logOut();
      await _customBaseViewModel.stopProgressBar();
    });
  }


  handleSocialLoginFlow(
      {GoogleLoginModel? googleLoginModel,
        AppleLoginModel? appleLoginModel,
        FacebookLoginModel? facebookLoginModel}) async {
    CustomBaseViewModel _customBaseViewModel = getCustomBaseViewModel();

    String tokenId =
    (await _customBaseViewModel.getAuthService().getIdToken())!;

    String notificationToken =
    await _customBaseViewModel.getNotificationService().getFcmToken();

    if (notificationToken == "") {
      _customBaseViewModel.stopProgressBar();
      await _customBaseViewModel.getAuthService().logOut();
      return;
    }

    UserCreateModel _userCreateModel;
    loginMethodEnum _loginMethodEnum;

    if (googleLoginModel != null) {
      _userCreateModel = UserCreateModel(
          id: googleLoginModel.firebaseId,
          firebaseTokenId: tokenId,
          accountCreationMethod: loginMethodEnum.google.name,
          name: googleLoginModel.displayName,
          email: googleLoginModel.email,
          googleId: googleLoginModel.googleLoginId,
          firebaseNotificationTokenId: notificationToken);

      _loginMethodEnum = loginMethodEnum.google;
    } else if (facebookLoginModel != null) {
      _userCreateModel = UserCreateModel(
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
      _userCreateModel = UserCreateModel(
          id: appleLoginModel!.firebaseId,
          firebaseTokenId: tokenId,
          accountCreationMethod: loginMethodEnum.apple.name,
          name: appleLoginModel.displayName,
          email: appleLoginModel.email,
          appleId: appleLoginModel.appleLoginId,
          firebaseNotificationTokenId: notificationToken);

      _loginMethodEnum = loginMethodEnum.apple;
    }

    ApiResult<bool> createUserResult = await _customBaseViewModel
        .getDataManager()
        .createUser(_userCreateModel);

    FirebaseAnalyticsService _firebaseAnalyticsService =
    _customBaseViewModel.getAnalyticsService();

    createUserResult.when(success: (bool result) async {

      bool result = await _customBaseViewModel
          .getDataManager()
          .saveUserModel(_userCreateModel);
      if (result) {
        await _firebaseAnalyticsService.logSignUpEvent(_loginMethodEnum);
        _customBaseViewModel.stopProgressBar();
        _customBaseViewModel
            .getNavigationService()
            .pushNamedAndRemoveUntil(Routes.mainScreenView);
      }
    }, failure: (ApiErrorModel _errorModel) async {
      if (_errorModel.statusCode == 409) {
        String fcmToken =
        await _customBaseViewModel.getNotificationService().getFcmToken();

        if (fcmToken == "null") {
          _customBaseViewModel.showErrorDialog();
          return;
        }

        ApiResult<UserCreateModel> updateUserResult = await _customBaseViewModel
            .getDataManager()
            .updateFirebaseNotificationToken(fcmToken);

        updateUserResult.when(
            success: (UserCreateModel userUpdatedModel) async {
              bool result = await _customBaseViewModel
                  .getDataManager()
                  .saveUserModel(userUpdatedModel);
              if (result) {
                await _firebaseAnalyticsService.logLoginEvent(_loginMethodEnum);
                _customBaseViewModel.stopProgressBar();
                _customBaseViewModel
                    .getNavigationService()
                    .pushNamedAndRemoveUntil(Routes.mainScreenView);
              } else {
                await _customBaseViewModel.getAuthService().logOut();
                _customBaseViewModel.showErrorDialog();
              }
            }, failure: (ApiErrorModel errorModel) async {
          await _customBaseViewModel.getAuthService().logOut();
          _customBaseViewModel.showErrorDialog();
        });
      } else {
        await _customBaseViewModel.getAuthService().logOut();
        await _customBaseViewModel.showErrorDialog(
            description: _errorModel.errorMessage);
      }
    });
  }

  gotoLoginScreen() {
    getCustomBaseViewModel()
        .getNavigationService()
        .navigateTo(Routes.loginView);
  }
}
