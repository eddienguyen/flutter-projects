import 'package:flutter/material.dart';

class Colors {
  const Colors();

  static const Color gold = const Color(0xFFE59F2B);
  static const Color white = const Color(0xFFFFFFFF);
  static const Color grey = const Color(0xFFA8A9AB);
  static const Color darkPurple = const Color(0xFF35234B);
  static const Color purple = const Color(0xFF5C3B6F);
  static const Color pink = const Color(0xFFFF8484);
  static const Color darkPink = const Color(0xFFD84C73);
}

class Style {
  static final baseTextStyle = const TextStyle(fontFamily: 'Futura');

  static final headerTextStyle = baseTextStyle.copyWith(
    fontSize: 24.0,
    fontFamily: 'Gotham',
    fontWeight: FontWeight.w700,
    color: Color(0xFFF9F7F0),
  );

  static final regularTextStyle = baseTextStyle.copyWith(
    color: Color(0xFFB6B2DF),
    fontSize: 11.0,
    fontWeight: FontWeight.w400,
  );

  static final movieTitleTextStyle = regularTextStyle.copyWith(
    color: Colors.white,
    fontSize: 18.0,
    fontWeight: FontWeight.w700
  );
}
