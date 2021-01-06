import 'package:flutter/cupertino.dart';

import './product.dart';

class ProductsProvider with ChangeNotifier {
  List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://i.pinimg.com/originals/1a/ee/1f/1aee1f0203ec862aa5e4d06c8cd6ec61.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://cdn.shopify.com/s/files/1/2446/6407/products/egg_pan_1.jpg?v=1583735806   ',
    ),
  ];

  var _showFavouritesOnly = false;

  List<Product> get items {
    if (_showFavouritesOnly) {
      return _items.where((element) => element.isFavourite).toList();
    }
    return [..._items];
  }

  List<Product> get favouriteItems {
    return _items.where((element) => element.isFavourite).toList();
  }

  // void showFavouritesOnly(){
  //   _showFavouritesOnly = true;
  //   notifyListeners();
  // }

  // void showAll(){
  //   _showFavouritesOnly = false;
  //    notifyListeners();
  // }

  Product findById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  void addProducts(Product product) {
    var _newProduct = Product(
      description: product.description,
      title: product.title,
      price: product.price,
      imageUrl: product.imageUrl,
      id: DateTime.now().toString(),
    );
    _items.add(_newProduct);
    notifyListeners();
  }

  void updateProduct(String id, Product product)
  {
    final _prodIndex  = _items.indexWhere((element) => element.id == id);
    _items[_prodIndex] = product;
    notifyListeners();
  }

  void removeProduct(String id)
  {
    _items.removeWhere((element) => element.id == id);
    notifyListeners();

  }
}
