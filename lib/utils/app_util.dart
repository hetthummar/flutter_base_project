import 'dart:io' show Platform;
import 'dart:math';

import 'package:country_codes/country_codes.dart';
import 'package:fajrApp/main.dart';
import 'package:libphonenumber/libphonenumber.dart';
import 'package:objectid/objectid.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:url_launcher/url_launcher.dart';

class AppUtils {

  openEmail({required String email, required String subject}){

    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
      query: _encodeQueryParameters(<String, String>{
        'subject': subject,
      }),
    );

    launchUrl(emailLaunchUri);
  }

  checkIfNullOrEmpty(String? value) {
    if (value == null || value.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  String? _encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((MapEntry<String, String> e) =>
    '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }


  Future<String?> getCountryCodeOfThisDevice() async {
    final CountryDetails details = CountryCodes.detailsForLocale();
    return details.dialCode;
  }

  Future<String?> getIOSCodeOfThisDevice() async {
    final CountryDetails details = CountryCodes.detailsForLocale();
    return details.alpha2Code;
  }

  isValidPhoneNumber(String phoneNumber, String isoCode) async {
    return await PhoneNumberUtil.isValidPhoneNumber(
        phoneNumber: phoneNumber, isoCode: isoCode);
  }

  String generateUniqueMongoId() {
    final id = ObjectId();
    return id.hexString;
  }

  bool isAndroid() {
    if (Platform.isAndroid) {
      return true;
    } else {
      return false;
    }
  }

  bool isIOS() {
    if (Platform.isIOS) {
      return true;
    } else {
      return false;
    }
  }

  easyLoadingInit() {
    if (isAndroid()) {
      EasyLoading.instance
        ..indicatorType = EasyLoadingIndicatorType.ring
        ..loadingStyle = EasyLoadingStyle.custom
        ..maskColor = $styles.colors.black.withOpacity(0.8)
        ..maskType = EasyLoadingMaskType.custom
        ..backgroundColor = Colors.red
        ..textColor = $styles.colors.white
        ..indicatorColor = $styles.colors.white
        ..toastPosition = EasyLoadingToastPosition.bottom;
    } else {
      EasyLoading.instance
        ..indicatorType = EasyLoadingIndicatorType.circle
        ..loadingStyle = EasyLoadingStyle.custom
        ..maskColor = $styles.colors.black.withOpacity(0.8)
        ..maskType = EasyLoadingMaskType.custom
        ..backgroundColor = Colors.red
        ..textColor = $styles.colors.white
        ..indicatorColor = $styles.colors.white
        ..toastPosition = EasyLoadingToastPosition.bottom;
    }
  }

  String getRandomId() {
    var random = Random();
    var id = "";
    for (var i = 0; i < 5; i++) {
      id += random.nextInt(10).toString();
    }

    DateTime dateTime = DateTime.now();

    return "${id}_${dateTime.millisecondsSinceEpoch}";
  }

  bool isValidEmail(String inputMail) {
    inputMail = inputMail.trim();
    if (EmailValidator.validate(inputMail)) {
      return true;
    } else {
      return false;
    }
  }

  bool isValidLink(String inputLink) {
    inputLink = inputLink.trim();

    if (inputLink.contains(".") && inputLink.startsWith("http")) {
      return true;
    } else {
      return false;
    }
  }

  bool isValidPassword(String inputPassword) {
    if (inputPassword.length >= 8 && inputPassword.length <= 12) {
      return true;
    } else {
      return false;
    }
  }

  bool isNetworkImage(String url) {
    if (url.startsWith("http")) {
      return true;
    } else {
      return false;
    }
  }
}