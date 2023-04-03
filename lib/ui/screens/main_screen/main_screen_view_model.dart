import 'package:baseproject/app/locator.dart';
import 'package:baseproject/base/custom_base_view_model.dart';
import 'package:stacked/stacked.dart';

class MainScreenViewModel extends IndexTrackingViewModel {
  final CustomBaseViewModel baseViewModel = locator<CustomBaseViewModel>();
}
