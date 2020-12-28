import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItem({
    @required this.id,
    @required this.title,
    @required this.quantity,
    @required this.price,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  double get totalAmount {
    double total = 0.0;
    _items.forEach((key, value) {
      total += value.price * value.quantity;
    });

    return total;
  }

  int get itemCount {
    int counter = 0;
    if (_items != null) {
      for (CartItem c in _items.values) {
        counter = counter + c.quantity;
      }
      return counter;
    }

    return 0;

    //return _items.length;
  }

  void addItem(String productId, String title, double price) {
    if (_items.containsKey(productId)) {
      _items.update(
          productId,
          (value) => CartItem(
                id: value.id,
                title: value.title,
                quantity: value.quantity + 1,
                price: value.price,
              ));
    } else {
      _items.putIfAbsent(
          productId,
          () => CartItem(
                id: DateTime.now().toString(),
                title: title,
                quantity: 1,
                price: price,
              ));
    }

    notifyListeners();
  }

  void deleteItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (_items.containsKey(productId)) {
      if (_items[productId].quantity > 1) {
        _items.update(
            productId,
            (value) => CartItem(
                  id: value.id,
                  title: value.title,
                  quantity: value.quantity - 1,
                  price: value.price,
                ));
      }else{
        _items.remove(productId);
      }
    }
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
