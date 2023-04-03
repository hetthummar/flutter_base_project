import 'package:baseproject/config/style_config.dart';
import 'package:baseproject/ui/screens/signup/fragments/email_view.dart';
import 'package:baseproject/ui/screens/signup/fragments/password_view.dart';
import 'package:baseproject/ui/screens/signup/signup_view_model.dart';
import 'package:baseproject/ui/widgets/custom_back_button.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignUpViewModel>.reactive(
      viewModelBuilder: () => SignUpViewModel(),
      fireOnViewModelReadyOnce: true,
      onViewModelReady: (viewModel) {},
      builder: (context, model, child) {
        return WillPopScope(
          onWillPop: () async {
            if (model.selectedScreen == 1) {
              model.changeSelectedScreen(0);
              return false;
            } else {
              // model.goToPreviousScreen();
              return true;
            }
          },
          child: Scaffold(
            appBar: AppBar(
              leading: CustomBackButton(
                () {
                  model.backBtnPressed();
                },
              ),
              title: Padding(
                padding: const EdgeInsets.only(top: 3),
                child: Text(
                  "Create Account",
                  style: appBarText,
                ),
              ),
            ),
            body: model.selectedScreen == 0
                ? EmailView(
                    model.enteredEmail,
                    (String enteredMail) {
                      model.enteredEmail = enteredMail;
                      model.changeSelectedScreen(1);
                    },
                  )
                : PasswordView(
                    model.enteredPassword,
                    (String enteredPassword) {
                      model.submitPassword(enteredPassword);
                    },
                  ),
          ),
        );
      },
    );
  }
}
