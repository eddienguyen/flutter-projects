import 'package:flutter/material.dart';

class BusinessesListFragment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        children: list,
      ),
    );
  }
}

List<Widget> list = <Widget>[
  ListTile(
    title: Text('CineArts at the Empire',
        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0)),
    subtitle: Text('85 W Portal Ave'),
    leading: Icon(
      Icons.theaters,
      color: Colors.blue[500],
    ),
  ),
  ListTile(
    title: Text('The Castro Theater',
        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0)),
    subtitle: Text('429 Castro St'),
    leading: Icon(
      Icons.theaters,
      color: Colors.blue[500],
    ),
  ),
  ListTile(
    title: Text('CineArts',
        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0)),
    subtitle: Text('85 W Portal Ave'),
    leading: Icon(
      Icons.theaters,
      color: Colors.blue[500],
    ),
  ),
  Divider(),
  ListTile(
    title: Text('Food',
        style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20.0)),
    subtitle: Text('data'),
    leading: Icon(
      Icons.kitchen,
      color: Colors.blue[500],
    ),
  ),
  ListTile(
    title: Text('Food',
        style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20.0)),
    subtitle: Text('data'),
    leading: Icon(
      Icons.kitchen,
      color: Colors.blue[500],
    ),
  ),
  ListTile(
    title: Text('Chaiya Thai Restaurant',
        style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20.0)),
    subtitle: Text('data'),
    leading: Icon(
      Icons.kitchen,
      color: Colors.blue[500],
    ),
  ),
];
