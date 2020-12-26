import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/orders.dart';
import '../widgets/order_tile.dart';

class OrderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final ordersData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      body: ListView.builder(
        itemCount: ordersData.order.length,
        itemBuilder : (ctx, i) => OrderTile(ordersData.order[i]),
      ),

    );
  }
}
