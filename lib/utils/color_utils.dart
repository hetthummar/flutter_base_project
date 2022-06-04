import 'dart:math' as math;
import 'dart:ui';

class ColorUtils {
  Color getRandomColor() {
    return Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
        .withOpacity(1.0);
  }
}
