import 'package:ecommerce/domain/entity/product_entity.dart';
import 'package:flutter/cupertino.dart';

import '../../data/products_mock.dart';

class ProductsList with ChangeNotifier {
  final List<Product> _items = productsMock;

  List<Product> get items => [..._items];

  List<Product> get favoriteItems =>
      _items.where((product) => product.isFavorite).toList();

  int get itemsCount {
    return _items.length;
  }

  void addProduct(Product product) {
    _items.add(product);
    notifyListeners();
  }
}


// bool favoriteOnly = false;

// List<Product> get items {
//   if (favoriteOnly) {
//     return _items.where((prod) => prod.isFavorite).toList();
//   }

//   return [..._items];
// }

// void showFavoritesOnly(bool showFavoritesOnly) {
//   favoriteOnly = showFavoritesOnly;
//   notifyListeners();
// }
