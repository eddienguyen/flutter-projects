import 'package:movie_db/src/resources/repository.dart';
import 'package:movie_db/src/models/trailer_model.dart';

import 'package:rxdart/rxdart.dart';

class MovieDetailBloc {
  ///Using RxDart.Transformers to help chaining 2 or more Subjects and get the final result
  ///perform operation on the input data from the 1st Subject and will pipe it
  ///to the next Subject.
  ///
  ///In this example: adding the movieId to the _movieId which is a PublistSubject.
  ///We will pass the movieId to the ScanStreamTransformer which in turn will make a network call the trailer API
  ///and get the results.
  ///then pipe it to the _trailers which is a BehaviorSubject.
  ///finally using Observable.
  final _respository = Repository();
  final _movieId = PublishSubject<int>();
  final _trailers = BehaviorSubject<Future<TrailerModel>>();

  Function(int) get fetchTrailersById => _movieId.sink.add;
  Observable<Future<TrailerModel>> get movieTrailers => _trailers.stream;

  MovieDetailBloc() {
    _movieId.stream.transform(_itemTransformer()).pipe(_trailers);
  }

  dispose() async {
    _movieId.close();
    await _trailers.drain();
    _trailers.close();
  }

  _itemTransformer() {
    return ScanStreamTransformer(
        (Future<TrailerModel> trailer, int id, int index) {
      print(index);
      trailer = _respository.fetchAllTrailers(id);
      return trailer;
    });
  }
}
