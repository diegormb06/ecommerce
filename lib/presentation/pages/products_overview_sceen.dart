import 'package:ecommerce/domain/entity/cart_entity.dart';
import 'package:ecommerce/domain/entity/product_entity.dart';
import 'package:ecommerce/presentation/components/data_display/badge.dart';
import 'package:ecommerce/presentation/components/layout/app_drawer.dart';
import 'package:ecommerce/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/layout/products_grid.dart';

enum Options { favorite, all }

class ProductsOverviewScreen extends StatefulWidget {
  const ProductsOverviewScreen({super.key});

  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  List<Product> productList = [];
  bool favorites = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        centerTitle: true,
        title: const Text('MyShop'),
        actions: [
          PopupMenuButton(
            itemBuilder: (_) => [
              const PopupMenuItem(
                value: Options.favorite,
                child: Text("Somente Favoritos"),
              ),
              const PopupMenuItem(
                value: Options.all,
                child: Text("Todos"),
              ),
            ],
            onSelected: (value) {
              setState(() {
                favorites = (value == Options.favorite);
              });
            },
          ),
          Consumer<Cart>(
            child: IconButton(
              onPressed: () =>
                  Navigator.of(context).pushNamed(AppRoutes.cartScreen),
              icon: const Icon(Icons.shopping_cart),
            ),
            builder: (context, cart, child) => Badge(
              value: cart.countItem.toString(),
              child: child!,
            ),
          ),
        ],
      ),
      body: ProductGrid(
        favoriteOnly: favorites,
      ),
    );
  }
}
