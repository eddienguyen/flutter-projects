import 'package:bmi_calculator/pages/ResultPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bmi_calculator/theme/styles.dart';

import 'pages/InputPage.dart';

void main() {
  // change status bar : white color with dark icons
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white, // <-- top bar color
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white, // <-- bottom bar color
      systemNavigationBarIconBrightness: Brightness.dark));

  // prevent landscape orientation:
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((_) => runApp(new MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BMI Calculator',
      theme: ThemeData(
        // This is the theme of your application.
        primaryColor: mainBlue,
        fontFamily: 'SF Pro Display',
        primarySwatch: Colors.blue,
      ),
      home: InputPage(),
    );
  }
}
