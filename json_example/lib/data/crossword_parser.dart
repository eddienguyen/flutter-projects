import 'dart:convert';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'package:json_example/models/crossword_model.dart';

Future<String> _fetchCrosswordAsset() async {
  return await rootBundle.loadString('assets/data/crossword.json');
}

Future loadCrossword() async {
  String jsonCrossword = await _fetchCrosswordAsset();
  Crossword crossword = _parseJsonForCrossword(jsonCrossword);
}

Crossword _parseJsonForCrossword(String jsonString) {
  // Map decoded = jsonDecode(jsonString);
  Map decoded = json.decode(jsonString);

  return Crossword.fromJson(decoded);
}
