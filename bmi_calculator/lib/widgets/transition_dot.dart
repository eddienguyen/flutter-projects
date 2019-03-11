import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../config/widget_utils.dart' show screenAwareSize;

/// extends AnimatedWidget instead AnimatedBuilder
/// means it will rebuilt every time the animation from constructor changes its value.
class TransitionDot extends AnimatedWidget {
  TransitionDot({Key key, Listenable animation})
      : super(key: key, listenable: animation);

  Animation<int> get positionAnimation =>
      IntTween(begin: 0, end: 50).animate(CurvedAnimation(
        parent: super.listenable,
        curve: Interval(0.15, 0.3),
      ));

  Animation<double> get sizeAnimation => LoopedSizeAnimation().animate(
      CurvedAnimation(parent: super.listenable, curve: Interval(0.3, 0.8)));
  @override
  Widget build(BuildContext context) {
    double scaledSize = screenAwareSize(
        sizeAnimation.value, context); // get size from animation
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    double width = math.min(scaledSize,
        deviceWidth); // make sure scaledWidth isn't bigger than the screen
    double height = math.min(scaledSize,
        deviceHeight); // make sure scaledHeight isn't bigger than the screen
    Decoration decoration = BoxDecoration(
        shape: width < 0.9 * deviceWidth
            ? BoxShape.circle
            : BoxShape
                .rectangle, // make sure that dot changes shape when it get close to the edge of the screen. Otherwise, it wouldn't be able to cover the screen.
        color: Theme.of(context).primaryColor);

    /// The idea is take place of old slider and make it appear in the same position the slider ended up shrinking down.
    Widget dot = Container(
      decoration: decoration,
      width: width,
      height: height,
    );

    /// wrap the whole widget inside IgnorePointer, so that it can cover the whole screen and not interact with all the control.
    return IgnorePointer(
      child: Opacity(
        /// specify the widget's opacity. If the animation's value is below 0.15(the point where the slider animation ends),
        /// the opacity is 0, otherwise make it visible.
        // opacity: (super.listenable as Animation).value > 0.15 ? 1.0 : 0.0,
        opacity: positionAnimation.value > 0 ? 1.0 : 0.0,
        child: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,

              /// Spacer is a widget that takes as much space as posible, it also has attribute flex that act like a css's flex child attr, means it can specify the relation of of how much space of the whole container multiple spaces should take
              children: [
                Spacer(flex: 104 - positionAnimation.value),
                dot,
                Spacer(flex: 4 + positionAnimation.value)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Since the TransitionDot uses the animation that has Interval we can't use repeat (https://marcinszalek.pl/flutter/bmi-calculator-in-flutter-part-7-animated-transition/)
/// so we're going to create our own Animatable
class LoopedSizeAnimation extends Animatable<double> {
  final double defaultSize = 52.0;
  final double expansionSize = 30.0;
  final int numberOfCycles = 2;
  final double fullExpansionEdge =
      0.8; // mark a point in time, after that the dot stop pulsing and start expanding.
  @override
  double transform(double t) {
    /// if the time(t) of the animation is below 80%, it will be pulsing.
    /// After that, it will rapidly growing from logical 52 pixel to 2000 pixel, which should cover the whole screen
    if (t < fullExpansionEdge) {
      double normalizedT = t / fullExpansionEdge;

      /// we use sin function to handle changing size back and forward.
      /// it will change from defaultSize to defaultSize + expansionSize to defaultSize - expansionSize and go back to defaultSize 2 times.
      return defaultSize +
          math.sin(numberOfCycles * 2 * math.pi * normalizedT) * expansionSize;
    } else {
      double normalizedT = (t - fullExpansionEdge) / (1 - fullExpansionEdge);
      return defaultSize + normalizedT * 2000.0;
    }
  }
}
