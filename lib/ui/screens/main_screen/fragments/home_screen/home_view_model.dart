import 'package:chewie/chewie.dart';
import 'package:fajrApp/base/custom_base_view_model.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class HomeViewModel extends CustomBaseViewModel {
  PageController pageController = PageController();

  List<String> videoList = [
    "https://docs.evostream.com/sample_content/assets/bun33s.mp4",
    'https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_20mb.mp4',
    'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/WeAreGoingOnBullrun.mp4',
    'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4',
    'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4',
    'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4',
    'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4',
    'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerMeltdowns.mp4',
    'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/Sintel.mp4',
    'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/WhatCarCanYouGetForAGrand.mp4',
  ];

  int currentPage = 0;

  late VideoPlayerController videoPlayerController;
  ChewieController? chewieController;

  initPlayer() {
    videoPlayerController = VideoPlayerController.networkUrl(
      Uri.parse(
        videoList[currentPage],
      ),
    );

    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      autoPlay: true,
      looping: true,
    );

    pageController.addListener(() {
      int newPage = pageController.page?.round() ?? 0;
      if (newPage != currentPage) {
        currentPage = newPage;
        updateVideo();
      }
    });
  }

  void updateVideo() {
    videoPlayerController.pause();
    videoPlayerController = VideoPlayerController.networkUrl(
      Uri.parse(videoList[currentPage]),
    );

    chewieController!.dispose();
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      autoPlay: true,
      looping: false,
      additionalOptions: (context) {
        return [
          OptionItem(
            onTap: () {
              showErrorSnackBar('message');
            },
            iconData: Icons.abc,
            title: 'title',
          ),
          OptionItem(
            onTap: () {
              showErrorSnackBar('message');
            },
            iconData: Icons.abc,
            title: 'title',
          ),
        ];
      },
      allowFullScreen: true,
      showOptions: false,
      customControls: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        color: Colors.transparent,
      ),
    );

    notifyListeners();
  }
}
