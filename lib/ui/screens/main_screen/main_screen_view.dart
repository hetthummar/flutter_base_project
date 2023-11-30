import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:fajrApp/app/routes/setup_routes.router.dart';
import 'package:fajrApp/config/color_config.dart';
import 'package:fajrApp/main.dart';
import 'package:fajrApp/ui/screens/main_screen/fragments/add_screen/add_video_view.dart';
import 'package:fajrApp/ui/screens/main_screen/fragments/analytics_screen/analytics_view.dart';
import 'package:fajrApp/ui/screens/main_screen/fragments/home_screen/home_view.dart';
import 'package:fajrApp/ui/screens/main_screen/fragments/profile_screen/profile_view.dart';
import 'package:fajrApp/ui/screens/main_screen/fragments/search_screen/search_view.dart';
import 'package:fajrApp/ui/screens/main_screen/main_screen_view_model.dart';
import 'package:fajrApp/ui/widgets/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stacked/stacked.dart';

class MainScreenView extends StatelessWidget {
  const MainScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ViewModelBuilder<MainScreenViewModel>.reactive(
        onModelReady: (MainScreenViewModel viewModel) {},
        builder: (context, viewModel, child) {
          return Scaffold(
            body: getViewForIndex(viewModel.currentIndex),
            floatingActionButton: floatingActionButtonWidget(
              onTapCallback: () => viewModel.baseViewModel.getNavigationService().navigateTo(
                    Routes.searchView,
                  ),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            resizeToAvoidBottomInset: false,
            bottomNavigationBar: AnimatedBottomNavigationBar.builder(
              itemCount: 4,
              onTap: (index) => viewModel.setIndex(index),
              tabBuilder: (int index, bool isActive) {
                // return AppIcon(
                //   viewModel.navbarIcons[index],
                //   size: 28.sp,
                //   color: isActive ? $styles.colors.error : $styles.colors.body,
                // );
                return Icon(
                  viewModel.navbarIcons[index],
                  size: 28.sp,
                  color: isActive ? $styles.colors.error : $styles.colors.body,
                );
              },
              backgroundColor: $styles.colors.black,
              activeIndex: viewModel.currentIndex,
              notchSmoothness: NotchSmoothness.sharpEdge,
              gapLocation: GapLocation.center,
              notchMargin: 0.w,
              safeAreaValues: const SafeAreaValues(bottom: false),
            ),
          );
        },
        viewModelBuilder: () => MainScreenViewModel(),
      ),
    );
  }
}

Widget getViewForIndex(int index) {
  switch (index) {
    case 0:
      return const HomeView();
    case 1:
      return const SearchView();
    case 2:
      return const AnalyticsView();
    case 3:
      return const ProfileView();
    default:
      return const HomeView();
  }
}

FloatingActionButton floatingActionButtonWidget({required Function onTapCallback}) {
  return FloatingActionButton(
    child: CircleAvatar(
      backgroundColor: $styles.colors.primary,
      radius: 28.w,
      child: Center(
        child: Icon(
          Icons.add,
          color: $styles.colors.accent2,
          size: 40.w,
          shadows: [
            BoxShadow(
              blurRadius: 4.w,
              color: $styles.colors.black.withOpacity(0.2.w),
              offset: Offset(0.w, 3.w),
            ),
          ],
        ),
      ),
    ),
    onPressed: () => onTapCallback(),
  );
}
