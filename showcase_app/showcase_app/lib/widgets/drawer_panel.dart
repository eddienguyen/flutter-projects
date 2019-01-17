import 'package:flutter/material.dart';

enum _PanelAnimationStatus { open, closed, animating }

class DrawerPanel extends StatefulWidget {
  final bool shouldShow;

  DrawerPanel({Key key, this.shouldShow}) : super(key: key);

  @override
  _DrawerPanelState createState() => _DrawerPanelState();
}

class _DrawerPanelState extends State<DrawerPanel>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> translateAnimation;
  Animation<double> opacityFadeAnimation;
  _PanelAnimationStatus animationStatus = _PanelAnimationStatus.closed;

  void _show() {
    setState(() {
      controller.forward().orCancel;
    });
  }

  void _hide() {
    setState(() {
      controller.reverse().orCancel;
    });
  }

  void _onItemButtonPressed() {
    print("clicked");
  }

  @override
  void initState() {
    super.initState();

    controller = new AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          ///
          /// When the animation is at the end, the menu is open
          ///
          animationStatus = _PanelAnimationStatus.open;
        } else if (status == AnimationStatus.dismissed) {
          ///
          /// When the animation is at the beginning, the menu is closed
          ///
          animationStatus = _PanelAnimationStatus.closed;
        } else {
          // is animating
          animationStatus = _PanelAnimationStatus.animating;
        }
      });

    translateAnimation =
        new Tween(begin: 1.0, end: 0.0).animate(new CurvedAnimation(
      parent: controller,
      curve: Interval(0.0, 0.8, curve: Curves.fastOutSlowIn),
//            reverseCurve: Curves.easeIn
    ));

    opacityFadeAnimation = new Tween(begin: 0.0, end: 1.0).animate(
        new CurvedAnimation(
            parent: controller,
            curve: Interval(0.7, 1.0, curve: Curves.easeIn)));
  }

  @override
  void didUpdateWidget(DrawerPanel oldWidget) {
    if (widget.shouldShow) {
      _show();
    } else {
      _hide();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double offsetWidth = -(screenWidth * 0.5);

    Widget container = Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Transform.translate(
            offset: Offset(offsetWidth * translateAnimation.value, 0.0),
            child: Container(
              width: screenWidth * 0.5,
              color: Theme.of(context)
                  .primaryColor
                  .withOpacity(opacityFadeAnimation.value),
              padding: const EdgeInsets.only(top: 100.0),
              child: Column(
                children: <Widget>[
                  // header
                  Text('DrawerPanel', style: Theme.of(context).textTheme.body1),
                  ListView.builder(
                    itemCount: 4,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return FlatButton(
                        child: Text('button $index'),
                        onPressed: () {
                          _onItemButtonPressed();
                        },
                      );
                    },
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: Opacity(
              opacity: opacityFadeAnimation.value,
              child: GestureDetector(
                child: Container(
                  color: Color.fromRGBO(0, 0, 0, 0.8),
                  width: screenWidth,
                ),
                onTapUp: (TapUpDetails details) {
                  print('close panel by tapping opacity and details: $details');
                  _hide();
                },
              ),
            ),
          ),
        ],
      ),
    );

    return container;
  }
}
