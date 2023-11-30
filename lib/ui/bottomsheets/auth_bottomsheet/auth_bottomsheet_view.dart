// ignore_for_file: file_names

import 'package:fajrApp/app/locator.dart';
import 'package:fajrApp/main.dart';
import 'package:fajrApp/ui/bottomsheets/auth_bottomsheet/fragments/login_view.dart';
import 'package:fajrApp/ui/bottomsheets/auth_bottomsheet/fragments/otp_view.dart';
import 'package:fajrApp/ui/screens/auth_screens/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AuthBottomSheetView extends StatelessWidget {
  final SheetRequest request;
  final Function(SheetResponse) completer;

  const AuthBottomSheetView({
    super.key,
    required this.request,
    required this.completer,
  });

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AuthViewModel>.reactive(
      disposeViewModel: false,
      onViewModelReady: (viewModel) => viewModel.init(),
      fireOnViewModelReadyOnce: true,
      builder: (context, viewModel, child) {
        return Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.5,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular($styles.corners.md),
              topLeft: Radius.circular($styles.corners.md),
            ),
            gradient: const LinearGradient(
              colors: [
                Color(0x20121419),
                Color(0xff121419),
              ],
              begin: Alignment.topCenter,
              end: Alignment.center,
            ),
          ),
          child: getFragment(currentIndex: 1),
        );
      },
      viewModelBuilder: () => AuthViewModel(),
    );
  }
}

Widget getFragment({required int currentIndex}) {
  switch (currentIndex) {
    case 0:
      return const LoginView();
    case 1:
      return const OtpView();
    default:
      return const LoginView();
  }
}
