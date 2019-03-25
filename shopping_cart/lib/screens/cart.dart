import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shopping_cart/models/cart_model.dart';
import 'package:shopping_cart/widgets/appbar.dart';

class MyCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 60.0),
        child: MyAppBar(
          title: 'Cart',
          rightAction: ScopedModelDescendant<CartModel>(
            builder: (context, child, cart) {
              return IconButton(
                icon: Icon(Icons.delete),
                onPressed: (() => cart.clear()),
              );
            },
          ),
        ),
      ),
      body: new Container(
        child: Column(
          children: <Widget>[_CartList(), _CartTotal()],
        ),
      ),
    );
  }
}

class _CartList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ScopedModelDescendant<CartModel>(
        builder: (context, child, cart) => ListView(
              children: cart.items
                  .map((item) => Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18.0, vertical: 8.0),
                        height: 32.0,
                        child: Text(
                          item.name,
                          style: Theme.of(context).textTheme.title,
                        ),
                      ))
                  .toList(),
            ),
      ),
    );
  }
}

class _CartTotal extends StatelessWidget {
  const _CartTotal({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScopedModelDescendant<CartModel>(
            builder: (context, child, cart) {
              return Text(
                'Total: ${cart.totalPrice} \$',
                style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
              );
            },
          ),
        ],
      ),
    );
  }
}
