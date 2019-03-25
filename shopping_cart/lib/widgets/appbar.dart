import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget {
  final String title;
  final Widget rightAction;

  const MyAppBar({Key key, this.title, this.rightAction}) : super(key: key);

  Widget _buildTitle(String title) {
    return Container(
        alignment: Alignment.center, child: Text(title.toUpperCase()));
  }

  Widget _buildCartButton() {
    return rightAction ?? Text(' ');
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 3.0,
      child: new Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(color: Theme.of(context).primaryColor),
        child: Stack(alignment: Alignment.center, children: [
          _buildTitle(this.title),
          Positioned(
            right: 0,
            child: _buildCartButton(),
          )
        ]),
      ),
    );
  }
}
