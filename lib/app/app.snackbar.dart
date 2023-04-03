import 'package:baseproject/app/locator.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

import '../const/enums/snackbar_enum.dart';

void setupSnackBarUi() {
  final service = locator<SnackbarService>();

  service.registerCustomSnackbarConfig(
    variant: snackBarEnum.simpleSnackBar,
    config: SnackbarConfig(
        backgroundColor: Colors.black87,
        textColor: Colors.white,
        borderRadius: 1,
        snackStyle: SnackStyle.FLOATING,
        instantInit: true),
  );

  service.registerCustomSnackbarConfig(
    variant: snackBarEnum.successSnackBar,
    config: SnackbarConfig(
        backgroundColor: Colors.green,
        textColor: Colors.white,
        borderRadius: 1,
        snackStyle: SnackStyle.FLOATING,
        instantInit: true),
  );

  service.registerCustomSnackbarConfig(
    variant: snackBarEnum.errorSnackBar,
    config: SnackbarConfig(
        backgroundColor: Colors.red,
        textColor: Colors.white,
        borderRadius: 1,
        snackStyle: SnackStyle.FLOATING,
        instantInit: true),
  );

  service.registerCustomSnackbarConfig(
    variant: snackBarEnum.warningSnackBar,
    config: SnackbarConfig(
        backgroundColor: Colors.orange,
        textColor: Colors.white,
        borderRadius: 1,
        snackStyle: SnackStyle.FLOATING,
        instantInit: true),
  );
}
