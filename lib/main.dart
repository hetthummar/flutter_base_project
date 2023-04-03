import 'dart:async';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:baseproject/app/app.bottomsheets.dart';
import 'package:baseproject/app/app.dialog.dart';
import 'package:baseproject/app/app.snackbar.dart';
import 'package:baseproject/app/routes/setup_routes.router.dart';
import 'package:baseproject/const/app_const.dart';
import 'package:baseproject/services/firebase_notification_service.dart';
import 'package:baseproject/styles/styles.dart';
import 'package:baseproject/utils/app_util.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:sized_context/sized_context.dart';
import 'package:stacked_services/stacked_services.dart';

import 'app/locator.dart';
import 'config/theme_config.dart';
import 'services/firebase_analytics_service.dart';

void main() {
  print("App Started ");

  runZonedGuarded(() {
    WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
    FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
        .then((_) async {
      await Firebase.initializeApp();

      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
      FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
      if (!kReleaseMode) {
        FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
      } else {
        FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
      }

      // await dotenv.load(fileName: ".env");

      await AwesomeNotifications().initialize(
        null,
        [
          NotificationChannel(
            channelKey: AppConst.notificationChannelKey,
            channelName: 'Basic notifications',
            channelDescription: 'Notification channel for basic tests',
            ledColor: Colors.white,
          ),
        ],
      );

      setupLocator();
      setupSnackBarUi();
      setUpBototmSheet();
      setupDialogUi();

      FirebaseNotificationService notificationService =
          locator<FirebaseNotificationService>();
      notificationService.initMessaging();

      FlutterNativeSplash.remove();

      print("Running APP");
      runApp(const MyApp());
    });
  }, (error, trace) async {
    // await FirebaseCrashlytics.instance
    //     .recordError(error, trace, reason: "mainDart Error");
  });
}

// Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   if (message.data != null && message.data.keys.isNotEmpty) {
//     await showNotification(
//       message.data['title'],
//       message.data['body'],
//       message.data['type'],
//       image: message.data['type'],
//       id: message.data['id'],
//     );
//   }
// }

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static AppStyle _style = AppStyle();
  static AppStyle get style => _style;

  @override
  Widget build(BuildContext context) {
    print("Main View Building");

    AppUtils().easyLoadingInit();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppConst.appName,
      navigatorKey: StackedService.navigatorKey,
      builder: EasyLoading.init(
        builder: (context, child) {
          _style = AppStyle(screenSize: context.sizePx);
          return child!;
        },
      ),
      onGenerateRoute: StackedRouter().onGenerateRoute,
      initialRoute: "/",
      navigatorObservers: [
        locator<FirebaseAnalyticsService>().getAnalyticsObserver(),
      ],
      theme: ThemeConfig().themeData,
    );
  }
}

AppStyle get $styles => MyApp.style;
