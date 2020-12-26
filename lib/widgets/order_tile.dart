import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../provider/orders.dart';

class OrderTile extends StatelessWidget {
  final OrderItem order;
  OrderTile(this.order);
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text('Rs.${order.amount}'),
            subtitle: Text(
                '${DateFormat('dd MM yyyy hh:mm').format(order.dateTime)}'),
            trailing: IconButton(
              icon: Icon(Icons.expand_more),
              onPressed: (){},
            ),
          )
        ],
      ),
    );
  }
}
