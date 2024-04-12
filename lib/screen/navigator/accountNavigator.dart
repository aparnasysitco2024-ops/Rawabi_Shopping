import 'package:flutter/material.dart';
import 'package:rawabi/screen/account/accountScreen.dart';
import 'package:rawabi/screen/productDetailsScreen.dart';
import '../wishlistScreen.dart';

GlobalKey<NavigatorState> accountNavigatorKey = GlobalKey<NavigatorState>();

class AccountNavigator extends StatefulWidget {
   AccountNavigator( {super.key});

  @override
  State<AccountNavigator> createState() => _AccountNavigatorState();
}

class _AccountNavigatorState extends State<AccountNavigator> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: accountNavigatorKey,
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
            settings: settings,
            builder: (BuildContext context) {
              switch (settings.name) {
                case '/':
                  return AccountScreen();
                case '/WishlistScreen':
                  return WishlistScreen();
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
