import 'movie_api_provider.dart';
import 'package:movie_db/src/models/item_model.dart';

/// This is the central point from where the data will flow to the BLoC

class Repository {
  final moviesApiProvider = MovieApiProvider();

  Future<ItemModel> fetchAllMovies() =>
      moviesApiProvider.fetchPopularMovieList();
}
