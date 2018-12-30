<<<<<<< HEAD
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    var descTextStyle = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w800,
      fontFamily: 'Roboto',
      letterSpacing: 0.5,
      fontSize: 14.0,
      height: 2.0,
      decoration: TextDecoration.none,
    );

    var ratings = Container(
        padding: EdgeInsets.all(5.0),
        child: new Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              child: new Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Expanded(
                    child: Icon(Icons.star, color: Colors.black),
                  ),
                  Expanded(
                    child: Icon(Icons.star, color: Colors.black),
                  ),
                  Expanded(
                    child: Icon(Icons.star, color: Colors.black),
                  ),
                  Expanded(
                    child: Icon(Icons.star, color: Colors.black),
                  ),
                  Expanded(
                    child: Icon(Icons.star, color: Colors.black),
                  ),
                ],
              ),
            ),
            new Text(
              '170 Reviews',
              style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'Roboto',
                  letterSpacing: 0.5,
                  color: Colors.black,
                  decoration: TextDecoration.none),
            )
          ],
        ));
    // DefaultTextStyle.merge allows you to create a default text
    // style that is inherited by its child and all subsequent children.
    var iconList = DefaultTextStyle.merge(
        style: descTextStyle,
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Icon(Icons.kitchen, color: Colors.green[500]),
                  Text('PREP'),
                  Text('25 mins')
                ],
              ),
              Column(
                children: <Widget>[
                  Icon(Icons.timer, color: Colors.green[500]),
                  Text('COOK'),
                  Text('1 hr')
                ],
              ),
              Column(
                children: <Widget>[
                  Icon(Icons.restaurant, color: Colors.green[500]),
                  Text('FEEDS'),
                  Text('4 - 6')
                ],
              ),
            ],
          ),
        ));

    return MaterialApp(
      title: 'layout_a_widget',
      theme: ThemeData.dark(),
      home: Container(
          padding: EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(0.5),
            color: Colors.white,
          ),
          child: Center(
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  new Flexible(
                      child: new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      new Text(
                        'Strawberry Pavlova',
                        style: TextStyle(
                          color: Colors.black,
                          decoration: TextDecoration.none,
                          fontSize: 14.0,
                        ),
                      ),
                      new Text(
                        'Row and Column are basic primitive widgets for horizontal and vertical layouts—these low-level widgets allow for maximum customization',
                        style: TextStyle(
                          color: Colors.black,
                          decoration: TextDecoration.none,
                          fontSize: 14.0,
                        ),
                      ),
                      ratings,
                      iconList,
                    ],
                  )),
                  Expanded(
                    child: Center(
                      child: new Image.asset('images/10.jpg',
                          width: 150.0, fit: BoxFit.cover),
                    ),
                  )
                ]),
          )),
    );
  }
}
=======
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    var descTextStyle = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w800,
      fontFamily: 'Roboto',
      letterSpacing: 0.5,
      fontSize: 14.0,
      height: 2.0,
      decoration: TextDecoration.none,
    );

    var ratings = Container(
        padding: EdgeInsets.all(5.0),
        child: new Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              child: new Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Expanded(
                    child: Icon(Icons.star, color: Colors.black),
                  ),
                  Expanded(
                    child: Icon(Icons.star, color: Colors.black),
                  ),
                  Expanded(
                    child: Icon(Icons.star, color: Colors.black),
                  ),
                  Expanded(
                    child: Icon(Icons.star, color: Colors.black),
                  ),
                  Expanded(
                    child: Icon(Icons.star, color: Colors.black),
                  ),
                ],
              ),
            ),
            new Text(
              '170 Reviews',
              style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'Roboto',
                  letterSpacing: 0.5,
                  color: Colors.black,
                  decoration: TextDecoration.none),
            )
          ],
        ));
    // DefaultTextStyle.merge allows you to create a default text
    // style that is inherited by its child and all subsequent children.
    var iconList = DefaultTextStyle.merge(
        style: descTextStyle,
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Icon(Icons.kitchen, color: Colors.green[500]),
                  Text('PREP'),
                  Text('25 mins')
                ],
              ),
              Column(
                children: <Widget>[
                  Icon(Icons.timer, color: Colors.green[500]),
                  Text('COOK'),
                  Text('1 hr')
                ],
              ),
              Column(
                children: <Widget>[
                  Icon(Icons.restaurant, color: Colors.green[500]),
                  Text('FEEDS'),
                  Text('4 - 6')
                ],
              ),
            ],
          ),
        ));

    return MaterialApp(
      title: 'layout_a_widget',
      theme: ThemeData.dark(),
      home: Container(
          padding: EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(0.5),
            color: Colors.white,
          ),
          child: Center(
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  new Flexible(
                      child: new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      new Text(
                        'Strawberry Pavlova',
                        style: TextStyle(
                          color: Colors.black,
                          decoration: TextDecoration.none,
                          fontSize: 14.0,
                        ),
                      ),
                      new Text(
                        'Row and Column are basic primitive widgets for horizontal and vertical layouts—these low-level widgets allow for maximum customization',
                        style: TextStyle(
                          color: Colors.black,
                          decoration: TextDecoration.none,
                          fontSize: 14.0,
                        ),
                      ),
                      ratings,
                      iconList,
                    ],
                  )),
                  Expanded(
                    child: Center(
                      child: new Image.asset('images/10.jpg',
                          width: 150.0, fit: BoxFit.cover),
                    ),
                  )
                ]),
          )),
    );
  }
}
>>>>>>> c8c0d6c985cd2979c1000df9e9a54cb57550bd40
