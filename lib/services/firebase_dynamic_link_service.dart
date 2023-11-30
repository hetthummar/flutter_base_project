import 'package:fajrApp/const/app_const.dart';
import 'package:fajrApp/services/firebase_auth_service.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:stacked_services/stacked_services.dart';

import '../app/locator.dart';
import '../app/routes/setup_routes.router.dart';

class FirebaseDynamicLinkService {
  Future handleDynamicLinks() async {
    FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;

    dynamicLinks.onLink.listen((PendingDynamicLinkData dynamicLinkData) async {
      _handleDeepLink(dynamicLinkData);
    }, onError: (error) {});

    final PendingDynamicLinkData? dynamicLinkData =
        await FirebaseDynamicLinks.instance.getInitialLink();

    if (dynamicLinkData != null) {
      Future.delayed(const Duration(seconds: 3), () {
        _handleDeepLink(dynamicLinkData);
      });
    }
  }

  void _handleDeepLink(PendingDynamicLinkData? dynamicLink) async {
    NavigationService navigationService = locator<NavigationService>();

    if (dynamicLink == null) {
      navigationService.clearStackAndShow(Routes.startUpView);
      return;
    }

    var currentUser = await FirebaseAuthService().getCurrentUser();

    final Uri deepLink = dynamicLink.link;
    print("deepLink.path : " + deepLink.path.toString());

    if (deepLink.path.trim() == "/share_profile" && (currentUser != null)) {
      Map<String, String> parameters = deepLink.queryParameters;
      String? profileId = parameters['profile_id'];
      if (profileId == null) {
        navigationService.clearStackAndShow(Routes.startUpView);
        return;
      }
      // locator<NavigationService>().clearStackAndShow(Routes.creatorProfileView,
      //     arguments: CreatorProfileViewArguments(profilerId: profileId));
    } else {
      navigationService.clearStackAndShow(Routes.startUpView);
    }
  }

  Future<String?> generateShareProfileUrl(String profileId) async {
    try {
      DynamicLinkParameters parameters = DynamicLinkParameters(
        link: Uri.parse(
            '${AppConst.deeplLinkUrl}/share_profile?profile_id=$profileId'),
        uriPrefix: AppConst.deeplLinkUrl,
        androidParameters: AndroidParameters(
            packageName: 'com.app.wititapp',
            minimumVersion: 1,
            fallbackUrl: Uri.parse(AppConst.webUrl)),
        iosParameters: IOSParameters(
          bundleId: 'com.app.wititapp',
          minimumVersion: '1',
          fallbackUrl: Uri.parse(AppConst.webUrl),
        ),
        socialMetaTagParameters: const SocialMetaTagParameters(
            title: "Witit", description: "The AI based Social Media App"
            // imageUrl: Uri.parse("https://www.pironedjs.com/wp-content/uploads/2016/02/pirone-entertainment-logo-1.jpg"),
            ),
        // dynamicLinkParametersOptions: DynamicLinkParametersOptions(
        //   shortDynamicLinkPathLength: ShortDynamicLinkPathLength.unguessable,
        // ),
      );

      final ShortDynamicLink dynamicUrl =
          await FirebaseDynamicLinks.instance.buildShortLink(
        parameters,
        shortLinkType: ShortDynamicLinkType.unguessable,
      );

      // final ShortDynamicLink shortenedLink =
      // await DynamicLinkParameters.shortenUrl(
      //   dynamicUrl,
      //   DynamicLinkParametersOptions(
      //       shortDynamicLinkPathLength:
      //       ShortDynamicLinkPathLength.unguessable),
      // );

      return dynamicUrl.shortUrl.toString();
    } catch (e) {
      return null;
    }
  }
}
