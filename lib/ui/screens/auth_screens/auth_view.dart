import 'package:fajrApp/ui/screens/auth_screens/auth_view_model.dart';
import 'package:fajrApp/ui/screens/auth_screens/fragments/login_view.dart';
import 'package:fajrApp/ui/screens/auth_screens/fragments/otp_view.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class AuthView extends StatelessWidget {
  const AuthView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AuthViewModel>.reactive(
      viewModelBuilder: () => AuthViewModel(),
      fireOnViewModelReadyOnce: true,
      onViewModelReady: (viewModel) {},
      builder: (context, viewModel, child) {
        return Scaffold(
          body: getViewForIndex(index: viewModel.currentIndex),
        );
      },
    );
  }
}

Widget getViewForIndex({required int index}) {
  switch (index) {
    case 0:
      return const LoginView();
    case 1:
      return const OTPView();
    default:
      return const LoginView();
  }
}
