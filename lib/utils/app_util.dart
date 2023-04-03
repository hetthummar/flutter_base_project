import 'dart:io' show Platform;
import 'dart:math';

import 'package:baseproject/main.dart';
import 'package:objectid/objectid.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class AppUtils{

  String generateUniqueMongoId(){
    final id = ObjectId();
    return id.hexString;
  }

  bool isAndroid (){
    if (Platform.isAndroid) {
      return true;
    } else {
      return false;
    }
  }

  easyLoadingInit(){

    if(isAndroid()){
      EasyLoading.instance
        ..indicatorType = EasyLoadingIndicatorType.ring
        ..loadingStyle = EasyLoadingStyle.custom
        ..maskColor = $styles.colors.primaryContainer.withOpacity(0.8)
        ..maskType = EasyLoadingMaskType.custom
        ..backgroundColor = $styles.colors.primary
        ..textColor = Colors.white
        ..indicatorColor = Colors.white
        ..toastPosition = EasyLoadingToastPosition.bottom;
    }else{
      EasyLoading.instance
        ..indicatorType = EasyLoadingIndicatorType.circle
        ..loadingStyle = EasyLoadingStyle.custom
        ..maskColor = $styles.colors.primaryContainer.withOpacity(0.8)
        ..maskType = EasyLoadingMaskType.custom
        ..backgroundColor = $styles.colors.primary
        ..textColor = Colors.white
        ..indicatorColor = Colors.white
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

  bool isValidEmail(String inputMail){
    inputMail = inputMail.trim();
    if (EmailValidator.validate(inputMail) && inputMail.substring(inputMail.length - 3) == "com") {
      return true;
    } else {
      return false;
    }
  }

  bool isValidLink(String inputLink){
    inputLink = inputLink.trim();

    if(inputLink.contains(".") && inputLink.startsWith("http")) {
      return true;
    } else {
      return false;
    }
  }

  bool isValidPassword(String inputPassword){

    if(inputPassword.length >= 8 && inputPassword.length <= 12){
      return true;
    }else{
      return false;
    }
  }

  bool isNetworkImage(String url){
    if(url.startsWith("http")){
      return true;
    }else{
      return false;
    }
  }

}