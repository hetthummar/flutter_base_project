import 'package:baseproject/app/locator.dart';
import 'package:baseproject/config/color_config.dart';
import 'package:baseproject/ui/screens/main_screen/fragments/profile/profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileViewModel>.reactive(
      onModelReady: (ProfileViewModel model) async {
        model.getUserData();
      },
      // fireOnModelReadyOnce: true,
      initialiseSpecialViewModelsOnce: true,
      disposeViewModel: false,
      builder: (context, model, child) {
        return Scaffold(
            backgroundColor: ColorConfig.lightGreyBackground,
            body: const Center(child: Text("Profile View")));
      },
      viewModelBuilder: () => locator<ProfileViewModel>(),
    );
  }
}
