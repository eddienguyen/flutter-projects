import 'package:flutter/material.dart';
import 'package:bmi_calculator/config/widget_utils.dart'
    show SinusoildalAnimation, screenAwareSize;
import 'package:flutter_svg/flutter_svg.dart';

class PacmanSlider extends StatefulWidget {
  @override
  _PacmanSliderState createState() => _PacmanSliderState();
}

class _PacmanSliderState extends State<PacmanSlider>
    with TickerProviderStateMixin {
  final int numberOfDots = 10;
  final double minOpacity = 0.1;
  final double maxOpacity = 0.7;
  AnimationController shimmerDotsAnimationController;

  @override
  void initState() {
    super.initState();

    /// this controller's animation will take 1000millisecs and after another 800millisecs, it will run again from scratch.
    ///
    shimmerDotsAnimationController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    shimmerDotsAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(Duration(milliseconds: 800), () {
          shimmerDotsAnimationController.forward(from: 0.0);
        });
      }
    });

    shimmerDotsAnimationController.forward();
  }

  @override
  void dispose() {
    super.dispose();
    shimmerDotsAnimationController.dispose();
  }

  /// wrap middle dots with 'AnimatedBuilder', so that they'll be rebuilt alongside animation changes.
  Widget _generateDot(int dotNumber) {
    Animation animation = _initDotAnimation(dotNumber);
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Opacity(
          opacity: animation.value,
          child: child,
        );
      },
      child: Dot(size: 9.0),
    );
  }

  Animation<double> _initDotAnimation(int dotNumber) {
    double lastDotStartTime = 0.3;
    double dotAnimationDuration = 0.7;
    double begin = lastDotStartTime * dotNumber / numberOfDots;
    // double end = begin + dotAnimationDuration;
    /// specified Tween in which define the minimum and maximum values for the animations.
    return SinusoildalAnimation(min: minOpacity, max: maxOpacity)
        .animate(CurvedAnimation(
      parent: shimmerDotsAnimationController,
      curve: Interval(begin, begin + dotAnimationDuration),
    ));
  }

  // add 10 small dots with 'List.generate' inside Row
  // then add a bigger ones at the end of the list, wrap inside 'Opacity' of 0.5
  Widget _drawDots() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(numberOfDots, _generateDot)
        ..add(Opacity(
          opacity: maxOpacity,
          child: Dot(
            size: 14.0,
          ),
        )),
    );
  }

  @override
  Widget build(BuildContext context) {
    //specifies slider's height and decoration(with shape and color)
    return Container(
      height: screenAwareSize(52.0, context),
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Theme.of(context).primaryColor),
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: screenAwareSize(24.0, context)),
        child: Row(
          children: <Widget>[
            Pacman(),
            Expanded(child: _drawDots()),
          ],
        ),
      ),
    );
  }
}

class Dot extends StatelessWidget {
  final double size;
  const Dot({Key key, this.size}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenAwareSize(size, context),
      width: screenAwareSize(size, context),
      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
    );
  }
}

class Pacman extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: screenAwareSize(16.0, context)),
      child: SvgPicture.asset(
        'assets/images/pacman.svg',
        width: screenAwareSize(24, context),
        height: screenAwareSize(24.0, context),
      ),
    );
  }
}
