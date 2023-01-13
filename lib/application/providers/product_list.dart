import 'dart:math';

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

  void saveProduct(Map<String, Object> data) {
    bool hasId = data["id"] != null;

    final product = Product(
      id: hasId ? data["id"] as String : Random().nextDouble().toString(),
      title: data['title'] as String,
      description: data['description'] as String,
      price: data['price'] as double,
      imageUrl: data['imageUrl'] as String,
    );

    if (hasId) {
      updateProduct(product);
    } else {
      addProduct(product);
    }
  }

  void addProduct(Product product) {
    _items.add(product);
    notifyListeners();
  }

  void updateProduct(Product product) {
    final index = _items.indexWhere((element) => element.id == product.id);

    if (index >= 0) {
      _items[index] = product;
      notifyListeners();
    }
  }

  void removeProduct(Product product) {
    final index = _items.indexWhere((element) => element.id == product.id);

    if (index >= 0) {
      _items.removeWhere((element) => element.id == product.id);
      notifyListeners();
    }
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
