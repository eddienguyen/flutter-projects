import 'package:fancy_tab_bar/widgets/fancy_tab_bar.dart';
import 'package:flutter/material.dart';

void main() => runApp(FTBApp());

class FTBApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('Bottom Tab Bar'),
      ),
      bottomNavigationBar: FancyTabBar(),
      body: new Container(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Text('hi'),
        ),
      ),
    );
  }
}
