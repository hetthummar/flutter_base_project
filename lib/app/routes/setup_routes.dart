import 'package:fajrApp/ui/screens/auth_screens/auth_view.dart';
import 'package:fajrApp/ui/screens/main_screen/fragments/add_screen/add_video_view.dart';
import 'package:fajrApp/ui/screens/main_screen/fragments/analytics_screen/analytics_view.dart';
import 'package:fajrApp/ui/screens/main_screen/fragments/home_screen/home_view.dart';
import 'package:fajrApp/ui/screens/main_screen/fragments/profile_screen/profile_view.dart';
import 'package:fajrApp/ui/screens/main_screen/fragments/search_screen/search_view.dart';
import 'package:fajrApp/ui/screens/main_screen/main_screen_view.dart';
import 'package:fajrApp/ui/screens/startup/startup_view.dart';
import 'package:stacked/stacked_annotations.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: StartUpView, initial: true),
    MaterialRoute(page: MainScreenView),
    MaterialRoute(page: AuthView),
    MaterialRoute(page: HomeView),
    MaterialRoute(page: SearchView),
    MaterialRoute(page: AddVideoView),
    MaterialRoute(page: AnalyticsView),
    MaterialRoute(page: ProfileView),
  ],
)
class AppSetup {}
