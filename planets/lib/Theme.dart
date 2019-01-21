import 'package:flutter/material.dart';

class Style {
  static final baseTextStyle = const TextStyle(
    fontFamily: 'Poppins',
  );

  static final headerTextStyle = baseTextStyle.copyWith(
    color: Color(0xFFF9F7F0),
    fontSize: 18.0,
    fontWeight: FontWeight.w600,
  );

  static final regularTextStyle = baseTextStyle.copyWith(
    color: Color(0xFFB6B2DF),
    fontSize: 9.0,
    fontWeight: FontWeight.w400,
  );

  static final subHeaderTextStyle = regularTextStyle.copyWith(
    fontSize: 12.0,
  );

  static final titleTextStyle = baseTextStyle.copyWith(
      color: Color(0xFFF9F7F0),
      fontSize: 18.0, fontWeight: FontWeight.w600);

  static final commonTextStyle = baseTextStyle.copyWith(
      color: const Color(0xffb6b2df),
      fontSize: 14.0,
      fontWeight: FontWeight.w400);
}
