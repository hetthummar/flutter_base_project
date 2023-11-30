import 'package:fajrApp/main.dart';
import 'package:fajrApp/ui/screens/auth_screens/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:stacked/stacked.dart';

class OtpView extends ViewModelWidget<AuthViewModel> {
  const OtpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, AuthViewModel viewModel) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: $styles.insets.l, vertical: $styles.insets.m),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset('assets/images/login.svg'),
          Gap($styles.insets.xxl),
        ],
      ),
    );
  }
}
