import 'package:flutter/material.dart';

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      appBar: AppBar(
        title: Text('First Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('this is First page'),
            RaisedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Container(
                width: 100,
                child: Center(
                  child: Text('go home'.toUpperCase()),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
