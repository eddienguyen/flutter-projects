import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';

class CounterModel extends Model {
  int _counter = 0;
  String _username = "user";

  String get username => _username;
  int get counter => _counter;

  static CounterModel of(BuildContext context) =>
      ScopedModel.of<CounterModel>(context);

  void increment() {
    _counter++;
    notifyListeners();
  }
}
