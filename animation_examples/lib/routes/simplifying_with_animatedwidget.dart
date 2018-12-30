import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

class AnimatedLogo extends AnimatedWidget {
  AnimatedLogo({Key key, Animation<double> animation})
      : super(key: key, listenable: animation);
  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return Stack(
      alignment: AlignmentDirectional.center,
      children: <Widget>[
        Container(
            margin: const EdgeInsets.all(16.0),
            width: animation.value,
            height: animation.value,
            child: FlutterLogo()),
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
        ),
      ],
    );
  }
}

class LogoAppSimplified extends StatefulWidget {
  @override
  _LogoAppState createState() => _LogoAppState();
}

class _LogoAppState extends State<LogoAppSimplified>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = new AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    animation = Tween(begin: 0.0, end: 200.0).animate(controller);
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedLogo(
        animation: animation,
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
