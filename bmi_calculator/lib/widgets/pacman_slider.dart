import 'package:flutter/material.dart';
import 'package:bmi_calculator/config/widget_utils.dart'
    show SinusoildalAnimation, screenAwareSize;
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math' as math;

const double _sliderHorizontalMargin = 24.0;
const double _pacmanWidth = 24.0;
// const double _dotsLeftMargin = 8.0;

class PacmanSlider extends StatefulWidget {
  final VoidCallback onSubmit;
  final AnimationController
      submitAnimationController; //Add AnimationController paramter

  PacmanSlider({Key key, this.onSubmit, this.submitAnimationController})
      : super(key: key);

  @override
  _PacmanSliderState createState() {
    return new _PacmanSliderState();
  }
}

class _PacmanSliderState extends State<PacmanSlider>
    with TickerProviderStateMixin {
  /// specify how far from the left should the pacman be positioned
  double _pacmanPosition = 24.0;
  AnimationController pacmanMovementController;
  Animation<double> pacmanAnimation;
  Animation<double> submitWidthAnimation;
  Animation<BorderRadius> _borderAnimation;

  double get width => submitWidthAnimation?.value ?? 0.0;

  @override
  void initState() {
    super.initState();
    pacmanMovementController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );

    _borderAnimation = BorderRadiusTween(
            begin: BorderRadius.circular(8.0), end: BorderRadius.circular(50.0))
        .animate(CurvedAnimation(
            parent: widget.submitAnimationController,
            curve: Interval(0.0, 0.07) //specify interval from 0 to 7%
            ));
  }

  @override
  void dispose() {
    pacmanMovementController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        submitWidthAnimation = Tween<double>(
          begin: constraints.maxWidth, // start with constraints's max width
          end: screenAwareSize(
              52.0, context), // finish with width equals to height
        ).animate(CurvedAnimation(
          parent: widget
              .submitAnimationController, // build with the same animation controller...
          curve: Interval(0.05,
              0.15), // ... but in different time frame from border animation
        ));
        return AnimatedBuilder(
          animation: widget.submitAnimationController,
          builder: (context, child) {
            //specifies slider's height and decoration(with shape and color)
            Decoration decoration = BoxDecoration(
                borderRadius: _borderAnimation.value,
                color: Theme.of(context).primaryColor);

            return Center(
              child: Container(
                height: screenAwareSize(52.0, context),
                width: width,
                decoration: decoration,

                /// use LayoutBuilder to get the maximum restrict of the Pacman's slide position
                child: submitWidthAnimation.isDismissed
                    ? GestureDetector(
                        // behavior: HitTestBehavior.translucent,
                        /// add another option: click to submit, besides slide to submit
                        onTap: () => _animatePacmanToEnd(constraints.maxWidth),
                        child: Stack(
                          alignment: Alignment.centerRight,
                          children: <Widget>[
                            AnimatedDots(),
                            _drawDotCurtain(decoration,
                                width: constraints.maxWidth),
                            _drawPacman(width: constraints.maxWidth),
                          ],
                        ),
                      )
                    : Container(),
              ),
            );
          },
        );
      },
    );
  }

  Widget _drawPacman({double width}) {
    /// check if we have access to the Widget's max width
    /// and if the animation isn't initialized earlier
    if (pacmanAnimation == null && width != 0.0) {
      pacmanAnimation = _initPacmanAnimation(width);
    }
    return Positioned(
      // left: screenAwareSize(_pacmanPosition, context),
      left: _pacmanPosition,
      child: GestureDetector(
        onHorizontalDragUpdate: (details) => _onPacmanDrag(width, details),
        onHorizontalDragEnd: (details) => _onPacmanDragEnd(width, details),
        child: PacmanIcon(),
      ),
    );
  }

  /// Add a curtain which moves alongside with pacman to cover the dots,
  ///  which is just a Container using the same decoration as the slider's b  ackground.
  Widget _drawDotCurtain(Decoration decoration, {double width = 0.0}) {
    if (width == 0.0) {
      return Container();
    }

    double marginRight =
        width - _pacmanPosition - screenAwareSize(_pacmanWidth / 2, context);
    return Positioned.fill(
      right: marginRight,
      child: Container(decoration: decoration),
    );
  }

  _onPacmanDrag(double maxWidth, DragUpdateDetails details) {
    setState(() {
      _pacmanPosition += details.delta.dx;
      _pacmanPosition = math.max(_pacmanMinPosition(),
          math.min(_pacmanMaxPosition(maxWidth), _pacmanPosition));
    });
  }

  /// Reset _pacmanPosition if the slide ended before the center
  /// and animate to the end if the slide ended after the center
  _onPacmanDragEnd(double maxWidth, DragEndDetails details) {
    bool isOverHalf = _pacmanPosition + screenAwareSize(_pacmanWidth, context) >
        maxWidth * 0.5;

    if (isOverHalf) {
      // animate to the end
      _animatePacmanToEnd(maxWidth);
    } else {
      _resetPacman();
    }
  }

  _resetPacman() {
    if (this.mounted) {
      setState(() {
        _pacmanPosition = _pacmanMinPosition();
      });
    }
  }

  _onPacmanSubmitted() {
    // temporary: fake calculate when slide pacman
    widget?.onSubmit();
    Future.delayed(Duration(seconds: 1), () => _resetPacman());
  }

  _animatePacmanToEnd(double width) {
    pacmanMovementController.forward(
        from: _pacmanPosition / _pacmanMaxPosition(width));
  }

  double _pacmanMinPosition() =>
      screenAwareSize(_sliderHorizontalMargin, context);

  double _pacmanMaxPosition(double sliderWidth) =>
      sliderWidth -
      screenAwareSize(_pacmanWidth + _sliderHorizontalMargin / 2, context);

  Animation<double> _initPacmanAnimation(double width) {
    Animation<double> animation =
        Tween(begin: _pacmanMinPosition(), end: _pacmanMaxPosition(width))
            .animate(pacmanMovementController);

    /// add a listener so that on every animation change, _pacmanPosition will get updated
    animation.addListener(() {
      setState(() {
        _pacmanPosition = animation.value;
      });

      /// check if the animation has been completed, to add some sort of callback when the user actually finised the process
      if (animation.status == AnimationStatus.completed) {
        _onPacmanSubmitted();
      }
    });
    return animation;
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

class AnimatedDots extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _AnimatedDots();
}

