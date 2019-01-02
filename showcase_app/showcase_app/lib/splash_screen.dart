import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen> {
  final logo = Image.asset(
    'assets/images/logo-c2a.png',
    width: 60.0,
    height: 60.0,
  );

  @override
  Widget build(BuildContext context) {
    final description = Text(
      'Welcome to myApp',
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
              description
            ],
          ),
        ),
      ]),
    );
  }
}
