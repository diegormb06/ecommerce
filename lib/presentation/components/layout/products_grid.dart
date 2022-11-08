import 'package:ecommerce/presentation/components/layout/product_grid_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../application/providers/product_list.dart';
import '../../../domain/entity/product_entity.dart';

class ProductGrid extends StatelessWidget {
  final bool favoriteOnly;
  const ProductGrid({super.key, required this.favoriteOnly});

  @override
  Widget build(BuildContext context) {
    final List<Product> productList = favoriteOnly
        ? Provider.of<ProductsList>(context).favoriteItems
        : Provider.of<ProductsList>(context).items;

    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: productList.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) => ChangeNotifierProvider.value(
        value: productList[index],
        child: const ProductGridItem(),
      ),
    );
  }
}
