import 'package:flutter/material.dart';

import 'package:card/fragments/icon_card.dart';
import 'package:card/fragments/image_card.dart';

class DrawerItem {
  final IconData icon;
  final String name;

  DrawerItem({this.icon, this.name});
}

class HomePage extends StatefulWidget {
  final drawerItems = [
    new DrawerItem(icon: Icons.card_giftcard, name: 'icon card'),
    new DrawerItem(icon: Icons.card_membership, name: 'image card'),
  ];

  HomePage({Key key}) : super(key: key);

  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedDrawerIndex = 0;

  _getSelectedIndex(int pos) {
    switch (pos) {
      case 0:
        return new IconCard();
      case 1:
        return new ImageCard();
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
    for (int i = 0; i < widget.drawerItems.length; i++) {
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
        title: Text('app bar'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text(
                'Cards'.toUpperCase(),
                style: TextStyle(fontSize: 20.0),
              ),
            ),
            new Column(
              children: drawerOptions,
            )
          ],
        ),
      ),
      body: Center(
        child: _getSelectedIndex(_selectedDrawerIndex),
      ),
    );
  }
}
