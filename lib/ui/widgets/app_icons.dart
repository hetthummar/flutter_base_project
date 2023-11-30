// ignore_for_file: constant_identifier_names

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppIcon extends StatelessWidget {
  const AppIcon(this.icon, {Key? key, this.size = 22, this.color}) : super(key: key);
  final AppIcons icon;
  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    String i = describeEnum(icon).toLowerCase();
    String path = 'assets/icons/icon-$i.svg';

    return SizedBox(
      width: size,
      height: size,
      child: Center(
        child: SvgPicture.asset(path, width: size, height: size, color: color),
      ),
    );
  }
}

enum AppIcons {
  add,
  add_video,
  add_video_active,
  analytics,
  analytics_active,
  arrow_up_left,
  bell,
  block,
  calender,
  call,
  close,
  comment,
  delete_account,
  down_arrow,
  edit,
  filter,
  fired,
  heart,
  heart_filled,
  hide_video,
  home,
  home_active,
  language,
  left_arrow,
  link,
  location_marker,
  logout,
  menu,
  message,
  more_vertical,
  notification_active,
  play_video,
  privacy,
  profile_active,
  promoted_boost,
  right_arrow,
  save_filled,
  save_video,
  search,
  search_active,
  settings,
  share,
  support,
  tags,
  user_profile,
  views,
  volume_on,
}
