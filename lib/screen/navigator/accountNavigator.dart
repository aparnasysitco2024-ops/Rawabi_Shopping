import 'package:flutter/material.dart';
import 'package:rawabi/screen/account/accountScreen.dart';
import 'package:rawabi/screen/productDetailsScreen.dart';
import '../wishlistScreen.dart';

GlobalKey<NavigatorState> accountNavigatorKey = GlobalKey<NavigatorState>();

class AccountNavigator extends StatefulWidget {
  final GlobalKey globalKey;
   AccountNavigator( {super.key,required this.globalKey});

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
                  return AccountScreen(globalKey: widget.globalKey,);
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
