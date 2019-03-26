import 'package:flutter/material.dart';
import 'package:json_example/data/page_services.dart';
import 'package:json_example/data/photo_services.dart';

import 'data/crossword_parser.dart';

void main() {
  runApp(MyApp());
  loadPage();
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
