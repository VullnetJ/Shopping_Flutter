import 'package:chat/providers/orders.dart';
import 'package:chat/screens/cart_screen.dart';
import 'package:chat/screens/product_detail_screen.dart';
import 'package:flutter/material.dart';
import './screens/products_overview.dart';
import './screens/product_detail_screen.dart';
import './providers/products.dart';
import 'package:provider/provider.dart';
import './screens/cart_screen.dart';
import '/providers/cart.dart';
import './screens/orders_screen.dart';
import './screens/user_products_screen.dart';
import './screens/edit_product_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Products(),
        ),
        ChangeNotifierProvider(
          // value: Cart(),
         create: (ctx) => Cart(),
        ),
        ChangeNotifierProvider.value(
          value: Orders(),        
        ),
       
      ],
      // create: (ctx) => Products(),
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.dark(),
          ),
          home: ProdcutsOverviewScreen(),
          routes: {
            ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
            CartScreen.routeName: (ctx) => CartScreen(),
            OrdersScreen.routeName: (ctx) => const OrdersScreen(),
            UserProductsScreen.routeName: (ctx) => const UserProductsScreen(),
            EditProductScreen.routeName: (ctx) =>  EditProductScreen(),
          }),
    );
  }
}
