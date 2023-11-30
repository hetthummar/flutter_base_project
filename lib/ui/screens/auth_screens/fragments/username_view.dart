import 'package:fajrApp/ui/screens/auth_screens/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class UserNameView extends ViewModelWidget<AuthViewModel> {
  const UserNameView({super.key});

  @override
  Widget build(BuildContext context, AuthViewModel viewModel) {
    return const Scaffold(
      body: Center(
        child: Text("USER NAME VIEW"),
      ),
    );
  }
}
