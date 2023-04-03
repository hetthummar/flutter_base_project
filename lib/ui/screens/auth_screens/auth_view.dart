import 'package:baseproject/main.dart';
import 'package:baseproject/ui/widgets/app.button.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'auth_view_model.dart';

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
          appBar: AppBar(
            title: const Text("Auth"),
          ),
          body: SafeArea(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    viewModel.customBaseViewModel.showEasySuccess();
                  },
                  child: Text("LOGIN1212", style: $styles.text.btn),
                ),
                SizedBox(height: 12 * $styles.scale),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AppBtn(
                    "Test BTN",
                    onPressed: () {},
                    scaleEffect: true,
                    rippleEffect: true,
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
