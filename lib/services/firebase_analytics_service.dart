import 'package:baseproject/app/locator.dart';
import 'package:baseproject/services/firebase_auth_service.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

import '../const/enums/login_method_enum.dart';

class FirebaseAnalyticsService {
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
  final FirebaseAuthService _firebaseAuthService =
      locator<FirebaseAuthService>();

  FirebaseAnalyticsObserver getAnalyticsObserver() =>
      FirebaseAnalyticsObserver(analytics: _analytics);

  Future setUserId(String? userId) async {
    await _analytics.setUserId(id: userId);
  }

  Future logLoginEvent(loginMethodEnum _loginEnum) async {
    String userId =
        (await _firebaseAuthService.getUserid()) ?? "user_id_not_set";
    setUserId(userId);
    await _analytics.logLogin(loginMethod: _loginEnum.name);
  }

  Future logSignUpEvent(loginMethodEnum _loginEnum) async {
    String userId =
        (await _firebaseAuthService.getUserid()) ?? "user_id_not_set";
    setUserId(userId);
    await _analytics.logSignUp(signUpMethod: _loginEnum.name);
  }

  Future setCurrentScreen(String screenName) async {
    await _analytics.setCurrentScreen(screenName: screenName);
  }

  Future logLogoutEvent() async {
    await _analytics.logEvent(name: "logout");
    await _analytics.setUserId(id: null);
  }

  Future logSearchEvent(String searchFor) async {
    await _analytics.logSearch(searchTerm: searchFor);
  }

  Future logShareContentEvent(
      {required String contentType,
      required String itemId,
      required String shareMethod}) async {
    await _analytics.logShare(
        contentType: contentType, itemId: itemId, method: shareMethod);
  }

  Future logShareEvent() async {
    await _analytics.logEvent(name: "share_app");
  }
}
