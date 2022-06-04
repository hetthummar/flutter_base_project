import 'package:baseproject/ui/screens/auth_screens/auth_view.dart';
import 'package:baseproject/ui/screens/auth_screens/fragments/login/login_view.dart';
import 'package:baseproject/ui/screens/auth_screens/fragments/signup/signup_view.dart';
import 'package:baseproject/ui/screens/main_screen/main_screen_view.dart';
import 'package:baseproject/ui/screens/startup/startup_view.dart';
import 'package:stacked/stacked_annotations.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: StartUpView, initial: true),
    MaterialRoute(page: MainScreenView),
    MaterialRoute(page: AuthView),
    MaterialRoute(page: LoginView),
    MaterialRoute(page: SignUpView),
  ],
)
class AppSetup {}
