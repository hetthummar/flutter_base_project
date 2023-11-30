import 'package:fajrApp/app/locator.dart';
import 'package:fajrApp/ui/screens/main_screen/fragments/add_screen/add_video_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class AddVideoView extends StatelessWidget {
  const AddVideoView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddVideoViewModel>.reactive(
      fireOnViewModelReadyOnce: true,
      initialiseSpecialViewModelsOnce: true,
      disposeViewModel: false,
      createNewViewModelOnInsert: false,
      builder: (context, viewModel, child) {
        return Scaffold();
      },
      viewModelBuilder: () => locator<AddVideoViewModel>(),
    );
  }
}
