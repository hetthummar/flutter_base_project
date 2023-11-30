import 'package:fajrApp/base/custom_base_view_model.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class LocalAuthApi {
  final auth = LocalAuthentication();
  CustomBaseViewModel customBaseViewModel = CustomBaseViewModel();

  Future<bool> authenticate() async {
    bool isAvailable = await auth.canCheckBiometrics;
    if (!isAvailable) return false;

    try {
      await auth.authenticate(
        localizedReason: "Scan for Authentication",
        options: const AuthenticationOptions(
          stickyAuth: true,
          useErrorDialogs: true,
        ),
      );
      return true;
    } on PlatformException catch (e) {
      customBaseViewModel.showErrorSnackBar(e.message.toString());
      return false;
    }
  }
}
