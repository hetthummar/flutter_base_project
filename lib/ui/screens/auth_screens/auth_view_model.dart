import 'dart:async';

import 'package:fajrApp/app/locator.dart';
import 'package:fajrApp/base/custom_base_view_model.dart';
import 'package:fajrApp/const/enums/bottom_sheet_enums.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:stacked/stacked.dart';

class AuthViewModel extends IndexTrackingViewModel {
  CustomBaseViewModel customBaseViewModel = locator<CustomBaseViewModel>();

  int? resendToken;
  String verificationId = "";
  String fcmToken = "";
  int otpTimeOutStartingTime = 30;

  bool checkBoxValue = false;

  changeCheckBoxValue({required bool value}) {
    checkBoxValue = value;
    notifyListeners();
  }

  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  GlobalKey<FormState> otpFormKey = GlobalKey<FormState>();

  PhoneNumber currentUserPhoneNumber = PhoneNumber(
    isoCode: "IN",
    dialCode: "+91",
  );

  PhoneNumber initialPhoneNumber = PhoneNumber(
    isoCode: "IN",
    dialCode: "+91",
  );

  bool isValidPhoneNumber = false;
  bool isValidOtp = false;

  startReverseTimer() {
    otpTimeOutStartingTime = 60;
    notifyListeners();
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (otpTimeOutStartingTime > 0) {
        otpTimeOutStartingTime--;
      } else {
        timer.cancel();
      }
      notifyListeners();
    });
  }

  init() async {
    setBusy(true);

    initialPhoneNumber = PhoneNumber(
      dialCode: await customBaseViewModel.getAppUtils().getCountryCodeOfThisDevice(),
      isoCode: await customBaseViewModel.getAppUtils().getIOSCodeOfThisDevice(),
    );

    fcmToken = await customBaseViewModel.getNotificationService().getFcmToken();

    currentUserPhoneNumber = initialPhoneNumber;

    setBusy(false);
  }

  void setReverseTimer({required int index}) {
    if (currentIndex == 1) {
      startReverseTimer();
    }
    notifyListeners();
  }

  Future<bool> willPop(Function() backPressed) async {
    backPressed();
    notifyListeners();
    return false;
  }

  checkValidOTP() {
    String value = otpController.text;
    isValidOtp = value.length == 6;
    notifyListeners();
  }

  String? validateOTP(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter the OTP";
    }

    if (value.length < 6) {
      return "The entered OTP is invalid";
    }
    return null;
  }

  disposeViewModel() {
    phoneController.dispose();
  }

  void inputChanged(PhoneNumber value) async {
    currentUserPhoneNumber = value;

    isValidPhoneNumber = await customBaseViewModel.getAppUtils().isValidPhoneNumber(
          currentUserPhoneNumber.phoneNumber!,
          currentUserPhoneNumber.isoCode!,
        );
    notifyListeners();
  }

  // sendOTP({bool resend = false}) async {
  //   await FirebaseAuth.instance.setSettings(
  //     appVerificationDisabledForTesting: false,
  //     forceRecaptchaFlow: false,
  //   );
  //   if (resend == true) {
  //     otpController.clear();
  //   }
  //   customBaseViewModel.showProgressBar();
  //   try {
  //     FirebaseAuth.instance.verifyPhoneNumber(
  //       phoneNumber: currentUserPhoneNumber.phoneNumber,
  //       verificationCompleted: (PhoneAuthCredential phoneAuthCredential) async {
  //         signIn(phoneAuthCredential);
  //       },
  //       verificationFailed: (e) {
  //         customBaseViewModel.stopProgressBar();
  //         customBaseViewModel.showErrorSnackBar(e.message!);
  //         otpController.clear();
  //       },
  //       codeSent: (verificationId, resendToken) {
  //         customBaseViewModel.stopProgressBar();
  //         this.verificationId = verificationId;
  //         this.resendToken = resendToken;
  //
  //         if (!resend) {
  //           customBaseViewModel.stopProgressBar();
  //           setIndex(1);
  //         } else {
  //           startReverseTimer();
  //         }
  //       },
  //       codeAutoRetrievalTimeout: (verificationId) {
  //         customBaseViewModel.stopProgressBar();
  //         customBaseViewModel.showErrorSnackBar("OTP expired");
  //       },
  //       timeout: const Duration(seconds: 60),
  //       forceResendingToken: resendToken,
  //     );
  //   } on FirebaseAuthException catch (e) {
  //     customBaseViewModel.showErrorSnackBar(e.message ?? "Something went wrong");
  //   } catch (e) {
  //     customBaseViewModel.showErrorSnackBar("Something went wrong");
  //   }
  // }

  sendOtp({bool resend = false}) async {
    await FirebaseAuth.instance.setSettings(
      appVerificationDisabledForTesting: false,
      forceRecaptchaFlow: false,
    );

    if (resend) {
      otpController.clear();
    }
    customBaseViewModel.showProgressBar();

    try {
      FirebaseAuth.instance.verifyPhoneNumber(
        verificationCompleted: (phoneAuthCredential) async {
          signIn(phoneAuthCredential);
        },
        verificationFailed: (error) {
          customBaseViewModel.stopProgressBar();
          customBaseViewModel.showErrorSnackBar(error.message!);
          otpController.clear();
        },
        codeSent: (verificationId, forceResendingToken) {
          customBaseViewModel.stopProgressBar();
          verificationId = verificationId;
          resendToken = forceResendingToken;

          if (!reverse) {
            customBaseViewModel.stopProgressBar();
            setIndex(1);
          } else {
            startReverseTimer();
          }
        },
        codeAutoRetrievalTimeout: (verificationId) {
          verificationId = verificationId;
        },
        timeout: const Duration(seconds: 60),
        forceResendingToken: resendToken,
      );
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      customBaseViewModel.showErrorSnackBar(e.message ?? "Something went wrong");
    }
  }

  submitOTP() async {
    AuthCredential authCred = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: otpController.text,
    );
    await signIn(authCred);
  }

  signIn(AuthCredential authCredential) async {
    customBaseViewModel.showProgressBar();
    String returnValue = await customBaseViewModel.getAuthService().signInWithCredential(authCredential);
    if (returnValue == "noError") {
    } else if (returnValue == "error") {
      customBaseViewModel.showErrorDialog();
    } else {
      customBaseViewModel.stopProgressBar();
      customBaseViewModel.showErrorSnackBar(returnValue);
    }
  }

  Future<void> authenticate() async {
    customBaseViewModel.getBottomSheetService().showCustomSheet(
          variant: BottomSheetEnum.auth,
          isScrollControlled: true,
        );
  }

  // createAccountWithGoogle() async {
  //   customBaseViewModel.showProgressBar();
  //
  //   BooleanResult<GoogleLoginModel> googleLoginModelResult = await customBaseViewModel.getAuthService().signInWithGoogle();
  //
  //   googleLoginModelResult.when(success: (GoogleLoginModel googleLoginModel) {
  //     handleSocialLoginFlow(googleLoginModel: googleLoginModel);
  //   }, failure: (String error) async {
  //     await customBaseViewModel.getAuthService().logOut();
  //     await customBaseViewModel.stopProgressBar();
  //   });
  // }
  //
  // createAccountWithFacebook() async {
  //   customBaseViewModel.showProgressBar();
  //
  //   BooleanResult<FacebookLoginModel> facebookLoginModel = await customBaseViewModel.getAuthService().signInWithFacebook();
  //
  //   facebookLoginModel.when(success: (FacebookLoginModel facebookLoginModel) {
  //     handleSocialLoginFlow(facebookLoginModel: facebookLoginModel);
  //   }, failure: (String error) async {
  //     await customBaseViewModel.getAuthService().logOut();
  //     await customBaseViewModel.stopProgressBar();
  //   });
  // }
  //
  // createAccountWithApple() async {
  //   customBaseViewModel.showProgressBar();
  //
  //   BooleanResult<AppleLoginModel> appleLoginModelResult = await customBaseViewModel.getAuthService().signInWithApple();
  //
  //   appleLoginModelResult.when(success: (AppleLoginModel appleLoginModel) {
  //     handleSocialLoginFlow(appleLoginModel: appleLoginModel);
  //   }, failure: (String error) async {
  //     await customBaseViewModel.getAuthService().logOut();
  //     await customBaseViewModel.stopProgressBar();
  //   });
  // }
  //
  // handleSocialLoginFlow({
  //   GoogleLoginModel? googleLoginModel,
  //   AppleLoginModel? appleLoginModel,
  //   FacebookLoginModel? facebookLoginModel,
  // }) async {
  //   String tokenId = (await customBaseViewModel.getAuthService().getIdToken())!;
  //
  //   String notificationToken = await customBaseViewModel.getNotificationService().getFcmToken();
  //
  //   if (notificationToken == "") {
  //     customBaseViewModel.stopProgressBar();
  //     await customBaseViewModel.getAuthService().logOut();
  //     return;
  //   }
  //
  //   UserCreateModel userCreateModel;
  //   loginMethodEnum _loginMethodEnum;
  //
  //   if (googleLoginModel != null) {
  //     userCreateModel = UserCreateModel(
  //         id: googleLoginModel.firebaseId,
  //         firebaseTokenId: tokenId,
  //         accountCreationMethod: loginMethodEnum.google.name,
  //         name: googleLoginModel.displayName,
  //         email: googleLoginModel.email,
  //         googleId: googleLoginModel.googleLoginId,
  //         firebaseNotificationTokenId: notificationToken);
  //
  //     _loginMethodEnum = loginMethodEnum.google;
  //   } else if (facebookLoginModel != null) {
  //     userCreateModel = UserCreateModel(
  //         id: facebookLoginModel.firebaseId,
  //         firebaseTokenId: tokenId,
  //         accountCreationMethod: loginMethodEnum.facebook.name,
  //         name: facebookLoginModel.displayName,
  //         email: facebookLoginModel.email,
  //         facebookId: facebookLoginModel.facebookLoginId,
  //         firebaseNotificationTokenId: notificationToken);
  //
  //     _loginMethodEnum = loginMethodEnum.facebook;
  //   } else {
  //     //replace this model with apple
  //     userCreateModel = UserCreateModel(
  //         id: appleLoginModel!.firebaseId,
  //         firebaseTokenId: tokenId,
  //         accountCreationMethod: loginMethodEnum.apple.name,
  //         name: appleLoginModel.displayName,
  //         email: appleLoginModel.email,
  //         appleId: appleLoginModel.appleLoginId,
  //         firebaseNotificationTokenId: notificationToken);
  //
  //     _loginMethodEnum = loginMethodEnum.apple;
  //   }
  //
  //   ApiResult<bool> createUserResult = await customBaseViewModel.getUserApiService().createUser(userCreateModel);
  //
  //   FirebaseAnalyticsService firebaseAnalyticsService = customBaseViewModel.getAnalyticsService();
  //
  //   createUserResult.when(success: (bool result) async {
  //     bool result = await customBaseViewModel.getSharedPreferenceService().saveUserModel(userCreateModel);
  //     if (result) {
  //       await firebaseAnalyticsService.logSignUpEvent(_loginMethodEnum);
  //       customBaseViewModel.stopProgressBar();
  //       customBaseViewModel.getNavigationService().pushNamedAndRemoveUntil(Routes.mainScreenView);
  //     }
  //   }, failure: (ApiErrorModel _errorModel) async {
  //     if (_errorModel.statusCode == 409) {
  //       String fcmToken = await customBaseViewModel.getNotificationService().getFcmToken();
  //
  //       if (fcmToken == "null") {
  //         customBaseViewModel.showErrorDialog();
  //         return;
  //       }
  //
  //       ApiResult<UserCreateModel> updateUserResult = await customBaseViewModel.getUserApiService().updateFirebaseNotificationToken(fcmToken);
  //
  //       updateUserResult.when(success: (UserCreateModel userUpdatedModel) async {
  //         bool result = await customBaseViewModel.getSharedPreferenceService().saveUserModel(userUpdatedModel);
  //         if (result) {
  //           await firebaseAnalyticsService.logLoginEvent(_loginMethodEnum);
  //           customBaseViewModel.stopProgressBar();
  //           customBaseViewModel.getNavigationService().pushNamedAndRemoveUntil(Routes.mainScreenView);
  //         } else {
  //           await customBaseViewModel.getAuthService().logOut();
  //           customBaseViewModel.showErrorDialog();
  //         }
  //       }, failure: (ApiErrorModel errorModel) async {
  //         await customBaseViewModel.getAuthService().logOut();
  //         customBaseViewModel.showErrorDialog();
  //       });
  //     } else {
  //       await customBaseViewModel.getAuthService().logOut();
  //       await customBaseViewModel.showErrorDialog(description: _errorModel.errorMessage);
  //     }
  //   });
  // }

  gotoLoginView() {
    setIndex(0);
  }

  gotoOTPView() {
    setIndex(1);
  }

  gotoUserNameView() {
    setIndex(2);
  }
}
