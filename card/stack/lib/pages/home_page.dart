import 'package:flutter/material.dart';
import 'package:stack/fragments/contact_circle_avatar.dart';
import 'package:stack/fragments/contact_demo.dart';

class DrawerItem {
  final String name;
  final IconData icon;
  DrawerItem(this.name, this.icon);
}

class MyHomePage extends StatefulWidget {
  final drawerItems = [
    new DrawerItem('Contact Circle Avatar', Icons.account_circle),
    new DrawerItem('Contact demo', Icons.contacts)
  ];

  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedDrawerIndex = 0;

  _getSelectedIndex(int pos) {
    switch (pos) {
      case 0:
        return new ContactCircleAvatar();
      case 1:
        return new ContactDemo();
      default:
        return new Text('error');
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
        title: Text(d.name),
        leading: Icon(d.icon),
        selected: i == _selectedDrawerIndex,
        onTap: () {
          _onSelectedItem(i);
        },
      ));
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.drawerItems[_selectedDrawerIndex].name),
      ),
      body: _getSelectedIndex(_selectedDrawerIndex),
      drawer: new Drawer(
          child: new ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text(
              'Contacts with options',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.white,
                fontSize: 20.0,
              ),
            ),
          ),
          new Column(
            children: drawerOptions,
          ),
        ],
      )),
    );
  }
}
