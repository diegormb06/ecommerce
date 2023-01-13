import 'package:ecommerce/domain/entity/product_entity.dart';
import 'package:ecommerce/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../application/providers/product_list.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  const ProductItem(this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(product.imageUrl),
      ),
      title: Text(product.title),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                Navigator.of(context).pushNamed(
                  AppRoutes.productsForm,
                  arguments: product,
                );
              },
              color: Theme.of(context).primaryColor,
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("Excluir produto"),
                    content: const Text("Tem certeza?"),
                    actions: [
                      TextButton(
                        child: const Text("Não"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: const Text("Sim"),
                        onPressed: () {
                          Provider.of<ProductsList>(
                            context,
                            listen: false,
                          ).removeProduct(product);
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                );
              },
              color: Theme.of(context).errorColor,
            ),
          ],
        ),
      ),
    );
  }
}
