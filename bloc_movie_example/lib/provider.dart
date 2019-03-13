import 'package:bloc_movie_example/blocs/query_bloc.dart';
import 'package:bloc_movie_example/model.dart';
import 'package:flutter/widgets.dart';

class MovieProvider extends InheritedWidget {
  final QueryBloc queryBloc;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static QueryBloc of(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(MovieProvider) as MovieProvider).queryBloc;

  MovieProvider({Key key, QueryBloc queryBloc, Widget child})
      : this.queryBloc = queryBloc ?? QueryBloc(API()),
        super(key: key, child: child);
}
