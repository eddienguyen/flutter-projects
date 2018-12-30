import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter tutorial',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  TutorialHome createState() => new TutorialHome();
}

class TutorialHome extends State<HomePage> {
  int _bottomNavBarSelectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    // Scaffold is a layout for the major material components
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.menu),
            tooltip: 'Navigation menu',
            onPressed: null,
          ),
          title: Text('Example title'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              tooltip: 'Search',
              onPressed: null,
            )
          ],
        ),
        // body is a majority of the screen
        body: Center(
          child: Counter(),
        ),
        floatingActionButton: FloatingActionButton(
          tooltip: 'Add',
          child: Icon(Icons.add),
          onPressed: null,
          backgroundColor: Colors.cyan,
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.add_alert), title: Text('alert')),
            BottomNavigationBarItem(
                icon: Icon(Icons.add_alarm), title: Text('alarm')),
            BottomNavigationBarItem(
                icon: Icon(Icons.add_call), title: Text('call')),
          ],
          currentIndex: _bottomNavBarSelectedIndex,
          onTap: _onItemTapped,
        ));
  }

  void _onItemTapped(int index) {
    setState(() {
      _bottomNavBarSelectedIndex = index;
    });
  }
}

class CounterDisplay extends StatelessWidget {
  CounterDisplay({this.count});

  final int count;
  @override
  Widget build(BuildContext context) {
    return Text('Count: $count');
  }
}

class CounterIncrementor extends StatelessWidget {
  CounterIncrementor({this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text('Increment'),
      onPressed: onPressed,
    );
  }
}

class Counter extends StatefulWidget {
  @override
  _CounterState createState() => new _CounterState();
}

class _CounterState extends State<Counter> {
  int _counter = 0;

  void _increment() {
    setState(() {
      ++_counter;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        CounterIncrementor(onPressed: _increment),
        CounterDisplay(count: _counter)
      ],
    );
  }
}

class MyButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('button tapped!');
      },
      onDoubleTap: () {
        print('double tapped!');
      },
      child: Container(
        height: 36.0,
        width: 100,
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.symmetric(vertical: 20.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: Colors.lightGreen[500]),
        child: Center(
          child: Text('Engine'),
        ),
      ),
    );
  }
}
