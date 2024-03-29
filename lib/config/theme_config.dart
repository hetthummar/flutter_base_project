import 'package:fajrApp/main.dart';
import 'package:flutter/material.dart';

class ThemeConfig {
  ThemeData themeData = ThemeData(
    colorScheme: $styles.colors.toColorScheme(),
    appBarTheme: AppBarTheme(
      color: $styles.colors.white,
      elevation: 0,
      titleTextStyle: $styles.text.headlineSmall.copyWith(color: $styles.colors.primary),
    ),
    dividerColor: Colors.black26,
    fontFamily: 'Poppins',
  );
}
