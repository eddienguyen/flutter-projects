import 'package:flutter/material.dart';

class DiscoverPage extends StatefulWidget {
  DiscoverPage({Key key}) : super(key : key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _DiscoverPageState();
  }
}

class _DiscoverPageState extends State<DiscoverPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      color: Colors.cyan,
      child: Center(
        child: Text('discover page', style: Theme.of(context).textTheme.title),
      ),
    );
  }
}
