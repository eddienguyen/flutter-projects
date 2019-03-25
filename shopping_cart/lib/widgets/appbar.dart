import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget {
  Widget _buildTitle(String title) {
    return Container(
        alignment: Alignment.centerRight, child: Text(title.toUpperCase()));
  }

  Widget _buildCartButton() {
    return IconButton(
      icon: Icon(Icons.shopping_cart),
      color: Colors.black,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 3.0,
      child: new Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(color: Colors.yellow),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Expanded(
            flex: 2,
            child: _buildTitle('favorite'),
          ),
          Positioned(
            right: 0,
            child: _buildCartButton(),
          )
        ]),
      ),
    );
  }
}
