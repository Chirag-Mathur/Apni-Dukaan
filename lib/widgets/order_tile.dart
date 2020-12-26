import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math';

import '../provider/orders.dart';

class OrderTile extends StatefulWidget {
  final OrderItem order;
  OrderTile(this.order);

  @override
  _OrderTileState createState() => _OrderTileState();
}

class _OrderTileState extends State<OrderTile> {
  var _expanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text('Rs.${widget.order.amount.toStringAsFixed(2)}'),
            subtitle: Text(
                '${DateFormat('dd/MM/yyyy hh:mm').format(widget.order.dateTime)}'),
            trailing: IconButton(
              icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
            ),
          ),
          if (_expanded)
            Container(
              height: min(widget.order.products.length * 20.0 + 10, 180),
              child: ListView(
                children: widget.order.products
                    .map((prod) => Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 2.0),
                          child: Row(
                            //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                prod.title,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Spacer(),
                              Text(
                                '${prod.quantity} x Rs.${prod.price}',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey
                                ),
                              ),
                            ],
                          ),
                        ))
                    .toList(),
              ),
            )
        ],
      ),
    );
  }
}
