import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:flutter/animation.dart';

class StaggerAnimation extends StatelessWidget {
  StaggerAnimation({Key key, this.controller})
      : opacity = Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(0.0, 0.100, curve: Curves.ease),
          ),
        ),
        width = Tween<double>(begin: 50.0, end: 150.0).animate(CurvedAnimation(
            parent: controller,
            curve: Interval(0.125, 0.250, curve: Curves.ease))),
        height = Tween<double>(begin: 50.0, end: 150.0).animate(CurvedAnimation(
            parent: controller,
            curve: Interval(0.250, 0.375, curve: Curves.ease))),
        padding = EdgeInsetsTween(
                begin: const EdgeInsets.only(bottom: 16.0),
                end: const EdgeInsets.only(bottom: 75.0))
            .animate(CurvedAnimation(
                parent: controller,
                curve: Interval(0.250, 0.375, curve: Curves.ease))),
        color = ColorTween(
          begin: Colors.indigo[200],
          end: Colors.orange[200],
        ).animate(CurvedAnimation(
            parent: controller,
            curve: Interval(0.500, 0.750, curve: Curves.ease))),
        border = BorderRadiusTween(
          begin: BorderRadius.all(Radius.circular(4.0)),
          end: BorderRadius.all(Radius.circular(100.0)),
        ).animate(CurvedAnimation(
            parent: controller,
            curve: Interval(0.375, 0.500, curve: Curves.ease))),
        super(key: key);

  final Animation<double> controller;
  final Animation<double> opacity;
  final Animation<double> width;
  final Animation<double> height;
  final Animation<EdgeInsets> padding;
  final Animation<Color> color;
  final Animation<BorderRadius> border;

  Widget _buildAnimation(BuildContext context, Widget child) {
    return Container(
      padding: padding.value,
      alignment: Alignment.bottomCenter,
      child: Opacity(
        opacity: opacity.value,
        child: Container(
          width: width.value,
          height: height.value,
          decoration: BoxDecoration(
              color: color.value,
              border: Border.all(
                color: Colors.indigo[200],
                width: 3.0,
              ),
              borderRadius: border.value),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: _buildAnimation,
      animation: controller,
    );
  }
}

class StaggerDemo extends StatefulWidget {
  @override
  _StaggerDemoState createState() {
    return _StaggerDemoState();
  }
}

class _StaggerDemoState extends State<StaggerDemo>
    with TickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  Future<void> _playAnimation() async {
    try {
      await _controller.forward().orCancel;
      await _controller.reverse().orCancel;
    } on TickerCanceled {}
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 1.0;
    return Scaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          _playAnimation();
        },
        child: Center(
          child: Container(
              width: 300.0,
              height: 300.0,
              decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.1),
                  border: Border.all(color: Colors.black.withOpacity(0.5))),
              child: StaggerAnimation(
                controller: _controller.view,
              )),
        ),
      ),
    );
  }
}

void main() => runApp(MaterialApp(
      home: StaggerDemo(),
    ));
