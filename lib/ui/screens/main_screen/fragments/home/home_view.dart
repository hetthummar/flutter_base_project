import 'package:baseproject/app/locator.dart';
import 'package:baseproject/const/app_const.dart';
import 'package:baseproject/ui/screens/main_screen/fragments/home/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      onModelReady: (HomeViewModel model) async {},
      fireOnModelReadyOnce: true,
      initialiseSpecialViewModelsOnce: true,
      disposeViewModel: false,
      createNewModelOnInsert: false,
      builder: (context, model, child) {
        return Scaffold(
            appBar: buildAppBar(model),
            body: const Center(child: Text("Home View"))
        );
      },
      viewModelBuilder: () => locator<HomeViewModel>(),
    );
  }
}


AppBar buildAppBar(HomeViewModel model) {
  return AppBar(
    title: const Text(
      AppConst.appName,
    ),
    elevation: 0,
    actions: <Widget>[
      PopupMenuButton<String>(
        onSelected: (value) async {
          switch (value) {
            case 'Logout':
              model.logout(shouldShowDialog: true);
              break;
            default:
              break;
          }
        },
        itemBuilder: (BuildContext context) {
          return {'Logout'}.map((String choice) {
            return PopupMenuItem<String>(
              value: choice,
              child: Text(choice),
            );
          }).toList();
        },
      ),
    ],
  );
}