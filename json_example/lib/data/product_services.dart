import 'dart:convert';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'package:json_example/models/product_model.dart';

/// load json asset
Future<String> _loadAProductAsset() async {
  return await rootBundle.loadString('assets/data/product.json');
}

/// load the response
Future loadProduct() async {
  /// loading the raw JSON String from the asset
  String productString = await _loadAProductAsset();

  /// decoding this raw json string
  final jsonResponse = json.decode(productString);

  /// deserialize the decoded json by calling the [Product.fromJson] method so that we can now use Product object to access the entities
  Product product = Product.fromJson(jsonResponse);

  /// print to test
  // print(product.productImages[0].imageName);
}
