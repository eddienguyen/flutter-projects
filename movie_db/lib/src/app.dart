import 'package:flutter/material.dart';
import 'package:movie_db/src/ui/popular_movie_list.dart';
import 'package:movie_db/src/ui/theme.dart' as Theme;

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'The Movie Database',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Theme.Colors.darkPurple
      ),
      home: new PopularMovieList(),
    );
  }
}
