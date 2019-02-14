import 'package:flutter/material.dart';
import 'dart:math' as math;

/// Because we want to support every possible screen size, and we have design specs with specific margins and sizes for a device with height (for example) 650dp.
/// In order to keep propotions similar for every device, we came up with this util method:
const double baseHeight = 650.0;

/// This method uses 'MediaQuery.of(context).size.height' which returns the actual device size in logical pixels.
/// It means, we can convert the device value so that the porpotions will remain the same.

double screenAwareSize(double size, BuildContext context) {
  return size * MediaQuery.of(context).size.height / baseHeight;
}
// TODO: EDIT: Actually, we should use MediaQuery.of(context).size.shortestSide which is already known as swDp on Android.
// It allows use to use the scaling both in landcscape and portrait. Thanks to Simon Lightfoot

/// Default 'Tween' animation will always tween from begin to end. In order to tween from min to max to min again.
/// create sinusoidal animation
class SinusoildalAnimation extends Animatable<double> {
  final double min;
  final double max;

  const SinusoildalAnimation({this.min, this.max});
  @override
  double transform(double t) {
    return min + (max - min) * math.sin(math.pi * t);
  }
}
