import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:bloc_movie_example/model.dart';

class QueryBloc {
  final API api;
  // StreamController _queryController = new StreamController();

  /// stream to using with list of movies
  Stream<List<Movie>> _results = Stream.empty();

  /// stream to log all of query and stuff from the app
  Stream<String> _log = Stream.empty();

  /// rxdart's ReplaySubject allow us to admit the Observer of all items that emitted from the source regardless of scubcription
  /// delay when we add query to our function
  ReplaySubject<String> _query = ReplaySubject<String>();

  Stream<String> get log => _log;
  Stream<List<Movie>> get results => _results;
  Sink<String> get query => _query;

  QueryBloc(this.api) {
    // distinct: when user typing, then multiple events will be throw out, distinct() will make sure if these events are the same, only specify one.
    _results = _query.distinct().asyncMap(api.get).asBroadcastStream();

    _log = Observable(results)
        .withLatestFrom(_query.stream, (_, query) => 'Results for $query')
        .asBroadcastStream();
  }

  void dispose() {
    _query.close();
  }
}
