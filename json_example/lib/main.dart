import 'package:flutter/material.dart';
import 'package:json_example/data/page_services.dart';
import 'package:json_example/models/page_model.dart';

void main() {
  runApp(MyApp());
  loadPage();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: new Scaffold(
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text('json example'), _buildContent()]),
    ));
  }
}

Widget _buildContent() {
  return FutureBuilder<dynamic>(
    future: loadPage(),
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      if (snapshot.hasData) {
        print(snapshot.data);
        // var people = snapshot.data.people;
        // return Text(person.firstName);
        return Center(
          child: Container(
            width: 100.0,
            height: 200.0,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                var person = snapshot.data.people[index];
                return Text(person.firstName);
              },
              itemCount: snapshot.data.people.length,
            ),
          ),
        );
      } else {
        return new Container(
          child: Text('no data available'),
        );
      }
    },
  );
}
