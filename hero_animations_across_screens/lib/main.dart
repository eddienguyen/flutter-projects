import 'package:flutter/material.dart';
import 'package:hero_animations_across_screens/screens/detail-screen.dart';

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
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Main screen'), elevation: 5.0,),
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(32.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => DetailScreen()));
              },
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10.0, spreadRadius: 5.0)]
                ),
                child: new ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                child: Hero(
                  tag: 'lakehero',
                  child: Image.network(
                  'https://raw.githubusercontent.com/flutter/website/master/src/_includes/code/layout/lakes/images/lake.jpg'),
                )
              )
              ),
            ),
          ),
        ));
  }
}
