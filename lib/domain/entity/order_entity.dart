import 'package:ecommerce/domain/entity/cart_item_entity.dart';

class Order {
  final String id;
  final double total;
  final List<CartItemEntity> products;
  final DateTime date;

  Order({
    required this.id,
    required this.total,
    required this.products,
    required this.date,
  });
}
