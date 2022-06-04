import 'package:baseproject/app/locator.dart';
import 'package:baseproject/base/custom_base_view_model.dart';
import 'package:baseproject/base/custom_index_tracking_view_model.dart';

class MainScreenViewModel extends CustomIndexTrackingViewModel {
  final CustomBaseViewModel _baseViewModel = locator<CustomBaseViewModel>();
}
