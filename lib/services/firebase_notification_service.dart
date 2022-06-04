import 'dart:math';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:baseproject/const/app_const.dart';
import 'package:baseproject/main.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseNotificationService {
  Future<String> getFcmToken() async {
    try {
      FirebaseMessaging _fcm = FirebaseMessaging.instance;
      String? fcmToken = await _fcm.getToken();

      return fcmToken.toString();
    } catch (e) {
      print("Error in getting fcm token :- " + e.toString());
      return "";
    }
  }

  initMessaging() {
    FirebaseMessaging _fcm = FirebaseMessaging.instance;

    _fcm.getInitialMessage().then((value) {
      //when app is termeinated and user click on notification we get value of notification here
    });

    FirebaseMessaging messaging = FirebaseMessaging.instance;
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
        Map<String, dynamic>? notificationMessage = message.data;

        if (notificationMessage != null &&
            notificationMessage.keys.isNotEmpty) {
          showNotification(
            notificationMessage['title'],
            notificationMessage['body'],
            notificationMessage['type'],
            image: notificationMessage['image'],
            id: notificationMessage['id'],
          );
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

showNotification(String title, String message, String type,
    {String? image, String? id}) async {
  bool result = await AwesomeNotifications().isNotificationAllowed();
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