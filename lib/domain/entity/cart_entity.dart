import 'dart:math';

import 'package:ecommerce/domain/entity/cart_item_entity.dart';
import 'package:ecommerce/domain/entity/product_entity.dart';
import 'package:flutter/cupertino.dart';

class Cart with ChangeNotifier {
  Map<String, CartItemEntity> _items = {};

  Map<String, CartItemEntity> get items {
    return {..._items};
  }

  int get countItem {
    return _items.length;
  }

  double get totalAmount {
    double total = 0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });

    return total;
  }

  void addItem(Product product) {
    if (_items.containsKey(product.id)) {
      _items.update(
        product.id,
        (previous) => CartItemEntity(
            id: previous.id,
            productId: previous.productId,
            name: previous.name,
            quantity: previous.quantity++,
            price: previous.price),
      );
    } else {
      _items.putIfAbsent(
        product.id,
        () => CartItemEntity(
            id: Random().nextDouble().toString(),
            productId: product.id,
            name: product.title,
            quantity: 1,
            price: product.price),
      );
    }

    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
