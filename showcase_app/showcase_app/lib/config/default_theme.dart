import 'package:flutter/material.dart';

class DefaultTheme {
  static get light {
    final originalTextTheme = ThemeData.light().textTheme;
    
    return ThemeData.light().copyWith(
      backgroundColor: Colors.white,
      textTheme: originalTextTheme.copyWith(
        body1: TextStyle(
          fontFamily: 'Gotham',
        ),
        title: TextStyle(
          fontFamily: 'Gotham',
          color: Colors.black,
          fontSize: 32
        )
      )
    );
  }
  static get dark {
    final originalTextTheme = ThemeData.dark().textTheme;
    return ThemeData.dark().copyWith(
      backgroundColor: Color(0xFF1E1E1E),
      textTheme: originalTextTheme.copyWith(

      ),
    );
  }
}