import 'dart:async';
import 'dart:io';

import 'package:baseproject/app/app.bottomsheets.dart';
import 'package:baseproject/app/app.dialog.dart';
import 'package:baseproject/app/app.snackbar.dart';
import 'package:baseproject/app/locator.dart';
import 'package:baseproject/app/routes/setup_routes.router.dart';
import 'package:baseproject/const/app_const.dart';
import 'package:baseproject/const/enums/bottom_sheet_enums.dart';
import 'package:baseproject/const/enums/snackbar_enum.dart';
import 'package:baseproject/data/network/api_service/user_api_service.dart';
import 'package:baseproject/data/prefs/shared_preference_service.dart';
import 'package:baseproject/main.dart';
import 'package:baseproject/services/firebase_analytics_service.dart';
import 'package:baseproject/services/firebase_auth_service.dart';
import 'package:baseproject/services/firebase_dynamic_link_service.dart';
import 'package:baseproject/services/firebase_notification_service.dart';
import 'package:baseproject/utils/app_util.dart';
import 'package:baseproject/utils/results/boolean_result/boolean_result.dart';
import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:image_size_getter/file_input.dart';
import 'package:image_size_getter/image_size_getter.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomBaseViewModel extends BaseViewModel {

  //region STACKED-SERVICE
  NavigationService getNavigationService() => locator<NavigationService>();

  BottomSheetService getBottomSheetService() => locator<BottomSheetService>();

  DialogService getDialogService() => locator<DialogService>();

  SnackbarService getSnackBarService() => locator<SnackbarService>();
  //endregion

  //region FIREBASE-SERVICE
  FirebaseNotificationService getNotificationService() =>
      locator<FirebaseNotificationService>();

  FirebaseAuthService getAuthService() => locator<FirebaseAuthService>();

  FirebaseAnalyticsService getAnalyticsService() =>
      locator<FirebaseAnalyticsService>();

  FirebaseDynamicLinkService getFirebaseDynamicLinkService() =>
      locator<FirebaseDynamicLinkService>();
  //endregion

  //region SHARED-PREFERENCE-SERVICE
  SharedPreferenceService getSharedPreferenceService() =>
      locator<SharedPreferenceService>();
  //endregion

  //region API-SERVICE
  UserApiService getUserApiService() => locator<UserApiService>();
  //endregion

  //region EASY-LOADING
  showProgressBar({String title = "Please wait..."}) {
    EasyLoading.show(status: title);
  }

  showEasySuccess({String title = "Please wait..."}) {
    EasyLoading.showSuccess(title);
  }

  showEasyFailure({String title = "Please wait..."}) {
    EasyLoading.showError(title);
  }

  stopProgressBar() {
    EasyLoading.dismiss();
  }
  //endregion

  //region SNACK-BAR HANDLING
  showSnackBar(String message, {Function? onTap}) {
    Duration toastDuration = const Duration(seconds: 2);

    if (AppUtils().isAndroid()) {
      getSnackBarService().showCustomSnackBar(
        variant: snackBarEnum.simpleSnackBar,
        message: message,
        duration: toastDuration,
        onTap: (_) {
          if (onTap != null) {
            onTap();
          }
        },
      );
    } else {
      EasyLoading.showToast(message,
          duration: toastDuration, maskType: EasyLoadingMaskType.clear);
    }
  }

  showSuccessSnackBar(String message, {Duration? duration}) {
    Duration toastDuration = duration ?? const Duration(milliseconds: 1200);

    getSnackBarService().showCustomSnackBar(
        variant: snackBarEnum.successSnackBar,
        message: message,
        duration: toastDuration,
        onTap: () {});
  }

  showErrorSnackBar(String message, {Duration? duration}) {
    Duration toastDuration = duration ?? const Duration(milliseconds: 2200);

    getSnackBarService().showCustomSnackBar(
        variant: snackBarEnum.errorSnackBar,
        message: message,
        duration: toastDuration,
        onTap: () {});
  }

  showWarningSnackBar(String message, {Duration? duration}) {
    Duration toastDuration = duration ?? const Duration(milliseconds: 2200);

    getSnackBarService().showCustomSnackBar(
        variant: snackBarEnum.warningSnackBar,
        message: message,
        duration: toastDuration,
        onTap: () {});
  }
  //endregion

  //region DIALOG HANDLING
  logout(
      {bool shouldRedirectToAuthenticationPage = true,
      bool shouldShowDialog = false}) async {
    DialogResponse? dialogResponse;

    if (shouldShowDialog) {
      dialogResponse = await getDialogService().showDialog(
          title: "Logout?",
          description: "Would you like to log out of your account",
          cancelTitle: 'Cancel',
          buttonTitleColor: $styles.colors.white,
          cancelTitleColor: $styles.colors.white);
    } else {
      dialogResponse = DialogResponse(confirmed: true);
    }

    if (dialogResponse!.confirmed) {
      showProgressBar();
      await resetApp();
      await getAuthService().logOut();
      await resetLocator();

      stopProgressBar();
      if (shouldRedirectToAuthenticationPage) {
        getNavigationService().clearStackAndShow(Routes.authView);
      }
    } else {
      return false;
    }
  }

  showErrorDialog(
      {String title = "Problem occurred",
      String description = "Some problem occurred Please try again",
      bool isDismissible = true}) async {
    stopProgressBar();

    if (AppUtils().isAndroid()) {
      await getBottomSheetService().showCustomSheet(
          title: title,
          description: description,
          mainButtonTitle: "OK",
          variant: bottomSheetEnum.error,
          barrierDismissible: isDismissible);
    } else {
      getDialogService().showDialog(
        title: title,
        description: description,
        barrierDismissible: isDismissible,
        buttonTitleColor: $styles.colors.white,
      );
    }
  }
  //endregion

  //region PERMISSIONS HANDLING
  Future<bool> askNotificationPermission() async {
    PermissionStatus permission = await Permission.notification.status;
    if (permission == PermissionStatus.granted) return true;

    if (permission == PermissionStatus.denied) {
      PermissionStatus permissionStatus =
          await Permission.notification.request();
      return permissionStatus == PermissionStatus.granted;
    }

    return (await Permission.notification.status) == (PermissionStatus.granted);
  }

  Future<bool> askPhotosPermission({String? title, String? description}) async {
    if (AppUtils().isAndroid()) {
      return askAndroidPhotoPermission();
    } else {
      return askIOSPhotoPermission();
    }
  }

  Future<bool> askCameraPermission({String? title, String? description}) async {
    if (AppUtils().isAndroid()) {
      return askAndroidCameraPermission();
    } else {
      return askIOSCameraPermission();
    }
  }

  Future<bool> askAndroidPhotoPermission(
      {String? title, String? description}) async {
    bool permissionGranted = false;
    bool shouldShowRationalBefore =
        await Permission.storage.shouldShowRequestRationale;
    PermissionStatus permissionStatus = await Permission.storage.request();
    if (permissionStatus == PermissionStatus.granted) {
      permissionGranted = true;
    } else {
      bool shouldShowRationalAfter =
          await Permission.storage.shouldShowRequestRationale;
      if (shouldShowRationalBefore == shouldShowRationalAfter) {
        DialogResponse? dialogResponse = await getDialogService().showDialog(
            title:
                title ?? '${AppConst.appName} would like to access your photos',
            description: description ??
                'Allows “${AppConst.appName}” to access your photos so you can select photos',
            cancelTitle: 'Cancel',
            buttonTitleColor: $styles.colors.white,
            cancelTitleColor: $styles.colors.white);

        if (dialogResponse != null && dialogResponse.confirmed) {
          await openAppSettings();
        } else {
          permissionGranted = false;
        }
      }
    }
    return permissionGranted;
  }

  Future<bool> askAndroidCameraPermission(
      {String? title, String? description}) async {
    bool permissionGranted = false;
    bool shouldShowRationalBefore =
        await Permission.camera.shouldShowRequestRationale;
    PermissionStatus permissionStatus = await Permission.camera.request();
    if (permissionStatus == PermissionStatus.granted) {
      permissionGranted = true;
    } else {
      bool shouldShowRationalAfter =
          await Permission.camera.shouldShowRequestRationale;
      if (shouldShowRationalBefore == shouldShowRationalAfter) {
        DialogResponse? dialogResponse = await getDialogService().showDialog(
            title:
                title ?? '${AppConst.appName} would like to access your camera',
            description: description ??
                'Allows “${AppConst.appName}” to access your camera so you can take picture',
            cancelTitle: 'Cancel',
            buttonTitleColor: $styles.colors.white,
            cancelTitleColor: $styles.colors.white);

        if (dialogResponse != null && dialogResponse.confirmed) {
          await openAppSettings();
        } else {
          permissionGranted = false;
        }
      }
    }
    return permissionGranted;
  }

  Future<bool> askIOSPhotoPermission(
      {String? title, String? description}) async {
    bool permissionGranted = false;
    PermissionStatus permissionStatus = await Permission.photos.status;

    if (permissionStatus == PermissionStatus.granted) {
      permissionGranted = true;
    } else if (permissionStatus == PermissionStatus.denied) {
      PermissionStatus permissionStatus = await Permission.photos.request();
      permissionGranted = (permissionStatus == PermissionStatus.granted);
    } else {
      print("permission : ");

      DialogResponse? dialogResponse = await getDialogService().showDialog(
        title: title ?? '${AppConst.appName} would like to access your photos',
        description: description ??
            'Allows “${AppConst.appName}” to access your photos so you can share your folders',
        cancelTitle: 'Cancel',
        buttonTitleColor: $styles.colors.white,
        cancelTitleColor: $styles.colors.white,
      );

      if (dialogResponse != null && dialogResponse.confirmed) {
        await openAppSettings();
      } else {
        permissionGranted = false;
      }
    }

    return permissionGranted;
  }

  Future<bool> askIOSCameraPermission(
      {String? title, String? description}) async {
    bool permissionGranted = false;
    PermissionStatus permissionStatus = await Permission.camera.status;

    if (permissionStatus == PermissionStatus.granted) {
      permissionGranted = true;
    } else if (permissionStatus == PermissionStatus.denied) {
      PermissionStatus permissionStatus = await Permission.camera.request();
      permissionGranted = (permissionStatus == PermissionStatus.granted);
    } else {

      DialogResponse? dialogResponse = await getDialogService().showDialog(
        title: title ?? '${AppConst.appName} would like to access your camera',
        description: description ??
            'Allows “${AppConst.appName}” to access your camera so you can share your folders',
        cancelTitle: 'Cancel',
        buttonTitleColor: $styles.colors.white,
        cancelTitleColor: $styles.colors.white,
      );

      if (dialogResponse != null && dialogResponse.confirmed) {
        await openAppSettings();
      } else {
        permissionGranted = false;
      }
    }

    return permissionGranted;
  }
  //endregion

  //region link HANDLING
  Future launchLink(String? url) async {
    if (url == null) {
      return;
    }

    try {
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url));
      }
    } catch (e) {
      showErrorSnackBar("Some problem occurred while opening link. Please try again later.");
    }
  }
  //endregion

  //region IMAGE HANDLING
  Size getSizeOfImage(String filePath) {
    return ImageSizeGetter.getSize(FileInput(File(filePath)));
  }

  Future<BooleanResult<String>> downloadAndSaveImageLocally(
      String imageUrl) async {
    try {
      Response response = await Dio()
          .get(imageUrl, options: Options(responseType: ResponseType.bytes));

      Directory documentDirectory = await getApplicationDocumentsDirectory();
      File file =
          File(join(documentDirectory.path, "${AppUtils().getRandomId()}.jpg"));
      file.writeAsBytesSync(response.data);
      return BooleanResult.success(data: file.path);
    } catch (e) {
      return BooleanResult.failure(error: e.toString());
    }
  }

  Future<BooleanResult<String>> compressImage(String filePath) async {
    try {
      File file = await FlutterNativeImage.compressImage(
        filePath,
        percentage: 96,
        quality: 96,
      );
      return BooleanResult.success(data: file.path);
    } catch (e) {
      return BooleanResult.failure(error: e.toString());
    }
  }

  Future<BooleanResult<String>> shareImage(String imageUrl) async {
    showProgressBar();
    try {
      Response response = await Dio()
          .get(imageUrl, options: Options(responseType: ResponseType.bytes));
      Directory tempDir = await getApplicationDocumentsDirectory();
      File file = File('${tempDir.path}/${AppUtils().getRandomId()}.jpg');
      await file.writeAsBytes(response.data);
      Share.shareXFiles([XFile(file.path)]);
      stopProgressBar();
      return BooleanResult.success(data: file.path);
    } catch (e) {
      stopProgressBar();
      showErrorSnackBar(e.toString());
      return BooleanResult.failure(error: e.toString());
    }

  }
  //endregion

  //region NAVIGATION HANDLING
  gotoStartUpScreen() {
    resetLocator();
    getNavigationService().clearStackAndShow(Routes.startUpView);
  }

  goToPreviousScreen() {
    getNavigationService().back();
  }
  //endregion

  //region APP HANDLING
  resetApp() async {
    await getSharedPreferenceService().clearSharedPreference();
    await getNotificationService().resetBadgeCount();
    await getNotificationService().cancelAllNotifications();
    await getNotificationService().deleteInstanceId();
  }

  resetLocator() async {
    await locator.reset(dispose: true);
    setupLocator();
    setupSnackBarUi();
    setUpBototmSheet();
    setupDialogUi();
  }
  //endregion

}
