import 'package:fajrApp/app/locator.dart';
import 'package:fajrApp/config/color_config.dart';
import 'package:fajrApp/ui/screens/main_screen/fragments/profile_screen/profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileViewModel>.reactive(
      fireOnViewModelReadyOnce: true,
      initialiseSpecialViewModelsOnce: true,
      disposeViewModel: false,
      createNewViewModelOnInsert: false,
      builder: (context, model, child) {
        return Scaffold(
            backgroundColor: ColorConfig.lightGreyBackground,
            body: const Center(child: Text("Profile View")));
      },
      viewModelBuilder: () => locator<ProfileViewModel>(),
    );
  }
}
