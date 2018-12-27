import 'package:flutter/material.dart';

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('this is 2nd page'),
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
