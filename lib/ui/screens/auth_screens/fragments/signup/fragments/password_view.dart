import 'package:baseproject/config/color_config.dart';
import 'package:baseproject/config/style_config.dart';
import 'package:baseproject/ui/screens/auth_screens/fragments/signup/signup_view_model.dart';
import 'package:baseproject/ui/widgets/custom_button.dart';
import 'package:baseproject/ui/widgets/password_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stacked/stacked.dart';

class PasswordView extends StatefulWidget {
  String password = "";
  Function(String enteredPassword) passwordSubmitCallback;
  TextEditingController passwordController = TextEditingController();

  PasswordView(this.password, this.passwordSubmitCallback, {Key? key})
      : super(key: key);

  @override
  State<PasswordView> createState() => _PasswordViewState();
}

class _PasswordViewState extends State<PasswordView> {
  bool isContinueBtnActive = false;

  @override
  void initState() {
    widget.passwordController = TextEditingController(text: widget.password);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 5.h,
            ),
            const Text(
              "What's your password?",
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87),
            ),
            SizedBox(
              height: 2.h,
            ),
            passwordWidget(widget.passwordController, (bool continueBtnStatus) {
              setState(() {
                isContinueBtnActive = continueBtnStatus;
              });
            }),
            // passwordTextField((bool continueBtnStatus) {
            //   setState(() {
            //     isContinueBtnActive = continueBtnStatus;
            //   });
            // }),
            const Padding(
              padding: EdgeInsets.only(top: 4,left: 4),
              child: Text("Use at least 8 characters",style: TextStyle(fontSize: 12),),
            ),
            Container(
              height: 8.h,
            ),
            Center(
              child: RichText(
                textAlign: TextAlign.center,
                text:  TextSpan(
                  children: [
                    TextSpan(
                      text: 'By tapping continue, I accept Vocal Gauge’s\n',
                      style: smallText,
                    ),
                    TextSpan(
                      text: 'Terms of Use  ',
                      style: smallText.copyWith(color: Colors.blue) ,
                    ),
                    TextSpan(
                      text: 'and',
                      style: smallText,
                    ),
                    TextSpan(
                      text: '  Privacy Policy',
                      style: smallText.copyWith(color: Colors.blue) ,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 3.h,
            ),
            CustomButton(
              "Continue",
              backgroundColor: ColorConfig.accentColor,
              height: 44,
              fontSize: 16,
              isDisabled: !isContinueBtnActive,
              buttonPressed: () {
                if (isContinueBtnActive) {
                  widget.passwordSubmitCallback(widget.passwordController.text);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class passwordWidget extends ViewModelWidget<SignUpViewModel> {
  TextEditingController passwordController;
  Function continueBtnStatusCallback;

  passwordWidget( this.passwordController,this.continueBtnStatusCallback,
      {Key? key})
      : super(key: key, reactive: false);

  @override
  Widget build(BuildContext context, SignUpViewModel viewModel) {
    return passwordTextField((bool continueBtnStatus) {
      continueBtnStatusCallback(continueBtnStatus);
    },passwordController);
  }
}
