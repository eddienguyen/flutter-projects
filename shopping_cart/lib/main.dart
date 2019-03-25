import 'package:flutter/material.dart';
import 'package:shopping_cart/models/cart_model.dart';
import 'package:shopping_cart/screens/cart.dart';
import 'package:shopping_cart/screens/catalog.dart';
import 'package:shopping_cart/widgets/appbar.dart';
import 'package:scoped_model/scoped_model.dart';

void main() {
  final cart = CartModel();

  // optionally connect [cart] with some database here.

  runApp(ScopedModel<CartModel>(
    /// <= "ScopedModel of CartModel"
    model: cart,
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: true,
      theme: ThemeData(
        primarySwatch: Colors.yellow
      ),
      routes: {
        '/' : (context) => MyCatalog(),
        './cart': (context) => MyCart(),
      },
      initialRoute: '/',
    );
  }
}
