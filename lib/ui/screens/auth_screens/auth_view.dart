import 'package:baseproject/config/color_config.dart';
import 'package:baseproject/config/style_config.dart';
import 'package:baseproject/const/app_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:stacked/stacked.dart';

import 'auth_view_model.dart';

class AuthView extends StatelessWidget {
  const AuthView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double spacingBetweenBtn = 12;

    return ViewModelBuilder<AuthViewModel>.reactive(
      viewModelBuilder: () => AuthViewModel(),
      fireOnModelReadyOnce: true,
      onModelReady: (viewModel) {},
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    width: 0.2.sw,
                    child: Image.asset(
                      "assets/logos/app_logo.png",
                      fit: BoxFit.fitWidth,
                    )),
                SizedBox(
                  height: 2.h,
                ),
                Text(
                  AppConst.appName,
                  style: title1Text,
                ),
                SizedBox(
                  height: 2.w,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 11.w),
                  child: Text(
                    "Find the perfect key to sing a song in.",
                    textAlign: TextAlign.center,
                    style: mediumText,
                  ),
                ),
                SizedBox(
                  height: 6.w,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 3, right: 3),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SignInButtonBuilder(
                        text: 'Create an Account',
                        onPressed: () {
                          model.gotoSignUpScreen();
                        },
                        elevation: 1,
                        icon: Icons.email,
                        padding: EdgeInsets.symmetric(vertical: 11.2),
                        backgroundColor: ColorConfig.accentColor,
                      ),
                      const SizedBox(height: spacingBetweenBtn),
                      SignInButton(
                        Buttons.FacebookNew,
                        onPressed: () {
                          model.createAccountWithFacebook();
                        },
                        padding: EdgeInsets.symmetric(vertical: 11),
                        elevation: 1,
                        text: 'Continue with Facebook',
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(2)),
                      ),
                      const SizedBox(height: spacingBetweenBtn),
                      SignInButtonBuilder(
                        text: 'Continue with Google',
                        textColor: Colors.black,
                        onPressed: () {
                          model.createAccountWithGoogle();
                        },
                        elevation: 1,
                        image: Image.asset(
                          "assets/icons/google_icon.png",
                          width: 20,
                        ),
                        padding: EdgeInsets.symmetric(vertical: 11.2),
                        backgroundColor: Colors.white,
                      ),
                      const SizedBox(
                        height: spacingBetweenBtn,
                      ),
                      SignInButton(
                        Buttons.Apple,
                        padding: EdgeInsets.symmetric(vertical: 10),
                        elevation: 1,
                        text: 'Continue with Apple',
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)),
                        onPressed: () {
                          model.createAccountWithApple();
                        },
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      GestureDetector(
                        onTap: () {
                          model.gotoLoginScreen();
                        },
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Already have an Account? ',
                                style:
                                    smallText.copyWith(color: Colors.black54),
                              ),
                              TextSpan(
                                text: 'Log in',
                                style: smallText,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
