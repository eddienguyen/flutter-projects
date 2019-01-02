import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        backgroundColor: Colors.black,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // Summary: GridView:
    // - lays widget out in a grid
    // - Detects when the column content exceeds the render box and automatically provides scrolling
    // - Build your own custom grid, or use one of the provided grids:
    //   + GridView.count allows you to specify the number of columns
    //   + GridView.extent allows you to specify the maximum pixel width of a tile

    List<Container> _buildGridTile(int count) {
      return List<Container>.generate(
          count,
          (int index) => Container(
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: const BorderRadius.all(const Radius.circular(5.0)),
                ),
                child: Image.asset('images/${index + 1}.png'),
              ));
    }

    Widget buildGrid() {
      return GridView.extent(
        maxCrossAxisExtent: 150.0,
        padding: const EdgeInsets.all(10.0),
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
        children: _buildGridTile(20),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(child: buildGrid()),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