class _AnimatedDots extends State<AnimatedDots> with TickerProviderStateMixin {
  final int numberOfDots = 10;
  final double minOpacity = 0.1;
  final double maxOpacity = 0.7;
  AnimationController shimmerDotsAnimationController;

  @override
  void initState() {
    super.initState();

    /// this controller's animation will take 1000millisecs and after another 800millisecs, it will run again from scratch.
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
    shimmerDotsAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenAwareSize(25.0, context)),
      child: Row(
        // add 10 small dots with 'List.generate' inside Row
        // then add a bigger ones at the end of the list, wrap inside 'Opacity' of 0.5

        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: List.generate(numberOfDots, _generateDots)
          ..add(Opacity(
            opacity: maxOpacity,
            child: Dot(size: 14.0),
          )),
      ),
    );
  }

  /// wrap middle dots with 'AnimatedBuilder', so that they'll be rebuilt alongside animation changes.
  Widget _generateDots(int dotNumber) {
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
    double lastDotStartTime = 0.4;
    double dotAnimationDuration = 0.6;
    double begin = lastDotStartTime * dotNumber / numberOfDots;
    double end = begin + dotAnimationDuration;
    return SinusoildalAnimation(min: minOpacity, max: maxOpacity)
        .animate(CurvedAnimation(
      parent: shimmerDotsAnimationController,
      curve: Interval(begin, end),
    ));
  }
}

class PacmanIcon extends StatelessWidget {
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
