import 'package:baseproject/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';

class AppBtn extends StatelessWidget {
  final String title;
  final bool isDisabled;
  final Function? onPressed;
  Color? backgroundColor;
  BorderRadius borderRadius;
  Color? borderColor;
  bool shouldShowSplash;
  bool isOutlinedButton;
  EdgeInsets? padding;
  bool shouldExpand;
  bool scaleEffect;
  bool rippleEffect;

  AppBtn(
    this.title, {
    Key? key,
    this.isDisabled = false,
    this.onPressed,
    this.backgroundColor,
    this.borderColor,
    this.shouldShowSplash = true,
    this.isOutlinedButton = false,
    this.padding,
    this.shouldExpand = true,
    this.scaleEffect = true,
    this.rippleEffect = false,
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
  }) : super(key: key);

  AppBtn.outline(
    this.title, {
    Key? key,
    this.isDisabled = false,
    this.onPressed,
    this.backgroundColor,
    this.borderColor,
    this.shouldShowSplash = true,
    this.isOutlinedButton = true,
    this.padding,
    this.shouldExpand = true,
    this.scaleEffect = true,
    this.rippleEffect = false,
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    backgroundColor = backgroundColor ??
        (isOutlinedButton ? Colors.transparent : $styles.colors.primary);
    borderColor = borderColor ??
        (isOutlinedButton ? $styles.colors.primary : Colors.transparent);

    TextStyle buttonTextStyle = $styles.text.btn.copyWith(
        color: isOutlinedButton ? $styles.colors.primary : Colors.white,
        fontWeight: FontWeight.w600);

    ButtonStyle buttonStyle = OutlinedButton.styleFrom(
      foregroundColor: rippleEffect ? $styles.colors.primaryContainer : Colors.transparent,
      textStyle: buttonTextStyle,
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(borderRadius: borderRadius),
      side: borderColor != null ? BorderSide(color: borderColor!) : null,
      padding: padding ?? EdgeInsets.all($styles.insets.s),
      splashFactory:
          rippleEffect ? InkRipple.splashFactory : NoSplash.splashFactory,
      // surfaceTintColor: $styles.colors.primaryContainer,
      // splashColor: splashColor,
    );

    Widget content = Text(title, style: buttonTextStyle);
    if (shouldExpand) {
      content = Center(child: content);
    }

    TextButton textButton = TextButton(
      onPressed: onPressed == null ? null : () => onPressed!(),
      style: buttonStyle,
      child: content,
    );

    if (scaleEffect) {
      return ScaleTap(
        scaleMinValue: 0.98,
        onPressed: onPressed == null ? null : () => onPressed!(),
        child: textButton,
      );
    }

    return textButton;
  }
}
