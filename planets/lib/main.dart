import 'package:flutter/material.dart';
import 'package:planets/ui/home/DetailPage.dart';
import 'package:planets/ui/home/HomePage.dart';

void main() {
  // Routes.initRoutes();
  runApp(new MaterialApp(
    title: 'Planets',
    home: new HomePage(),
//    routes: <String, WidgetBuilder>{
//      '/detail': (_) => new DetailPage(),
//    },
  ));
}

///Color(0xFF0A4065),
///Color(0xFF22CADE),
///Color(0xFFF9F7F0),
///Color(0xFFC4C4C4),