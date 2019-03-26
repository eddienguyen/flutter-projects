import 'dart:convert';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'package:json_example/models/address_model.dart';

/// load JSON asset
Future<String> _loadAnAddressAsset() async {
  return await rootBundle.loadString('assets/data/address.json');
}

/// load the response
Future loadAddress() async {
  /// loading the raw JSON String from the asset
  String addressString = await _loadAnAddressAsset();

  /// decoding this raw json string we got
  final jsonResponse = json.decode(addressString);

  /// deserialize the decoded json by calling [Address.fromJson] method so the we can now use Address object to access the entities
  Address address = Address.fromJson(jsonResponse);

  print(address.city);
}
