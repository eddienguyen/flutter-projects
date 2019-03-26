import 'dart:convert';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'package:json_example/models/page_model.dart';

/// load JSON asset
Future<String> _loadAPageAsset() async {
  return await rootBundle.loadString('assets/data/page.json');
}

/// load the response
Future loadPage() async {
  /// loading the raw JSON String from the asset
  String pageString = await _loadAPageAsset();

  /// decode this raw JSON String we get
  final jsonResponse = json.decode(pageString);

  /// deserializing the decoded json by calling the [Page.fromJson] method so we can now use Page object to access the entities
  Page page = Page.fromJson(jsonResponse);
  return page;
  /// print to test
  // print(page.people[2].images[1].imageName);
}
