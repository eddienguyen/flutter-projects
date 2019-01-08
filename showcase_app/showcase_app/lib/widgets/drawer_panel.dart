import 'package:flutter/material.dart';

class DrawerPanel extends StatefulWidget {
  @override
  _DrawerPanelState createState() => _DrawerPanelState();
}

class _DrawerPanelState extends State<DrawerPanel> {
  bool _shouldShow = true;

  void _show() {
    setState(() {
      _shouldShow = true;
    });
  }

  void _hide() {
    setState(() {
      _shouldShow = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget container = Container(
      child: Stack(
        children: <Widget>[
          Opacity(
            opacity: 0.5,
            child: Container(),
          ),
          Container(
            color: Theme.of(context).primaryColor,
            width: MediaQuery.of(context).size.width * 0.8,
            padding: const EdgeInsets.only(top: 60.0),
            child: Column(
              children: <Widget>[Text('this is DrawerPanel')],
            ),
          )
        ],
      ),
    );

    return (_shouldShow) ? container : Container();
  }
}
