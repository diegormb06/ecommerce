import 'package:ecommerce/domain/entity/cart_entity.dart';
import 'package:ecommerce/domain/entity/cart_item_entity.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartItem extends StatelessWidget {
  final CartItemEntity cartItem;

  const CartItem(this.cartItem, {super.key});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      confirmDismiss: (_) {
        return showDialog(
          context: context,
          builder: ((context) => AlertDialog(
                title: const Text('Tem certeza?'),
                content: const Text('Quer remover o item do carrinho?'),
                actions: [
                  TextButton(
                    child: const Text('NÃO'),
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                  ),
                  TextButton(
                    child: const Text('SIM'),
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                  ),
                ],
              )),
        );
      },
      onDismissed: (direction) {
        Provider.of<Cart>(
          context,
          listen: false,
        ).removeItem(cartItem.productId);
      },
      key: ValueKey(cartItem.id),
      direction: DismissDirection.startToEnd,
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 20),
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
      ),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: CircleAvatar(
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: FittedBox(child: Text('${cartItem.price}')),
              ),
            ),
            title: Text(cartItem.name),
            subtitle: Text("total ${cartItem.price * cartItem.quantity}"),
            trailing: Text('${cartItem.quantity}x'),
          ),
        ),
      ),
    );
  }
}
