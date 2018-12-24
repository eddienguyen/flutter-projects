import 'package:flutter/material.dart';
import 'package:list_view/fragments/businesses_list_fragment.dart';
import 'package:list_view/fragments/colors_list_fragment.dart';

class DrawerItem {
  String title;
  IconData icon;
  DrawerItem(this.title, this.icon);
}

class MyHomePage extends StatefulWidget {
  final drawerItems = [
    new DrawerItem('Businesses', Icons.business),
    new DrawerItem('Colors', Icons.color_lens),
  ];

  MyHomePage({Key key, this.title}) : super(key: key);

  String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedDrawerIndex = 0;

  _getSelectedIndex(int position) {
    switch (position) {
      case 0:
        return BusinessesListFragment();
      case 1:
        return ColorsListFragment();
      default:
        return new Text('Error');
    }
  }

  _onSelectedItem(int index) {
    setState(() {
      _selectedDrawerIndex = index;
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    var drawerOptions = <Widget>[];
    for (var i = 0; i < widget.drawerItems.length; i++) {
      var d = widget.drawerItems[i];
      drawerOptions.add(new ListTile(
        leading: Icon(d.icon),
        title: Text(d.title),
        selected: i == _selectedDrawerIndex,
        onTap: () {
          _onSelectedItem(i);
        },
      ));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.drawerItems[_selectedDrawerIndex].title),
        elevation: 2.0, // Removing the drop shadow cast by the app bar.
      ),
      drawer: new Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text(
                'Lists',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  fontSize: 20.0
                  ),
                ),
              decoration: BoxDecoration(
                color: Colors.blueGrey
              ),
            ),
            new Column(
              children: drawerOptions,
            )
          ],
        ),
      ),
      body: _getSelectedIndex(_selectedDrawerIndex),
    );
  }
}
