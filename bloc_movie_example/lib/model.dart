import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'api_key.dart';

class Movie {
  final String title, posterPath, overview;

  Movie(this.title, this.posterPath, this.overview);

  Movie.fromJson(Map json)
      : title = json["title"],
        posterPath = json["poster_path"],
        overview = json["overview"];
}

class API {
  final http.Client _client = http.Client();

  static const String _url = "$baseUrl/search/movie?api_key=$api_key&query={1}";

  // function which will replace "1" in the brackets with the query that the user is typing in
  Future<List<Movie>> get(String query) async {
    List<Movie> list = [];

    // parse URL with URI dot parse
    await _client
        .get(Uri.parse(_url.replaceFirst("{1}", query)))
        .then((response) => response.body)
        .then(json.decode)
        .then((json) => json['results'])
        .then((movies) =>
            movies.forEach((movie) => list.add(Movie.fromJson(movie))));

    return list;
  }
}
