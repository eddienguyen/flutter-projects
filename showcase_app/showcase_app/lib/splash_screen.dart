import 'package:flutter/material.dart';
import 'config/screens.dart';

class StaggerAnimation extends StatelessWidget {
  StaggerAnimation({Key key, this.controller})
      : logoFade = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: controller,
            curve: Interval(0.0, 0.300, curve: Curves.fastOutSlowIn))),
        // logo scale down
        scaleDown = Tween(
          begin: 2.0,
          end: 1.0,
        ).animate(CurvedAnimation(
            parent: controller,
            curve: Interval(0.400, 1.0, curve: Curves.fastOutSlowIn))),
        // everywidget slide up from bottom
        slideUp = Tween<Offset>(begin: Offset(0.0, 1.0), end: Offset.zero)
            .animate(CurvedAnimation(
                parent: controller,
                curve: Interval(0.400, 1.0, curve: Curves.fastOutSlowIn))),
        // buttons and description fade in
        fade = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: controller,
            curve: Interval(0.400, 1.0, curve: Curves.fastOutSlowIn))),
        super(key: key);

  final Animation<double> controller;
  final Animation<double> logoFade;
  Animation<double> scaleDown;
  Animation<Offset> slideUp;
  Animation<double> fade;

  Widget _buildAnimation(BuildContext context, Widget child) {
    final logo = FadeTransition(
      opacity: logoFade,
      child: ScaleTransition(
        scale: scaleDown,
        child: Hero(
          tag: 'logoC2A',
          child: Image.asset(
            'assets/images/logo-c2a.png',
            width: 60.0,
            height: 60.0,
          ),
        ),
      ),
    );

    final description = new Text(
      'Welcome to C2A',
      style: Theme.of(context).textTheme.title,
    );
    return Container(
      color: Theme.of(context).backgroundColor,
      child: Stack(children: [
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 10.0),
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0, 10.0),
                        blurRadius: 10.0,
                      ),
                    ]),
                child: logo,
              ),
              FadeTransition(
                opacity: fade,
                child: Column(
                  children: <Widget>[
                    SlideTransition(
                      position: slideUp,
                      child: description,
                    ),
                    SlideTransition(
                      position: slideUp,
                      child: // Home button is permanent, only signed in account can access home screen
                          RaisedButton(
                        child: Text('Home'),
                        onPressed: () {
                          Navigator.of(context).pushNamedAndRemoveUntil(SCREEN.home, (Route<dynamic> route) => false);
                        },
                      ),
                    ),
                    SlideTransition(
                      position: slideUp,
                      child: RaisedButton(
                        child: Text('Sign in'),
                        onPressed: () {
                          print('pressed');
                        },
                      ),
                    ),
                    SlideTransition(
                      position: slideUp,
                      child: RaisedButton(
                        child: Text('Take a tour'),
                        onPressed: () {
                          print('object');
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ]),
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

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    _controller.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StaggerAnimation(
      controller: _controller.view,
    );
  }
}
