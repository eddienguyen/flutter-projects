import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class FancyTabBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          height: 100.0,
          width: double.infinity,
          decoration: BoxDecoration(color: Colors.white),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(
                child: Column(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.home),
                      onPressed: () => print('home pressed'),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Text('HOME')
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () => print('search pressed'),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Text('SEARCH')
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.person),
                      onPressed: () => print('user pressed'),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Text('USER')
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          constraints: BoxConstraints(maxWidth: 50.0, maxHeight: 50.0),
          decoration:
              BoxDecoration(color: Colors.white, shape: BoxShape.circle),
          padding: EdgeInsets.all(0.0),
          child: Center(
            child: Container(
              width: 50.0,
              height: 50.0,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).primaryColor),
              child: Icon(Icons.search, color: Colors.white),
            ),
          ),
        )
      ],
    );
  }
}
