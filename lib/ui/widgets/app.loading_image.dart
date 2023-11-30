import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AppLoadingImage extends StatelessWidget {
  final String? imageUrl;
  final String? blurHash;
  final bool isProfileImage;
  final bool showLoadingIndicator;
  final BorderRadius borderRadius;
  final double? width;
  final double? height;
  final BoxFit? boxFit;

  const AppLoadingImage({
    super.key,
    required this.imageUrl,
    this.borderRadius = const BorderRadius.all(Radius.circular(54)),
    this.blurHash,
    this.showLoadingIndicator = true,
    this.isProfileImage = false,
    this.width,
    this.height,
    this.boxFit,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ClipRRect(
        borderRadius: borderRadius,
        child: CachedNetworkImage(
            imageUrl: imageUrl ?? "",
            fadeInDuration: const Duration(milliseconds: 1000),
            fadeOutDuration: const Duration(milliseconds: 340),
            placeholderFadeInDuration: const Duration(milliseconds: 0),
            alignment: Alignment.center,
            fit: boxFit ?? BoxFit.cover,
            width: double.maxFinite,
            height: double.maxFinite,
            // placeholder: (context, url) {
            //   return Container(
            //           color: const Color(0xffD0D0D0),
            //           child: isProfileImage
            //               ? Container(
            //                   color: const Color(0xffD0D0D0),
            //                   child: Image.asset(
            //                       "assets/images/user_placeholder.png"),
            //                 )
            //               : Container(
            //                   color: const Color(0xffD0D0D0),
            //                   child:
            //                       Image.asset("assets/images/placeholder.png"),
            //                 ))
            //       .animate()
            //       .fadeIn();
            // },1
            progressIndicatorBuilder: (context, url, downloadProgress) {
              if (showLoadingIndicator) {
                return Container(
                  color: const Color(0xffD0D0D0),
                  child: isProfileImage
                      ? Container(
                          color: const Color(0xffD0D0D0),
                          child:
                              Image.asset("assets/images/user_placeholder.png"),
                        )
                      : Container(
                          color: const Color(0xffD0D0D0),
                          child: Image.asset("assets/images/placeholder.png"),
                        ),
                ).animate().fadeIn();
              } else {
                return Container();
              }
            },
            errorWidget: (context, url, error) {
              return Container(
                color: const Color(0xffD0D0D0),
                child: isProfileImage
                    ? Container(
                        color: const Color(0xffD0D0D0),
                        child:
                            Image.asset("assets/images/user_placeholder.png"),
                      )
                    : Container(
                        color: const Color(0xffD0D0D0),
                        child: Image.asset("assets/images/placeholder.png"),
                      ),
              ).animate().fadeIn();
            }),
      ),
    );
  }
}
