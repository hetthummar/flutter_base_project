import 'package:baseproject/app/routes/setup_routes.router.dart';
import 'package:baseproject/base/custom_base_view_model.dart';
import 'package:baseproject/models/user/user_create_model.dart';

class StartUpViewModel extends CustomBaseViewModel {
  runStartupLogic() async {
    bool isLoggedIn = await getAuthService().isUserLoggedIn();
    UserCreateModel? userBasicDataOfflineModel =
        await getSharedPreferenceService().getUserModel();

    if (isLoggedIn && userBasicDataOfflineModel != null) {
      getNavigationService().clearStackAndShow(Routes.mainScreenView);
    } else {
      await getAuthService().logOut();
      getNavigationService().clearStackAndShow(Routes.authView);
    }
  }
}
