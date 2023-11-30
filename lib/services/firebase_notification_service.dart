import 'dart:math';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:fajrApp/const/app_const.dart';
import 'package:fajrApp/utils/app_util.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseNotificationService {
  AwesomeNotifications awesomeNotifications = AwesomeNotifications();

  resetBadgeCount() async {
    await awesomeNotifications.resetGlobalBadge();
  }

  deleteInstanceId() async {
    await FirebaseMessaging.instance.deleteToken();
  }

  cancelAllNotifications() {
    awesomeNotifications.cancelAll();
  }

  Future<String> getFcmToken() async {
    try {
      FirebaseMessaging fcm = FirebaseMessaging.instance;
      String? fcmToken = await fcm.getToken();

      return fcmToken.toString();
    } catch (e) {
      return "";
    }
  }

  initMessaging() {
    FirebaseMessaging fcm = FirebaseMessaging.instance;

    fcm.getInitialMessage().then((value) {
      //when app is terminated and user click on notification we get value of notification here
    });

    FirebaseMessaging messaging = FirebaseMessaging.instance;
    // FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    FirebaseMessaging.onMessage.listen(
      (RemoteMessage remoteNotification) {
        RemoteNotification? notificationMessage =
            remoteNotification.notification;

        if (notificationMessage != null) {
          if (notificationMessage.title != null &&
              notificationMessage.body != null) {
            bool isAndroid = AppUtils().isAndroid();

            showNotification(
                notificationMessage.title!, notificationMessage.body!, null,
                image: isAndroid
                    ? notificationMessage.android?.imageUrl
                    : notificationMessage.apple?.imageUrl);
          }
        }
      },
    );

    FirebaseMessaging.onMessageOpenedApp.listen(
      (RemoteMessage message) {
        //when app is in background not terminated and user click on notification we get value of notification here

        Map<String, dynamic>? notification = message.data;

        // setupLocator();
        // NavigationService _navigationService = locator<NavigationService>();
        // _navigationService.clearStackAndShow(Routes.itemView);
        // _navigationService.navigateTo(Routes.notificationView);
      },
    );
  }
}

showNotification(String title, String message, String? type,
    {String? image}) async {
  // bool result = await AwesomeNotifications().isNotificationAllowed();
  if (image != null) {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: Random().nextInt(2147483647),
          title: title,
          body: message,
          hideLargeIconOnExpand: true,
          notificationLayout: NotificationLayout.BigPicture,
          bigPicture: image,
          channelKey: AppConst.notificationChannelKey),
    );
  } else {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: Random().nextInt(2147483647),
          title: title,
          body: message,
          channelKey: AppConst.notificationChannelKey),
    );
  }
}
