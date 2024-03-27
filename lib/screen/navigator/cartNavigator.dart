import 'package:flutter/material.dart';
import 'package:rawabi/screen/cartScreen.dart';
import 'package:rawabi/screen/productDetailsScreen.dart';
import 'package:rawabi/screen/productsByCategoryScreen.dart';

import '../search/SearchResultScreen.dart';
import '../search/barcodeResultScreen.dart';

GlobalKey<NavigatorState> cartNavigatorKey = GlobalKey<NavigatorState>();

class CartNavigator extends StatefulWidget {
  const CartNavigator({super.key});

  @override
  State<CartNavigator> createState() => _CartNavigatorState();
}

class _CartNavigatorState extends State<CartNavigator> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: cartNavigatorKey,
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
            settings: settings,
            builder: (BuildContext context) {
              switch (settings.name) {
                case '/':
                  return CartScreen();
                case '/ProductsByCategory':
                  return const ProductsByCategory();
                case '/SearchResultScreen':
                  return const SearchResultScreen();
                case '/BarcodeResultScreen':
                  return const BarcodeResultScreen();
                case '/ProductDetailsScreen':
                  return ProductDetailsScreen();
              }
              throw (e) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(e.toString())));
              };
            });
      },
    );
  }
}
