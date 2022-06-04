import 'dart:async';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:baseproject/app/routes/setup_routes.router.dart';
import 'package:baseproject/app/setup_snackbar.dart';
import 'package:baseproject/const/app_const.dart';
import 'package:baseproject/services/firebase_notification_service.dart';
import 'package:baseproject/utils/app_util.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stacked_services/stacked_services.dart';
import 'app/locator.dart';
import 'app/setup_bottom_sheet.dart';
import 'app/setup_dilog.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'config/color_config.dart';
import 'config/theme_config.dart';
import 'services/firebase_analytics_service.dart';

void main() {
  print("App Started ");

  runZonedGuarded(() {
    WidgetsFlutterBinding.ensureInitialized();

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
      print("HIHI 9");

      FirebaseNotificationService _notificationService =
          locator<FirebaseNotificationService>();
      _notificationService.initMessaging();

      runApp(const MyApp());
    });
  }, (error, trace) async {
    // await FirebaseCrashlytics.instance
    //     .recordError(error, trace, reason: "mainDart Error");
  });
}

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if (message.data != null && message.data.keys.isNotEmpty) {
    await showNotification(
      message.data['title'],
      message.data['body'],
      message.data['type'],
      image: message.data['type'],
      id: message.data['id'],
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("App Started - Main View Building");

    AppUtils().easyLoadingInit();

    return ScreenUtilInit(
      designSize: const Size(360, 800),
      builder: (child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Test App',
          navigatorKey: StackedService.navigatorKey,
          onGenerateRoute: StackedRouter().onGenerateRoute,
          initialRoute: "/",
          navigatorObservers: [
            locator<FirebaseAnalyticsService>().getAnalyticsObserver(),
          ],
          theme: ThemeConfig().themeData,
        );
      },
    );
  }
}
