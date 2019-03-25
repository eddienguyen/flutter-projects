import 'package:flutter/material.dart';
import 'package:shopping_cart/models/cart_model.dart';
import 'package:shopping_cart/models/src/item.dart';
import 'package:shopping_cart/widgets/appbar.dart';
import 'package:scoped_model/scoped_model.dart';

class MyCatalog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 60.0),
        child: MyAppBar(
          title: 'catalog',
          rightAction: IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: (() => {Navigator.pushNamed(context, './cart')}),
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: SizedBox(
              height: 12,
            ),
          ),
          SliverList(
            delegate:
                SliverChildBuilderDelegate((context, index) => CartItem(index)),
          ),
        ],
      ),
    );
  }
}

class CartItem extends StatelessWidget {
  final int index;

  final Item item;

  CartItem(this.index, {Key key})
      : item = Item(index),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(this.item.name),
          _AddButton(
            item: item,
          )
        ],
      ),
    );
  }
}

class _AddButton extends StatelessWidget {
  final Item item;

  const _AddButton({@required this.item, Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<CartModel>(
      builder: (context, child, cart) {
        return FlatButton(
          onPressed: (() => cart.items.contains(item) ? null : cart.add(item)),
          splashColor: Colors.yellow,
          child: cart.items.contains(item) ? Icon(Icons.check) : Text('Add'),
        );
      },
    );
  }
}
