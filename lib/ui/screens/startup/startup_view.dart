import 'package:baseproject/ui/screens/startup/startup_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class StartUpView extends StatelessWidget {
  const StartUpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StartUpViewModel>.reactive(
      onModelReady: (StartUpViewModel model) {
        model.runStartupLogic();
      },
      viewModelBuilder: () => StartUpViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: Colors.black87,
          body: Center(
            child: SizedBox(
              width: 0.5,
              child: Image.asset(
                "assets/logos/app_logo.png",
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
        );
      },
    );
  }
}
