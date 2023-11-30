import 'dart:developer';

import 'package:chewie/chewie.dart';
import 'package:fajrApp/app/locator.dart';
import 'package:fajrApp/const/app_const.dart';
import 'package:fajrApp/main.dart';
import 'package:fajrApp/ui/screens/main_screen/fragments/home_screen/home_view_model.dart';
import 'package:fajrApp/ui/widgets/app.loading_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:stacked/stacked.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      onViewModelReady: (HomeViewModel viewModel) async {
        viewModel.initPlayer();
      },
      fireOnViewModelReadyOnce: true,
      initialiseSpecialViewModelsOnce: true,
      disposeViewModel: false,
      createNewViewModelOnInsert: false,
      builder: (context, viewModel, child) {
        return Scaffold(
          backgroundColor: $styles.colors.black.withOpacity(0.1.w),
          body: PageView.builder(
            physics: const BouncingScrollPhysics(),
            controller: viewModel.pageController,
            scrollDirection: Axis.vertical,
            padEnds: true,
            pageSnapping: true,
            allowImplicitScrolling: true,
            onPageChanged: (value) {
              log('page indexxxx $value');
            },
            itemCount: viewModel.videoList.length,
            itemBuilder: (context, index) {
              return singlePostWidget(
                viewModel: viewModel,
                index: index,
              );
            },
          ),
        );
      },
      viewModelBuilder: () => locator<HomeViewModel>(),
    );
  }
}

Widget singlePostWidget({required HomeViewModel viewModel, required int index}) {
  // return AppLoadingImage(
  //   imageUrl: viewModel.imageList[index],
  //   height: double.maxFinite,
  //   width: double.maxFinite,
  //   borderRadius: BorderRadius.zero,
  // );
  return Stack(
    children: [
      Chewie(
        controller: viewModel.chewieController!,
      ),
      Positioned(
        bottom: $styles.insets.s,
        right: $styles.insets.s,
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                viewModel.showSuccessSnackBar('shshshshshshshshs');
              },
              child: const Icon(CupertinoIcons.heart),
            ),
            Gap($styles.insets.s),
            const Icon(CupertinoIcons.command),
            Gap($styles.insets.s),
            const Icon(CupertinoIcons.share),
            Gap($styles.insets.s),
            const Icon(Icons.more_vert),
            Gap($styles.insets.s),
          ],
        ),
      )
    ],
  );
}
