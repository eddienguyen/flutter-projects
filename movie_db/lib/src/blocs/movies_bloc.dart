import 'package:movie_db/src/resources/repository.dart';
import 'package:movie_db/src/models/item_model.dart';

import 'package:rxdart/rxdart.dart';

class MoviesBloc {
  //creating the repository class which will be used to access the fetchAllMovies()
  final _repository = Repository();

  //creating PublishSubject object whose responsibility is to add data it got from the server
  //in form of a Item Model
  //and pass it to the UI screen as stream.
  final _moviesFetcher = PublishSubject<ItemModel>();

  //to pass the Item Model as stream, we create another method allMovives() whose return type is a Observable
  Observable<ItemModel> get allMovies => _moviesFetcher.stream;

  fetchAllMovies() async {
    ItemModel itemModel = await _repository.fetchAllMovies();
    _moviesFetcher.sink.add(itemModel);
  }

  dispose() {
    _moviesFetcher.close();
  }
}

final bloc = MoviesBloc();
