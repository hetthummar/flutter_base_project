import 'package:baseproject/config/color_config.dart';
import 'package:baseproject/config/style_config.dart';
import 'package:baseproject/ui/widgets/custom_back_button.dart';
import 'package:baseproject/ui/widgets/custom_button.dart';
import 'package:baseproject/ui/widgets/password_text_field.dart';
import 'package:baseproject/utils/app_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stacked/stacked.dart';

import 'login_view_model.dart';

class LoginView extends StatelessWidget {
  LoginView({Key? key}) : super(key: key);
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      viewModelBuilder: () => LoginViewModel(),
      builder: (BuildContext context, model, Widget? child) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            leading: CustomBackButton(
              () {
                model.goToPreviousScreen();
              },
            ),
            title: Padding(
              padding: const EdgeInsets.only(top: 3),
              child: Text(
                "Login",
                style: appBarText,
              ),
            ),
            centerTitle: true,
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 3.h,
                ),
                Text(
                  "Email",
                  style: title1Text,
                ),
                SizedBox(
                  height: 1.h,
                ),
                TextFormField(
                  onChanged: (text) {
                    if (AppUtils().isValidEmail(text)) {
                      model.changeEmailValidStatus(true);
                    } else {
                      model.changeEmailValidStatus(false);
                    }
                  },
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: "Email",
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.only(
                        left: 16, right: 4, top: 12, bottom: 12),
                    border: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.black38, width: 1.0),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: 3.h,
                ),
                Text(
                  "Password",
                  style: title1Text,
                ),
                SizedBox(
                  height: 1.h,
                ),
                passwordWidget(passwordController),
                SizedBox(
                  height: 5.h,
                ),
                GestureDetector(
                  onTap: () {
                    model.forgotPassword(emailController.text);
                  },
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Forgot password?',
                      style: mediumText.copyWith(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                SizedBox(
                  height: 4.h,
                ),
                CustomButton(
                  "Continue",
                  backgroundColor: ColorConfig.accentColor,
                  height: 44,
                  fontSize: 16,
                  isDisabled: !model.continueBtnStatus,
                  buttonPressed: () {
                    if (model.continueBtnStatus) {
                      model.loginUser(
                          emailController.text, passwordController.text);
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class passwordWidget extends ViewModelWidget<LoginViewModel> {
  TextEditingController passwordController;

  passwordWidget(this.passwordController, {Key? key})
      : super(key: key, reactive: false);

  @override
  Widget build(BuildContext context, LoginViewModel viewModel) {
    return passwordTextField((bool continueBtnStatus) {
      viewModel.changePasswordValidStatus(continueBtnStatus);
    }, passwordController);
  }
}
