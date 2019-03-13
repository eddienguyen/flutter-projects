import 'package:bloc_movie_example/theme/page_styles.dart';
import 'package:bloc_movie_example/widgets/app_bar.dart';
import 'package:flutter/material.dart';

import 'package:bloc_movie_example/model.dart';
import 'package:bloc_movie_example/blocs/query_bloc.dart';
import 'package:bloc_movie_example/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MovieProvider(
      queryBloc: QueryBloc(API()),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(title: 'Flutter Demo Home Page'),
      ),
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
  final controller = TextEditingController(text: '12');
  QueryBloc queryBloc;
  @override
  void initState() {
    controller.addListener(onChanged);
    // queryBloc.stream.listen(controller.text);
    super.initState();
  }

  onChanged() {
    print(controller.text);
    queryBloc.query.add;
  }

  @override
  Widget build(BuildContext context) {
    queryBloc = MovieProvider.of(context);
   

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(appBarHeight(context)),
        child: MaterialAppBar(
          title: widget.title,
          // searchOnChange: (text) => {queryBloc.query.add},
          editingController: this.controller,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // Container(
          //   padding: EdgeInsets.all(10.0),
          //   child: TextField(
          //     onChanged: queryBloc.query.add,
          //     decoration: InputDecoration(
          //         border: OutlineInputBorder(), hintText: 'Search for a movie'),
          //   ),
          // ),
          StreamBuilder(
            stream: queryBloc.log,
            builder: (context, snapshot) => Container(
                  child: Text(snapshot?.data ?? ''),
                ),
          ),
          Flexible(
            child: StreamBuilder(
              stream: queryBloc.results,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: CircleAvatar(
                        child: Image.network('https://image.tmdb.org/t/p/w92' +
                            snapshot.data[index].posterPath),
                      ),
                      title: Text(snapshot.data[index].title),
                      subtitle: Text(snapshot.data[index].overview),
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
