import 'dart:convert';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'package:json_example/models/shape_model.dart';

/// load JSON asset:
Future<String> _loadAShapeAsset() async {
  return await rootBundle.loadString('assets/data/shape.json');
}

/// load the response
Future loadShape() async {
  /// loading the raw JSON String from the asset
  String shapeString = await _loadAShapeAsset();

  /// decode
  final jsonResponse = json.decode(shapeString);

  /// deserialize the decoded string by calling the [Shape.fromJson] method so that we can now use the Shape object to access the entites
  Shape shape = Shape.fromJson(jsonResponse);

  /// print ou to test
  // print(shape.shapeProperty.breadth);
}
