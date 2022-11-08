import 'package:ecommerce/application/providers/product_list.dart';
import 'package:ecommerce/presentation/components/layout/app_drawer.dart';
import 'package:ecommerce/presentation/components/layout/product_item.dart';
import 'package:ecommerce/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductsList products = Provider.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Gerenciar Produto'), actions: [
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).pushNamed(AppRoutes.productsForm);
          },
        )
      ]),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: products.itemsCount,
          itemBuilder: (ctx, i) => Column(
            children: [
              ProductItem(products.items[i]),
              const Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
