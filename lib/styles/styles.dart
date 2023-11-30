import 'package:fajrApp/styles/colors.dart';
import 'package:flutter/material.dart';

export 'colors.dart';

@immutable
class AppStyle {
  AppStyle({Size? screenSize}) {
    if (screenSize == null) {
      scale = 1;
      return;
    }
    final shortestSide = screenSize.shortestSide;
    const tabletXl = 1000;
    const tabletLg = 800;
    const tabletSm = 600;
    const phoneLg = 390;

    if (shortestSide > tabletXl) {
      scale = 1.25;
    } else if (shortestSide > tabletLg) {
      scale = 1.15;
    } else if (shortestSide > tabletSm) {
      scale = 1;
    } else if (shortestSide > phoneLg) {
      scale = .9; // phone
    } else {
      scale = .85; // small phone
    }
    debugPrint('screenSize=$screenSize, scale=$scale');
  }

  late final double scale;

  /// The current theme colors for the app
  final AppColors colors = AppColors();

  /// Rounded edge corner radii
  late final _Corners corners = _Corners();

  late final _Shadows shadows = _Shadows();

  /// Padding and margin values
  late final _Insets insets = _Insets(scale);

  /// Text styles
  late final _Text text = _Text(scale);

  /// Animation Durations
  final _Times times = _Times();

  /// Shared sizes
  late final _Sizes sizes = _Sizes();
}

@immutable
class _Text {
  _Text(this._scale);

  final double _scale;

  late final TextStyle h3 =
  _createFont(sizePx: 20, heightPx: 36, weight: FontWeight.w600);

  late final TextStyle displayLarge = _createFont(sizePx: 57, heightPx: 64);
  late final TextStyle displayMedium = _createFont(sizePx: 45, heightPx: 52);
  late final TextStyle displaySmall = _createFont(sizePx: 36, heightPx: 44);

  late final TextStyle headlineLarge = _createFont(sizePx: 32, heightPx: 40);
  late final TextStyle headlineMedium = _createFont(sizePx: 28, heightPx: 36);
  late final TextStyle headlineSmall = _createFont(sizePx: 24, heightPx: 32);

  late final TextStyle titleLarge = _createFont(sizePx: 22, heightPx: 28);
  late final TextStyle titleMedium =
  _createFont(sizePx: 16, heightPx: 24, spacingPc: 0.15);
  late final TextStyle titleSmall =
  _createFont(sizePx: 14, heightPx: 20, spacingPc: 0.1);

  late final TextStyle labelLarge =
  _createFont(sizePx: 14, heightPx: 20, spacingPc: 0.15);
  late final TextStyle labelMedium =
  _createFont(sizePx: 12, heightPx: 16, spacingPc: 0.5);
  late final TextStyle labelSmall =
  _createFont(sizePx: 11, heightPx: 16, spacingPc: 0.5);

  late final TextStyle bodyLarge =
  _createFont(sizePx: 16, heightPx: 24, spacingPc: 0.5);
  late final TextStyle bodyMedium =
  _createFont(sizePx: 14, heightPx: 20, spacingPc: 0.25);
  late final TextStyle bodySmall =
  _createFont(sizePx: 12, heightPx: 16, spacingPc: 0.4);

  late final TextStyle btn = _createFont(sizePx: 16, heightPx: 14);

  TextStyle _createFont(
      {TextStyle? style,
        required double sizePx,
        double? heightPx,
        double? spacingPc,
        FontWeight? weight}) {
    sizePx *= _scale;
    if (heightPx != null) {
      heightPx *= _scale;
    }

    style ??= const TextStyle();

    return style.copyWith(
        fontSize: sizePx,
        height: heightPx != null ? (heightPx / sizePx) : style.height,
        letterSpacing:
        spacingPc != null ? sizePx * spacingPc * 0.01 : style.letterSpacing,
        fontWeight: weight);
  }
}

@immutable
class _Times {
  final Duration fast = const Duration(milliseconds: 300);
  final Duration med = const Duration(milliseconds: 600);
  final Duration slow = const Duration(milliseconds: 900);
  final Duration pageTransition = const Duration(milliseconds: 200);
}

@immutable
class _Corners {
  late final double xxs = 4;
  late final double xs = 8;
  late final double sm = 16;
  late final double md = 24;
  late final double lg = 32;
  late final double xl = 48;
}

// TODO: add, @immutable when design is solidified
class _Sizes {
  double get maxContentWidth1 => 800;

  double get maxContentWidth2 => 600;

  double get maxContentWidth3 => 500;
  final Size minAppSize = const Size(380, 675);
}

@immutable
class _Insets {
  _Insets(this._scale);

  final double _scale;

  late final double xxs = 4 * _scale;
  late final double xs = 8 * _scale;
  late final double s = 16 * _scale;
  late final double m = 24 * _scale;
  late final double l = 32 * _scale;
  late final double xl = 40 * _scale;
  late final double xxl = 48 * _scale;
  late final double xxxl = 56 * _scale;
  late final double offset = 80 * _scale;
}

@immutable
class _Shadows {
  final textSoft = [
    Shadow(
        color: Colors.black.withOpacity(.25),
        offset: const Offset(0, 2),
        blurRadius: 4),
  ];
  final text = [
    Shadow(
        color: Colors.black.withOpacity(.6),
        offset: const Offset(0, 2),
        blurRadius: 2),
  ];
  final textStrong = [
    Shadow(
        color: Colors.black.withOpacity(.6),
        offset: const Offset(0, 4),
        blurRadius: 6),
  ];
}
