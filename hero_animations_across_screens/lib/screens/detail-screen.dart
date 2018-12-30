import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: Container(
      decoration: BoxDecoration(color: Colors.black),
      child: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Hero(
            tag: 'lakehero',
            child: Image.network(
                'https://raw.githubusercontent.com/flutter/website/master/src/_includes/code/layout/lakes/images/lake.jpg'),
          )),
    ));
  }
}
