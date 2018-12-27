import 'package:flutter/material.dart';
import 'package:navigate_with_named_routes/pages/first-page.dart';
import 'package:navigate_with_named_routes/pages/second-page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: MyHomePage(title: 'Navigate with named routes'),
      initialRoute: '/',  // => start the App with the '/' route. In our case, the app will start on the "MyHomePage" widget
      routes: {
        '/': (context) => MyHomePage(title: 'Navigate with named routes'),
        '/first-page': (context) => FirstPage(),
        '/second-page': (context) => SecondPage()
      },
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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'tap one of the button to navigate',
            ),
            RaisedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/first-page');
              },
              child: Container(
                width: 100,
                child: Center(
                  child: Text('to 1st page'),
                ),
              ),
            ),
            RaisedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/second-page');
              },
              child: Container(
                width: 100,
                child: Center(
                  child: Text('to 2nd page'),
                ),
              ),
            )
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
