// ignore_for_file: non_constant_identifier_names

import 'package:fajrApp/ui/screens/auth_screens/auth_view_model.dart';
import 'package:fajrApp/ui/widgets/app.button.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class LoginView extends ViewModelWidget<AuthViewModel> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context, AuthViewModel viewModel) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppBtn(
              'Authenticate',
              onPressed: () => viewModel.authenticate(),
              isDisabled: true,
            ),
          ],
        ),
      ),
    );
  }
}
