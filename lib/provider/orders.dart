import 'package:flutter/foundation.dart';

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

  void addOrder(List<CartItem> cartProducts, double amount) {
    
    _order.insert(
      0,
      OrderItem(
        id: DateTime.now().toString(),
        amount: amount,
        products: cartProducts,
        dateTime: DateTime.now(),
      ),
    );

    notifyListeners();
  }
}
