import 'package:flutter/material.dart';

class DefaultTheme {
  static get light {
    final originalTextTheme = ThemeData.light().textTheme;
    // final originalButtonTheme = ThemeData.light().buttonTheme;

    return ThemeData.light().copyWith(
        backgroundColor: Colors.white,
        // primaryColor: Colors.white,
        // accentColor: Colors.white,
        bottomAppBarColor: Color(0xFF1E1E1E),
        textTheme: originalTextTheme.copyWith(
            body1: TextStyle(
              fontFamily: 'Gotham',
            ),
            title: TextStyle(
                fontFamily: 'Gotham', color: Colors.black, fontSize: 32)),
        // buttonTheme: originalButtonTheme.copyWith(
        //   // shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(5.0)),
        //   buttonColor: Colors.black,
        //   disabledColor: Colors.grey[300],
        //   // highlightColor: Colors.white,
        //   textTheme: ButtonTextTheme.normal,
        //   // splashColor: Colors.white
        // )
        );
      
  }

  static get dark {
    final originalTextTheme = ThemeData.dark().textTheme;
    return ThemeData.dark().copyWith(
      backgroundColor: Color(0xFF1E1E1E),
      textTheme: originalTextTheme.copyWith(),
    );
  }
}
