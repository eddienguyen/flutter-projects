import 'package:fancy_tab_bar/config/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:fancy_tab_bar/theme/page_styles.dart';
import 'tab_item.dart';

import 'package:vector_math/vector_math.dart' as vector;

class FancyTabBar extends StatefulWidget {
  @override
  _FancyTabBarState createState() => _FancyTabBarState();
}

class _FancyTabBarState extends State<FancyTabBar>
    with TickerProviderStateMixin {
  IconData activeIcon = Icons.search;
  double currentSelected = 1;
  Tween<double> _positionTween;
  Animation<double> _positionAnimation;
  AnimationController _animationController;

  @override
  void initState() {
    _animationController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: ANIMATION_DURATION));
    _positionTween = Tween<double>(begin: 0, end: 0);

    _positionAnimation = _positionTween.animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeOut))
      ..addListener(() => setState(() {}));
    super.initState();
  }

  _initAnimationAndStart(double from, double to) {
    _positionTween.begin = from;
    _positionTween.end = to;

    _animationController.reset();
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          constraints: BoxConstraints(
            minHeight: appBarHeight(context),
            maxHeight: screenAwareSize(90.0, context),
          ),
          // height: appBarHeight(context),
          margin: EdgeInsets.only(top: screenAwareSize(25.0, context)),
          width: double.infinity,
          decoration: BoxDecoration(color: Colors.white),
          child: SafeArea(
            bottom: true,
            top: false,
            left: false,
            right: false,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                TabItem(
                  title: 'home',
                  iconData: Icons.home,
                  selected: currentSelected == 0,
                  onPress: () => {
                        setState(() => {
                              activeIcon = Icons.home,
                              currentSelected = 0,
                            }),
                        _initAnimationAndStart(_positionAnimation.value, -1)
                      },
                ),
                TabItem(
                  title: 'search',
                  iconData: Icons.search,
                  selected: currentSelected == 1,
                  onPress: () => {
                        setState(() => {
                              activeIcon = Icons.search,
                              currentSelected = 1,
                            }),
                        _initAnimationAndStart(_positionAnimation.value, 0)
                      },
                ),
                TabItem(
                  title: 'user',
                  iconData: Icons.person,
                  selected: currentSelected == 2,
                  onPress: () => {
                        setState(() => {
                              activeIcon = Icons.person,
                              currentSelected = 2,
                            }),
                        _initAnimationAndStart(_positionAnimation.value, 1)
                      },
                ),
              ],
            ),
          ),
        ),
        // IgnorePointer on actived tabitem because we don't want it to be tapped ?
        IgnorePointer(
          child: Container(
            color: Colors.transparent,
            child: Align(
              alignment: Alignment(_positionAnimation.value, 0),
              heightFactor: 1,
              child: FractionallySizedBox(
                widthFactor: 1 / 3,
                child: Stack(alignment: Alignment.center, children: [
                  SizedBox(
                    width: screenAwareSize(60.0, context),
                    height: screenAwareSize(50.0, context),
                    child: new CustomPaint(
                      painter: ArcPainter(),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    color: Colors.transparent,
                    child: Container(
                      constraints: BoxConstraints(
                        maxWidth: screenAwareSize(50.0, context),
                        maxHeight: screenAwareSize(50.0, context),
                      ),
                      decoration: BoxDecoration(
                          color: Colors.white, shape: BoxShape.circle),
                      padding: EdgeInsets.all(5.0),
                      child: Center(
                        child: Container(
                          width: screenAwareSize(45.0, context),
                          height: screenAwareSize(45.0, context),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: PURPLE),
                          child: Icon(activeIcon, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class ArcPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Rect beforeRect = Rect.fromLTWH(0, (size.height / 2) - 10, 10, 10);
    final Rect largeRect = Rect.fromLTWH(10, 0, size.width - 20, 70);
    final Rect afterRect =
        Rect.fromLTWH(size.width - 10, (size.height / 2) - 10, 10, 10);

    final path = Path();
    path.arcTo(beforeRect, vector.radians(0), vector.radians(90), false);
    path.lineTo(20, size.height / 2);
    path.arcTo(largeRect, vector.radians(0), -vector.radians(180), false);
    path.moveTo(size.width - 10, size.height / 2);
    path.lineTo(size.width - 10, (size.height / 2) - 10);
    path.arcTo(afterRect, vector.radians(180), vector.radians(-90), false);
    path.close();

    canvas.drawPath(path, Paint()..color = Colors.black);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
