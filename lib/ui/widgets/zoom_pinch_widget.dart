import 'package:flutter/material.dart';
import 'package:zoom_pinch_overlay/zoom_pinch_overlay.dart';

class ZoomPinchWidget extends StatelessWidget {
  final Widget child;

  const ZoomPinchWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ZoomOverlay(
      modalBarrierColor: Colors.black12,
      minScale: 0.5,
      maxScale: 3.0,
      animationCurve: Curves.fastOutSlowIn,
      animationDuration: const Duration(milliseconds: 300),
      twoTouchOnly: true,
      onScaleStart: () {},
      onScaleStop: () {},
      child: child,
    );
  }
}
