import 'package:baseproject/config/color_config.dart';
import 'package:baseproject/ui/screens/main_screen/fragments/home/home_view.dart';
import 'package:baseproject/ui/screens/main_screen/fragments/profile/profile_view.dart';
import 'package:baseproject/ui/screens/main_screen/main_screen_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class MainScreenView extends StatelessWidget {
  const MainScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ViewModelBuilder<MainScreenViewModel>.reactive(
        onModelReady: (MainScreenViewModel viewModel){
        },
        builder: (context, model, child) {
          return Scaffold(
            body: getViewForIndex(model.currentIndex,(){
              model.setIndex(1);
            }),
            bottomNavigationBar: BottomNavigationBar(
              showSelectedLabels: false,
              showUnselectedLabels: false,
              // fixedColor: ColorConfig.accentColor,
              selectedItemColor: ColorConfig.accentColor,
              // type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.white,
              currentIndex: model.currentIndex,
              onTap: model.setIndex,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label:'home',
                ),
                BottomNavigationBarItem(
                 icon: Icon(Icons.account_circle_outlined),
                  label: 'Account'
                ),
              ],
            ),
          );
        },
        viewModelBuilder: () => MainScreenViewModel(),
      ),
    );
  }
}

Widget getViewForIndex(int index,Function gotoSearchScreen) {
  switch (index) {
    case 0:
      return const HomeView();
    case 1:
      return const ProfileView();
    default:
      return const HomeView();
  }
}
