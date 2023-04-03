import 'package:baseproject/utils/color_utils.dart';
import 'package:flutter/material.dart';

class AppColors {
  /// Common

  final Color primary = const Color(0xFF8C52FF);
  final Color primaryContainer = const Color(0xFFE0D5FF);
  final Color primaryDark = const Color(0xFF24005B);

  final Color onPrimary = const Color(0xffffffff);
  final Color onPrimaryContainer = const Color(0xff212121);

  final Color black = const Color(0xff212121);
  final Color white = Colors.white;

  final Color body = const Color(0xff666666);

  final Color greyStrong = const Color(0xFFEAEAEA);
  final Color greyMedium = const Color(0xFFEAEAEA);
  final Color greyLight = const Color(0xFFE6E6E8);

  final Color error = Colors.red.shade400;

  final Color accent2 = const Color(0xFFBEABA1);
  final Color offWhite = const Color(0xFFF8ECE5);
  final Color caption = const Color(0xFF7D7873);

  final bool isDark = false;

  Color shift(Color c, double d) =>
      ColorUtils.shiftHsl(c, d * (isDark ? -1 : 1));

  ColorScheme toColorScheme() {
    ColorScheme colorScheme = ColorScheme(
      brightness: isDark ? Brightness.dark : Brightness.light,
      primary: primary,
      onPrimary: onPrimary,
      primaryContainer: primaryContainer,
      onPrimaryContainer: onPrimaryContainer,
      secondary: primary,
      onSecondary: onPrimary,
      secondaryContainer: primaryContainer,
      onSecondaryContainer: onPrimaryContainer,
      background: white,
      surface: white,
      onBackground: black,
      onSurface: black,
      error: error,
      onError: Colors.white,
    );
    return colorScheme;
  }
}
