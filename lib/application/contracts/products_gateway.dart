import '../../domain/entity/product_entity.dart';

abstract class ProductsGateway {
  List<Product> getProducts();
}
