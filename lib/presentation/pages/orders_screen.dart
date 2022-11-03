import 'package:ecommerce/domain/entity/order_list.dart';
import 'package:ecommerce/presentation/components/layout/app_drawer.dart';
import 'package:ecommerce/presentation/components/layout/order_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final OrderList orders = Provider.of(context);
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(title: const Text('Meus Pedidos')),
      body: ListView.builder(
        itemCount: orders.itemsCount,
        itemBuilder: (context, index) => OrderItem(orders.items[index]),
      ),
    );
  }
}
