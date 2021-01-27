import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavourite;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavourite = false,
  });

  void toggleFavouriteButton() async {
    final url =
        "https://apni-dukaan-405bb-default-rtdb.firebaseio.com/products/$id.json";
    isFavourite = !isFavourite;
    notifyListeners();
    try {
      final response = await http.patch(
        url,
        body: json.encode({
          'isFavourite': isFavourite,
        }),
      );
      if (response.statusCode >= 400) {
        isFavourite = !isFavourite;
        notifyListeners();
      }
    } catch (e) {
      isFavourite = !isFavourite;
      notifyListeners();
    }
  }
}
