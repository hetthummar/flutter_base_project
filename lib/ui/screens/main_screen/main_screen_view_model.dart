import 'package:fajrApp/app/locator.dart';
import 'package:fajrApp/base/custom_base_view_model.dart';
import 'package:fajrApp/ui/widgets/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class MainScreenViewModel extends IndexTrackingViewModel {
  final CustomBaseViewModel baseViewModel = locator<CustomBaseViewModel>();

  List<IconData> navbarIcons = [
    Icons.home,
    Icons.search,
    Icons.analytics,
    Icons.person_2_outlined,
  ];
}
