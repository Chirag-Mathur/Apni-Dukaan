import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shop_app/provider/orders.dart';
import 'package:shop_app/screens/cart_screens.dart';

import './provider/products_provider.dart';
import './screens/product_details_page.dart';
import './screens/products_overview_screens.dart';
import 'provider/cart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx)=> ProductsProvider(),
          //value: ProductsProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
          //value: Cart(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Orders(),
        ),
      ],
      child: MaterialApp(
        title: "Shop App",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.lightGreen,
          accentColor: Colors.purple,
        ),
        home: ProductsOverviewScreen(),
        routes: {
          ProductDetailsScreen.routeName: (ctx) => ProductDetailsScreen(),
          CartScreen.routeName: (ctx) => CartScreen(),
        },
      ),
    );
  }
}
