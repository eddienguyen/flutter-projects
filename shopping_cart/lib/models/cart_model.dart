import 'dart:collection';

import 'package:scoped_model/scoped_model.dart';
import 'package:shopping_cart/models/src/item.dart';
import 'package:flutter/material.dart';

class CartModel extends Model {
  // Internal, private state of the cart
  final List<Item> _items = [];

  /// an unmodifiable view of the items in the class
  UnmodifiableListView<Item> get items => UnmodifiableListView(_items);

  /// The current total price of all item in the cart(assuming all items cost $1)
  int get totalPrice => _items.length;

  /// Add [item] to cart. This is the only way to modify the cart from outside
  void add(Item item) {
    _items.add(item);
    // This call tells [Model] that it should rebuild the widgets that depend on it
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
