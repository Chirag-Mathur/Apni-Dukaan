import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/cart.dart';


class CartTile extends StatelessWidget {
  final String id;
  final String productId;
  final String title;
  final int quantity;
  final double price;

  CartTile(this.id, this.productId, this.title, this.quantity, this.price);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        color: Colors.red,
        child: Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Icon(
            Icons.delete,
            color: Colors.white,
            size: 30,
          ),
        ),
        alignment: Alignment.centerRight,
      ),
      direction: DismissDirection.endToStart,
     onDismissed: (direction){
       Provider.of<Cart>(context, listen: false).deleteItem(productId);
     },
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: FittedBox(
                  child: Text('Rs.$price'),
                ),
              ),
            ),
            title: Text(title),
            subtitle: Text('Total Amount Rs.${quantity * price}'),
            trailing: Text('$quantity x'),
          ),
        ),
      ),
    );
  }
}
