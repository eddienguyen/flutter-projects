import 'package:flutter/material.dart';
import 'package:shopping_cart/widgets/appbar.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(double.infinity, 60.0),
          child: MyAppBar(),
        ),
        body: new Center(
          child: new Text("this is MyApp"),
        ),
      ),
    );
  }
}
