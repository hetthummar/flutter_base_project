import 'package:baseproject/base/custom_base_view_model.dart';
import 'package:baseproject/data/network/api_service/user_api_service.dart';
import 'package:baseproject/data/prefs/shared_preference_service.dart';
import 'package:baseproject/services/firebase_auth_service.dart';
import 'package:baseproject/services/firebase_notification_service.dart';
import 'package:baseproject/ui/screens/auth_screens/auth_view_model.dart';
import 'package:baseproject/ui/screens/main_screen/fragments/home/home_view_model.dart';
import 'package:baseproject/ui/screens/main_screen/fragments/profile/profile_view_model.dart';
import 'package:baseproject/ui/screens/main_screen/main_screen_view_model.dart';
import 'package:baseproject/ui/screens/startup/startup_view_model.dart';
import 'package:baseproject/utils/client.dart';
import 'package:get_it/get_it.dart';
import 'package:stacked_services/stacked_services.dart';

import '../services/firebase_analytics_service.dart';
import '../services/firebase_crashlytics_service.dart';

GetIt locator = GetIt.I;

// @stacked-service
void setupLocator() {
  locator.registerLazySingleton(() => BottomSheetService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => SnackbarService());
  locator.registerLazySingleton(() => FirebaseNotificationService());
  locator.registerLazySingleton(() => FirebaseCrashlyticsService());
  locator.registerLazySingleton(() => FirebaseAuthService());
  locator.registerLazySingleton(() => FirebaseAnalyticsService());
  // locator.registerLazySingleton(() => FirebasePerformanceService());

  //Data
  locator.registerLazySingleton(() => Client());
  locator.registerLazySingleton(() => SharedPreferenceService());

  //Api Services
  locator.registerLazySingleton(() => UserApiService());

  //View Models
  locator.registerLazySingleton(() => AuthViewModel());
  locator.registerLazySingleton(() => MainScreenViewModel());
  locator.registerLazySingleton(() => HomeViewModel());
  locator.registerLazySingleton(() => StartUpViewModel());
  locator.registerLazySingleton(() => CustomBaseViewModel());
  locator.registerLazySingleton(() => ProfileViewModel());
}
