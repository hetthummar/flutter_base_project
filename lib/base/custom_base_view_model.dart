import 'package:baseproject/app/locator.dart';
import 'package:baseproject/app/routes/setup_routes.router.dart';
import 'package:baseproject/const/enums/bottom_sheet_enums.dart';
import 'package:baseproject/const/enums/snackbar_enum.dart';
import 'package:baseproject/data/data_manager.dart';
import 'package:baseproject/data/prefs/shared_preference_service.dart';
import 'package:baseproject/services/firebase_analytics_service.dart';
import 'package:baseproject/services/firebase_auth_service.dart';
import 'package:baseproject/services/firebase_notification_service.dart';
import 'package:baseproject/utils/app_util.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../const/enums/dialogs_enum.dart';

class CustomBaseViewModel extends BaseViewModel {
  final FirebaseAuthService _firebaseAuthService =
      locator<FirebaseAuthService>();

  final FirebaseNotificationService _firebaseNotificationService =
      locator<FirebaseNotificationService>();
  final SharedPreferenceService _sharedPreferenceService =
      locator<SharedPreferenceService>();

  final NavigationService _navigationService = locator<NavigationService>();
  final BottomSheetService _bottomSheetService = locator<BottomSheetService>();
  final DialogService _dialogService = locator<DialogService>();
  final DataManager _dataManager = locator<DataManager>();
  final SnackbarService _snackBarService = locator<SnackbarService>();

  FirebaseAuthService getAuthService() => _firebaseAuthService;

  FirebaseNotificationService getNotificationService() =>
      _firebaseNotificationService;

  final FirebaseAnalyticsService _firebaseAnalyticsService =
  locator<FirebaseAnalyticsService>();

  NavigationService getNavigationService() => _navigationService;

  BottomSheetService getBottomSheetService() => _bottomSheetService;

  DialogService getDialogService() => _dialogService;

  SnackbarService getSnackBarService() => _snackBarService;

  FirebaseAnalyticsService getAnalyticsService() => _firebaseAnalyticsService;

  DataManager getDataManager() => _dataManager;

  SharedPreferenceService getSharedPreferenceService() =>
      _sharedPreferenceService;



  refreshScreen() {
    notifyListeners();
  }

  showProgressBar({String title = "Please wait..."}) {
    EasyLoading.show(status: title);
  }

  stopProgressBar() {
    EasyLoading.dismiss();
  }

  showSnackBar(String message) {

    Duration toastDuration = const Duration(seconds: 2);

    if (AppUtils().isAndroid()) {
      _snackBarService.showCustomSnackBar(
        variant: snackBarEnum.simpleSnackBar,
        message: message,
        duration: toastDuration,
        onTap: (_) {},
      );
    } else {
      EasyLoading.showToast(message,
          duration: toastDuration, maskType: EasyLoadingMaskType.clear);
    }
  }

  goToPreviousScreen() {
    getNavigationService().back();
  }

  logout(
      {bool shouldRedirectToAuthenticationPage = true,
      bool shouldShowDialog = false}) async {
    String dialogTitle = "Are you sure?";
    String dialogDescription = "Do you want to logout from your account";

    DialogResponse? _dialogResponse;

    if (shouldShowDialog) {
      if (AppUtils().isAndroid()) {
        _dialogResponse = await getDialogService().showCustomDialog(
            variant: dialogEnum.confirmation,
            title: dialogTitle,
            description: dialogDescription);
      } else {
        _dialogResponse = await getDialogService().showConfirmationDialog(
          title: dialogTitle,
          description: dialogDescription,
        );
      }
    } else {
      _dialogResponse = DialogResponse(confirmed: true);
    }

    if (_dialogResponse!.confirmed) {
      showProgressBar();
      await getDataManager().clearSharedPreference();
      await getAuthService().logOut();

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
      await _bottomSheetService.showCustomSheet(
          title: title,
          description: description,
          mainButtonTitle: "OK",
          variant: bottomSheetEnum.error,
          barrierDismissible: isDismissible);
    } else {
      getDialogService().showDialog(
          title: title,
          description: description,
          barrierDismissible: isDismissible);
    }
  }

  showSuccessSnackBar(String message, {Duration? duration}) {
    Duration toastDuration = duration ?? const Duration(milliseconds: 1200);

    _snackBarService.showCustomSnackBar(
        variant: snackBarEnum.successSnackBar,
        message: message,
        duration: toastDuration,
        onTap: () {});
  }

  showErrorSnackBar(String message, {Duration? duration}) {
    Duration toastDuration = duration ?? const Duration(milliseconds: 1200);

    _snackBarService.showCustomSnackBar(
        variant: snackBarEnum.errorSnackBar,
        message: message,
        duration: toastDuration,
        onTap: () {});
  }

  showWarningSnackBar(String message, {Duration? duration}) {
    Duration toastDuration = duration ?? const Duration(milliseconds: 1200);

    _snackBarService.showCustomSnackBar(
        variant: snackBarEnum.warningSnackBar,
        message: message,
        duration: toastDuration,
        onTap: () {});
  }

}
