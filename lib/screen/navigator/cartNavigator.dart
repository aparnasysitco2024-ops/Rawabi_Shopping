import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rawabi/screen/cart/cartScreen.dart';
import 'package:rawabi/screen/productDetailsScreen.dart';
import 'package:rawabi/screen/productsByCategoryScreen.dart';

import '../../controller/productsDetailsController.dart';

GlobalKey<NavigatorState> cartNavigatorKey = GlobalKey<NavigatorState>();

class CartNavigator extends StatefulWidget {
  final VoidCallback onCartSelected;
  const CartNavigator({super.key,required this.onCartSelected});

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
                  return ProductsByCategory();
                /*case '/SearchResultScreen':
                  return const SearchResultScreen();*/
                /*case '/BarcodeResultScreen':
                  return const BarcodeResultScreen();*/
                case '/ProductDetailsScreen':
                  if (Get.isRegistered<ProductDetailsController>())
                    Get.delete<ProductDetailsController>();
                  return ProductDetailsScreen(onCartSelected: widget.onCartSelected);
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
