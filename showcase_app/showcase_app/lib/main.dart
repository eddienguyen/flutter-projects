import 'package:flutter/material.dart';
import 'package:showcase_app/config/default_theme.dart';

// screens
import 'splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: DefaultTheme.light,
      home: new SplashScreen()
      );
  }
}

