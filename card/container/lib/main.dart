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
      ),
      home: MyHomePage(title: 'The Container layout page'),
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
    var container = Container(
      decoration: BoxDecoration(
        color: Colors.black26,
        borderRadius: const BorderRadius.all(const Radius.circular(5.0)),
      ),
      child: Column(children: [
        Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 2.0, color: Colors.black45),
                  color: Colors.grey,
                ),
                margin: const EdgeInsets.all(5.0),
                child: Image.asset('images/125_2.png'),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 2.0, color: Colors.black45),
                  color: Colors.grey,
                ),
                margin: const EdgeInsets.all(5.0),
                child: Image.asset('images/125_4.png'),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 2.0, color: Colors.black45),
                  color: Colors.grey,
                ),
                margin: const EdgeInsets.all(5.0),
                child: Image.asset('images/125_3.png'),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 2.0, color: Colors.black45),
                  color: Colors.grey,
                ),
                margin: const EdgeInsets.all(5.0),
                child: Image.asset('images/125_5.png'),
              ),
            ),
          ],
        ),
      ]),
    );

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: container,
        ));
  }
}
