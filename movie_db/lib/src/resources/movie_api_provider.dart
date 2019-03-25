import 'dart:async' show Future;
import 'dart:convert';

import 'package:http/http.dart' show Client;
import 'package:movie_db/src/models/item_model.dart';
import 'package:movie_db/src/models/trailer_model.dart';

class MovieApiProvider {
  var client = Client();
  final _api_key = '7cebf953286b4c15871fa0d115c40a18';
  final _baseUrl = 'https://api.themoviedb.org/3/movie';

  Future<ItemModel> fetchPopularMovieList() async {
   
    final response = await client.get('$_baseUrl/popular?api_key=$_api_key');

    if (response.statusCode == 200) {
      return ItemModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error on fetching PopularMovieList');
    }
  }

  Future<TrailerModel> fetchTrailers(int movieId) async {
     print('begin fetching...');
    final response =
        await client.get('$_baseUrl/$movieId/videos?api_key=$_api_key');

    if (response.statusCode == 200) {
      return TrailerModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error on fetching MovieTraierList');
    }
  }
}
