import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {

  AboutPage({Key key}) : super(key : key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AboutPageState();
  }
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      color: Colors.blueGrey,
      child: Center(
        child: Text('about page', style: Theme.of(context).textTheme.title),
      ),
    );
  }
}
