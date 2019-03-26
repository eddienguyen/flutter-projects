import 'dart:convert';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'package:json_example/models/student_model.dart';

/// load JSON asset
Future<String> _loadAStudentAsset() async {
  return await rootBundle.loadString('assets/data/student.json');
}

/// load the response
Future loadStudent() async {
  /// loading the raw JSON String from the asset
  String studentString = await _loadAStudentAsset();

  /// decoding this raw json string we got
  final jsonResponse = json.decode(studentString);

  /// deserializing the decoded json by calling the [Student.fromJson] method so that we can now use Student object to access the entities
  Student student = Student.fromJson(jsonResponse);

  /// print to test
  // print(student.studentname);
}
