import 'dart:convert';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'package:json_example/models/photo_list_model.dart';

/// load JSON asset
Future<String> _loadAPhotoListAsset() async {
  return await rootBundle.loadString('assets/data/photo.json');
}

/// load the response
Future loadPhoto() async {
  /// load the raw JSON String from the asset
  String jsonString = await _loadAPhotoListAsset();

  /// decode this raw JSON String we got
  final jsonResponse = json.decode(jsonString);

  /// deserializing the decoded json by calling [PhotoList.fromJson] method so that we can now use PhotoList and Photo object to access the entities
  PhotoList photoList = PhotoList.fromJson(jsonResponse);

  /// print to test
  // print(photoList.photoList[1].url);
}
