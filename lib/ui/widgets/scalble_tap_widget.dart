import 'package:flutter/material.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';

class ScalableTapWidget extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;

  const ScalableTapWidget(
      {super.key, required this.child, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ScaleTap(
      scaleMinValue: 0.97,
      onPressed: onTap,
      child: child,
    );
  }
}
