import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'api_key.dart';

class Movie {
  final String title, poster_path, overview;

  Movie(this.title, this.poster_path, this.overview);

  Movie.fromJson(Map json)
      : title = json["title"],
        poster_path = json["poster_path"],
        overview = json["overview"];
}

class API {
  final http.Client _client = http.Client();

  static const String url = "$baseUrl/search/movie?api=$api_key&query={1}";

  // function which will replace "1" in the brackets with the query that the user is typing in
  Future<List<Movie>> get(String query) async {
    List<Movie> list = [];
  }
}
