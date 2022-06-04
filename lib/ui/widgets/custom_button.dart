import 'package:baseproject/config/color_config.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final bool isDisabled;
  final Function? buttonPressed;
  Color? backgroundColor;
  Color? textColor;
  final double height;
  final double fontSize;


  CustomButton(this.title,
      {Key? key,
      this.isDisabled = false,
      this.buttonPressed,
      this.backgroundColor,
      this.textColor = Colors.white,
      this.height = 64,
      this.fontSize = 16,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isDisabled == false) {
          if (buttonPressed != null) {
            buttonPressed!();
          }
        }
      },
      child: Container(
        height: height,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(4)),
          color: isDisabled ? Colors.grey.shade500 : backgroundColor ?? ColorConfig.accentColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style:  TextStyle(
                  color: textColor ?? Colors.white, fontSize: fontSize, letterSpacing: 0.5),
            ),
          ],
        ),
      ),
    );
  }
}
