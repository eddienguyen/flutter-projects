import 'package:flutter/material.dart';

import 'package:movie_db/src/blocs/movies_bloc.dart';
import 'package:movie_db/src/models/item_model.dart';
import 'package:movie_db/src/ui/gradient_appbar.dart';
import 'package:movie_db/src/ui/movie_summary.dart';
import 'package:movie_db/src/ui/theme.dart' as Theme;

class PopularMovieList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PopularMovieListState();
  }
}

class PopularMovieListState extends State<PopularMovieList> {
  @override
  void initState() {
    super.initState();
    bloc.fetchAllMovies();
  }

  @override
  void dispose() {
    super.dispose();
    bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Column(
        children: <Widget>[
          GradientAppbar('popular'),
          Expanded(
            child: Container(
              color: Theme.Colors.darkPurple,
              child: StreamBuilder(
                stream: bloc.allMovies,
                builder: (context, AsyncSnapshot<ItemModel> snapshot) {
                  if (snapshot.hasData) {
                    // return new Text(
                    //   snapshot.data.toString(),
                    //   style: Theme.Style.regularTextStyle
                    // );
                    return CustomScrollView(
                      scrollDirection: Axis.vertical,
                      slivers: <Widget>[
                        SliverList(
                          delegate:
                              SliverChildBuilderDelegate((context, index) {
                            var movie = snapshot.data.results[index];
                            return new MovieSummary(
                                movie.vote_count,
                                movie.id,
                                movie.vote_average,
                                movie.title,
                                movie.popularity,
                                movie.poster_path);
                          }, childCount: snapshot.data.results.length),
                        )
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return new Text(snapshot.error,
                        style: Theme.Style.regularTextStyle);
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}