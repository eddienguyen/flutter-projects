import 'package:flutter/material.dart';

class StoryPage extends StatefulWidget {
  StoryPage({Key key}) : super(key : key);
  @override
  _StoryPageState createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.lightBlueAccent,
      child: Center(
        child: Text('this is StoryPage'),
      ),
    );
  }
}
