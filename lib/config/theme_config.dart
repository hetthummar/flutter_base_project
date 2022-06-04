import 'package:flutter/material.dart';

import 'color_config.dart';

class ThemeConfig{

  ThemeData themeData = ThemeData(
    colorScheme: const ColorScheme.light().copyWith(
        primary: ColorConfig.primaryColor,
        secondary: ColorConfig.secondaryColor
    ),
    dividerColor: Colors.black26,
    fontFamily: 'Poppins',
  );

}