import 'package:flutter/material.dart';
import 'data/crossword_parser.dart';

void main() {
  runApp(MyApp());
  loadCrossword();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: new Scaffold(
      body: Container(
        child: Text('json example'),
      ),
    ));
  }
}
