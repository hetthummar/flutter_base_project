import 'package:fajrApp/app/locator.dart';
import 'package:fajrApp/ui/screens/main_screen/fragments/analytics_screen/analytics_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class AnalyticsView extends StatelessWidget {
  const AnalyticsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AnalyticsViewModel>.reactive(
      fireOnViewModelReadyOnce: true,
      initialiseSpecialViewModelsOnce: true,
      disposeViewModel: false,
      createNewViewModelOnInsert: false,
      builder: (context, viewModel, child) {
        return Scaffold();
      },
      viewModelBuilder: () => locator<AnalyticsViewModel>(),
    );
  }
}
