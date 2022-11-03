import 'dart:io';

import 'package:ecommerce/application/providers/product_list.dart';
import 'package:ecommerce/domain/entity/cart_entity.dart';
import 'package:ecommerce/domain/entity/order_entity.dart';
import 'package:ecommerce/domain/entity/order_list.dart';
import 'package:ecommerce/presentation/pages/cart_screen.dart';
import 'package:ecommerce/presentation/pages/orders_screen.dart';
import 'package:ecommerce/presentation/pages/product_detail_screen.dart';
import 'package:ecommerce/presentation/pages/products_overview_sceen.dart';
import 'package:ecommerce/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductsList()),
        ChangeNotifierProvider(create: (_) => Cart()),
        ChangeNotifierProvider(create: (_) => OrderList()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          fontFamily: 'Lato',
          primarySwatch: Colors.purple,
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: Colors.purple,
            secondary: Colors.deepOrange,
          ),
        ),
        routes: {
          AppRoutes.homeScreen: (ctx) => const ProductsOverviewScreen(),
          AppRoutes.productDetailScreen: (ctx) => const ProductDetailScreen(),
          AppRoutes.cartScreen: (ctx) => const CartScreen(),
          AppRoutes.orderScreen: (ctx) => const OrdersScreen(),
        },
      ),
    );
  }
}
