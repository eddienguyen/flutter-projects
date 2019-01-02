import 'package:flutter/material.dart';
import 'dart:math';

Color _getRandomColor() {
  var rnd = new Random();
  return new Color((rnd.nextDouble() * 0xFFFFFF).toInt() << 0).withOpacity(0.6);
}

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}
class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(),
          // SliverList(delegate: SliverChildBuilderDelegate(
          //   (BuildContext context, int index) {
          //     return Container(
          //       decoration: BoxDecoration(color: _getRandomColor()),
          //       height: 50.0,
          //     );
          //   },
          // )),

          // SliverGrid(
          //   gridDelegate:
          //       SliverGridDelegateWithFixedCrossAxisCount(
          //         crossAxisCount: 4,
          //         ),
          //   delegate:
          //       SliverChildBuilderDelegate((BuildContext context, int index) {
          //     return Container(
          //       decoration: BoxDecoration(color: _getRandomColor()),
          //       height: 50.0,
          //       margin: const EdgeInsets.all(10.0),
          //     );
          //   }),
          // )

          SliverGrid.extent(
            maxCrossAxisExtent: ,
          )
        ],
      ),
    );
  }
}

void main() => runApp(MaterialApp(
      title: 'Sliver, Demystified',
      home: HomePage(),
    ));
