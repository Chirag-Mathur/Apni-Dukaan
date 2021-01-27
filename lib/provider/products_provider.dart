import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'package:shop_app/models/http_exception.dart';

import './product.dart';

class ProductsProvider with ChangeNotifier {
  List<Product> _items = [
    // Product(
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   imageUrl:
    //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 59.99,
    //   imageUrl:
    //       'https://i.pinimg.com/originals/1a/ee/1f/1aee1f0203ec862aa5e4d06c8cd6ec61.jpg',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Yellow Scarf',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 19.99,
    //   imageUrl:
    //       'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'A Pan',
    //   description: 'Prepare any meal you want.',
    //   price: 49.99,
    //   imageUrl:
    //       'https://cdn.shopify.com/s/files/1/2446/6407/products/egg_pan_1.jpg?v=1583735806   ',
    // ),
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

  Future<void> fetchAndSyncProducts() async {
    const url =
        "https://apni-dukaan-405bb-default-rtdb.firebaseio.com/products.json";

    try {
      final response = await http.get(url);
      print(json.decode(response.body));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Product> loadedProducts = [];
      extractedData.forEach((key, value) {
        loadedProducts.add(Product(
          id: key,
          title: value['title'],
          description: value['description'],
          price: value['price'],
          imageUrl: value['imageurl'],
          isFavourite: value['isFavourite'],
        ));
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (onError) {
      //throw onError;
      print(onError.toString());
    }
  }

  Future<void> addProducts(Product product) async {
    const url =
        "https://apni-dukaan-405bb-default-rtdb.firebaseio.com/products.json";

    try {
      final response = await http.post(
        url,
        body: json.encode({
          'title': product.title,
          'price': product.price,
          'description': product.description,
          'imageurl': product.imageUrl,
          'isFavourite': product.isFavourite,
        }),
      );

      print(json.decode(response.body)['name']);
      var _newProduct = Product(
        description: product.description,
        title: product.title,
        price: product.price,
        imageUrl: product.imageUrl,
        id: json.decode(response.body)['name'],
      );
      _items.add(_newProduct);
      notifyListeners();
    } catch (onError) {
      print(onError.toString());
      throw onError;
    }
  }

  Future<void> updateProduct(String id, Product product) async {
    final _prodIndex = _items.indexWhere((element) => element.id == id);
    final url =
        "https://apni-dukaan-405bb-default-rtdb.firebaseio.com/products/$id.json";
    http.patch(
      url,
      body: json.encode({
        'title': product.title,
        'price': product.price,
        'description': product.description,
        'imageurl': product.imageUrl,
        //'isFavourite': product.isFavourite,
      }),
    );
    _items[_prodIndex] = product;
    notifyListeners();
  }

  Future<void> removeProduct(String id) async {
    final url =
        "https://apni-dukaan-405bb-default-rtdb.firebaseio.com/products/$id.json";
    final removeProductId = _items.indexWhere((element) => element.id == id);
    var productRemove = _items[removeProductId];
    print(removeProductId);
    _items.removeAt(removeProductId);
    notifyListeners();
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _items.insert(removeProductId, productRemove);
      notifyListeners();
      throw HttpException('Http Exception');
    }
    productRemove = null;
  }
}
