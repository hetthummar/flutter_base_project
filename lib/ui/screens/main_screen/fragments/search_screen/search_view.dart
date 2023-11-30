import 'package:fajrApp/app/locator.dart';
import 'package:fajrApp/ui/screens/main_screen/fragments/search_screen/search_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SearchViewModel>.reactive(
      fireOnViewModelReadyOnce: true,
      initialiseSpecialViewModelsOnce: true,
      disposeViewModel: false,
      createNewViewModelOnInsert: false,
      builder: (context, viewModel, child) {
        return Scaffold();
      },
      viewModelBuilder: () => locator<SearchViewModel>(),
    );
  }
}
