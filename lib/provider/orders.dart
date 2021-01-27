import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../provider/cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    @required this.id,
    @required this.amount,
    @required this.products,
    @required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _order = [];

  List<OrderItem> get order {
    return [..._order];
  }

  Future<void> fetchAndSyncOrders() async {
    const url =
        "https://apni-dukaan-405bb-default-rtdb.firebaseio.com/orders.json";

    try {
      final response = await http.get(url);
      print(json.decode(response.body));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<OrderItem> loadedOrders = [];
      extractedData.forEach((key, value) {
        loadedOrders.add(
          OrderItem(
            id: key,
            amount: value['amount'],
            dateTime: DateTime.parse(value['dateTime']),
            products: (value['products'] as List<dynamic>)
                .map((e) => CartItem(
                    id: e['id'],
                    price: e['price'],
                    quantity: e['quantity'],
                    title: e['title']))
                .toList(),
          ),
        );
      });
      _order = loadedOrders.reversed.toList();
      notifyListeners();
    } catch (onError) {
      //throw onError;
      print(onError.toString());
    }
  }

  Future<void> addOrder(List<CartItem> cartProducts, double amount) async {
    const url =
        "https://apni-dukaan-405bb-default-rtdb.firebaseio.com/orders.json";

    try {
      final timestamp = DateTime.now();
      final response = await http.post(
        url,
        body: json.encode({
          'amount': amount,
          'dateTime': timestamp.toIso8601String(),
          'products': cartProducts
              .map(
                (e) => {
                  'id': e.id,
                  'title': e.title,
                  'quantity': e.quantity,
                  'price': e.price,
                },
              )
              .toList()
        }),
      );
      _order.insert(
        0,
        OrderItem(
          id: json.decode(response.body)['name'],
          amount: amount,
          products: cartProducts,
          dateTime: timestamp,
        ),
      );
    } catch (e) {
      print(e.toString());
    }

    notifyListeners();
  }
}
