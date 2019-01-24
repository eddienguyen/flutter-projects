import 'package:flutter/material.dart';
import 'movie_detail_bloc.dart';
export 'movie_detail_bloc.dart';

class MovieDetailBlocProvider extends InheritedWidget {
  ///Using Scoped Instance BLoC approach
  ///This class extends the InheritedWidget and provide access to the bloc
  ///through the of(context) method. This of(context) is expecting a context as
  ///parameter. This context belongs to the screen which InheritedWidget has wrapped.
  ///In our case is the movie detail screen.
  final MovieDetailBloc bloc;

  MovieDetailBlocProvider({Key key, Widget child})
      : bloc = MovieDetailBloc(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(_) {
    return true;
  }

  static MovieDetailBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(MovieDetailBlocProvider)
            as MovieDetailBlocProvider)
        .bloc;
  }
}
