import 'package:flutter/material.dart';

import 'draggable_scroll_bar.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  //provide the same scrollController for list and draggableScrollbar
  final ScrollController scrollController = ScrollController();

  PageController pageController = PageController(
    initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
          appBar: new AppBar(
            title: Text('Draggable Scroll Bar Demo'),
          ),
          //DraggableScrollbar builds Stack with provided Scrollable List of Grid
          body: PageView(
            controller: pageController,
            children: <Widget>[
              new Stack(
                alignment: Alignment.topCenter,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 20.0),
                    child: CustomScrollView(
                      scrollDirection: Axis.vertical,
                      slivers: <Widget>[
                        SliverAppBar(
                          snap: true,
                          floating: true,
                          title: Text('custom scroll view'),
                        ),
                        SliverList(
                          delegate: SliverChildListDelegate([
                            Container(
                              height: 300.0,
                              padding: const EdgeInsets.all(10.0),
                              child: Stack(
                                children: <Widget>[
                                  new ListView.builder(
                                    itemCount: 10,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (BuildContext context, int index) {
                                      return Container(
                                        height: 200.0,
                                        width: MediaQuery.of(context).size.width,
                                        color: Colors.grey[300],
                                        child: Text('List item'),
                                      );
                                    },
                                  )
                                ],
                              ),
                            )
                          ]),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              new Center(
                  child: Container(
                width: 200,
                height: 200,
                child: PageView(
                  children: <Widget>[
                    Container(
                      height: 50,
                      width: 200,
                      margin: EdgeInsets.all(5.0),
                      alignment: Alignment.center,
                      color: Colors.blue,
                      child: new Text('index'),
                    ),
                    Container(
                      height: 50,
                      width: 200,
                      alignment: Alignment.center,
                      margin: EdgeInsets.all(5.0),
                      color: Colors.green,
                      child: new Text('index 2'),
                    ),
                    Container(
                      height: 50,
                      width: 200,
                      alignment: Alignment.center,
                      margin: EdgeInsets.all(5.0),
                      color: Colors.amber,
                      child: new Text('index 3'),
                    ),
                    Container(
                      height: 50,
                      width: 200,
                      alignment: Alignment.center,
                      margin: EdgeInsets.all(5.0),
                      color: Colors.brown,
                      child: new Text('index 4'),
                    ),
                  ],
                ),
              )),
              new DraggableScrollBar(
                child: Container(
                  height: 50.0,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 50,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.all(5.0),
                        color: Colors.grey,
                        child: new Text('$index'),
                      );
                    },
                  ),
                ),
                scrollThumbHeight: 40.0,
                controller: scrollController,
              ),
              new DraggableScrollBar(
                child: _buildGrid(),
                scrollThumbHeight: 30.0,
                controller: scrollController,
              )
            ],
          )),
    );
  }

  // the list/grid
  Widget _buildGrid() {
    return GridView.builder(
      controller: scrollController,
      itemCount: 100,
      padding: EdgeInsets.zero,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
      ),
      itemBuilder: (BuildContext context, int index) {
        if (index == 3) {
          return ListView.builder(
            padding: EdgeInsets.all(10.0),
            scrollDirection: Axis.horizontal,
            itemCount: 10,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                width: MediaQuery.of(context).size.width,
                height: 100,
                child: new Text('$index'),
              );
            },
          );
        } else {
          return Container(
            color: Colors.grey[300],
            alignment: Alignment.center,
            margin: EdgeInsets.all(1.0),
            child: new Text('$index'),
          );
        }
      },
    );
  }

  // the scrollthumb: build inside draggable_scroll_bar.dart

}
