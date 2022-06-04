import 'package:baseproject/app/locator.dart';
import 'package:stacked/stacked.dart';

import 'custom_base_view_model.dart';

class CustomIndexTrackingViewModel extends IndexTrackingViewModel{

  final CustomBaseViewModel _customBaseViewModel = locator<CustomBaseViewModel>();
  CustomBaseViewModel getCustomBaseViewModel() => _customBaseViewModel;
}