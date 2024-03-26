import 'package:flutter/material.dart';
import 'package:rawabi/screen/accountScreen.dart';
import 'package:rawabi/screen/productDetailsScreen.dart';
import 'package:rawabi/screen/productsByCategoryScreen.dart';
import '../homeScreen.dart';
import '../offresScreen.dart';
import '../search/SearchResultScreen.dart';
import '../search/barcodeResultScreen.dart';
import '../wishlistScreen.dart';

class AccountNavigator extends StatefulWidget {
  const AccountNavigator({super.key});

  @override
  State<AccountNavigator> createState() => _AccountNavigatorState();
}

class _AccountNavigatorState extends State<AccountNavigator> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
            settings: settings,
            builder: (BuildContext context) {
              switch (settings.name) {
                case '/':
                  return  const AccountScreen();
                case '/WishlistScreen':
                  return  WishlistScreen();
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
