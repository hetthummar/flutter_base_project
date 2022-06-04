import 'dart:io' show Platform;

import 'package:baseproject/config/color_config.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class AppUtils{

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
        ..maskColor = Colors.black54
        ..maskType = EasyLoadingMaskType.custom
        ..backgroundColor = ColorConfig.accentColor.withAlpha(1)
        ..textColor = Colors.white
        ..indicatorColor = Colors.white
        ..toastPosition = EasyLoadingToastPosition.bottom;
    }else{
      EasyLoading.instance
        ..indicatorType = EasyLoadingIndicatorType.circle
        ..loadingStyle = EasyLoadingStyle.custom
        ..maskColor = Colors.black54
        ..maskType = EasyLoadingMaskType.custom
        ..backgroundColor = ColorConfig.accentColor.withAlpha(1)
        ..textColor = Colors.white
        ..indicatorColor = Colors.white
          ..toastPosition = EasyLoadingToastPosition.bottom;
    }
    }


  bool isValidEmail(String inputMail){
    inputMail = inputMail.trim();
    if (EmailValidator.validate(inputMail) && inputMail.substring(inputMail.length - 3) == "com") {
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

}