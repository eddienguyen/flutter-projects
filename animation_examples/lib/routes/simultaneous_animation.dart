import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

class _AnimatedLogo extends AnimatedWidget {
  _AnimatedLogo({Key key, Animation<double> animation})
      : super(key: key, listenable: animation);
  // the Tweends are static because they don't change
  final _opacityTween = Tween<double>(begin: 0.1, end: 1.0);
  final _sizeTween = Tween<double>(begin: 0.0, end: 200.0);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;

    return Stack(
      alignment: AlignmentDirectional.center,
      children: <Widget>[
        Opacity(
          opacity: _opacityTween.evaluate(animation),
          child: Container(
            width: _sizeTween.evaluate(animation),
            height: _sizeTween.evaluate(animation),
            margin: const EdgeInsets.symmetric(vertical: 16.0),
            child: FlutterLogo(),
          ),
        ),
        Container(
          width: animation.isCompleted ? 100.0 : 0.0,
          alignment: FractionalOffset.bottomCenter,
          child: RaisedButton(
            child: Text(
              'Back'.toUpperCase(),
              style: TextStyle(
                  color: animation.isCompleted
                      ? Colors.black
                      : Colors.transparent),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        )
      ],
    );
  }
}

class LogoAppSimultaneousAnimation extends StatefulWidget {
  @override
  _LogoAppSimultaneousAnimation createState() =>
      _LogoAppSimultaneousAnimation();
}

class _LogoAppSimultaneousAnimation extends State<LogoAppSimultaneousAnimation>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return _AnimatedLogo(animation: animation);
  }
}
