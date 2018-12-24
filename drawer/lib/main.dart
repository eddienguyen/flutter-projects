import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Drawer basics'),
        ),
        body: Center(
          child: Text('data'),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Text(
                  'Items',
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                ),
                decoration: BoxDecoration(color: Colors.blue),
              ),
              ListTile(
                title: Text('First Screen'),
                onTap: () {
                  // update the state of the app
                  
                  // then close the drawer
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Second Screen'),
                onTap: () {
                  // update the state of the app
                  // ...
                  // then close the drawer
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
