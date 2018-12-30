import 'package:flutter/material.dart';

import 'routes/rendering_animation.dart';
import 'routes/simplifying_with_animatedwidget.dart';
import 'routes/refactoring_with_animationbuilder.dart';
import 'routes/simultaneous_animation.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Animation Demo',
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(title: 'Animations'),
        '/rendering-animation': (context) => LogoApp(),
        '/simplifying-animatedwidget': (context) => LogoAppSimplified(),
        '/refactoring-animation': (context) => RefactoringLogoApp(),
        '/simultaneous-animation': (context) => LogoAppSimultaneousAnimation(),
      },
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            RaisedButton(
              child: Text('Rendering animation'.toUpperCase()),
              onPressed: () {
                Navigator.pushNamed(context, '/rendering-animation');
              },
            ),
            RaisedButton(
              child: Text('Simplifying with animatedwidget'.toUpperCase()),
              onPressed: () {
                Navigator.pushNamed(context, '/simplifying-animatedwidget');
              },
            ),
            RaisedButton(
              child: Text('Refactoring with animationBuilder'.toUpperCase()),
              onPressed: () {
                Navigator.pushNamed(context, '/refactoring-animation');
              },
            ),
            RaisedButton(
              child: Text('Simultaneous animation'.toUpperCase()),
              onPressed: () {
                Navigator.pushNamed(context, '/simultaneous-animation');
              },
            ),
          ],
        ),
      ),
    );
  }
}
