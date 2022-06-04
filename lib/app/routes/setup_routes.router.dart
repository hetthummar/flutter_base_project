// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../ui/screens/auth_screens/auth_view.dart';
import '../../ui/screens/auth_screens/fragments/login/login_view.dart';
import '../../ui/screens/auth_screens/fragments/signup/signup_view.dart';
import '../../ui/screens/main_screen/main_screen_view.dart';
import '../../ui/screens/startup/startup_view.dart';

class Routes {
  static const String startUpView = '/';
  static const String mainScreenView = '/main-screen-view';
  static const String authView = '/auth-view';
  static const String loginView = '/login-view';
  static const String signUpView = '/sign-up-view';
  static const all = <String>{
    startUpView,
    mainScreenView,
    authView,
    loginView,
    signUpView,
  };
}

class StackedRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.startUpView, page: StartUpView),
    RouteDef(Routes.mainScreenView, page: MainScreenView),
    RouteDef(Routes.authView, page: AuthView),
    RouteDef(Routes.loginView, page: LoginView),
    RouteDef(Routes.signUpView, page: SignUpView),
  ];
  @override
  Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, StackedRouteFactory>{
    StartUpView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const StartUpView(),
        settings: data,
      );
    },
    MainScreenView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const MainScreenView(),
        settings: data,
      );
    },
    AuthView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const AuthView(),
        settings: data,
      );
    },
    LoginView: (data) {
      var args = data.getArgs<LoginViewArguments>(
        orElse: () => LoginViewArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => LoginView(key: args.key),
        settings: data,
      );
    },
    SignUpView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const SignUpView(),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// LoginView arguments holder class
class LoginViewArguments {
  final Key? key;
  LoginViewArguments({this.key});
}
