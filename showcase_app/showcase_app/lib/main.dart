import 'package:flutter/material.dart';
import 'package:showcase_app/config/default_theme.dart';

// screens
import 'config/screens.dart';
import 'splash_screen.dart';
import 'home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: DefaultTheme.light, 
      home: new SplashScreen(),
      routes: {
        SCREEN.loading : (BuildContext context) => new SplashScreen(),
        SCREEN.home : (BuildContext context) => new HomeScreen(),
      },
      );
  }
}
