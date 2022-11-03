class CartItemEntity {
  String id;
  String productId;
  String name;
  int quantity;
  double price;

  CartItemEntity({
    required this.id,
    required this.productId,
    required this.name,
    required this.quantity,
    required this.price,
  });
}
