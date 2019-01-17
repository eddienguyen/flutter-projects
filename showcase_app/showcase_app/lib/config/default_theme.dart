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
              color: Color(0xFF1E1E1E)
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
      primaryColor: Color(0xFF2A2A2A),
      primaryColorDark: Color(0xFF1E1E1E) ,
      primaryColorLight: Colors.white,
      accentColor: Color(0xFFED1C24),
      highlightColor: Colors.yellow,
      backgroundColor: Colors.black,
      textTheme: originalTextTheme.copyWith(
        title: TextStyle(
          fontFamily: 'Gotham',
          fontSize: 32,
          color: Colors.white
        )
      ),
      
    );
  }
}
