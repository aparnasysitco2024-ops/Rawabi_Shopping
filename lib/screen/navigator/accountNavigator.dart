import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rawabi/screen/account/accountScreen.dart';
import 'package:rawabi/screen/productDetailsScreen.dart';
import '../../controller/productsDetailsController.dart';
import '../wishlistScreen.dart';

GlobalKey<NavigatorState> accountNavigatorKey = GlobalKey<NavigatorState>();

class AccountNavigator extends StatefulWidget {
  final GlobalKey globalKey;
  final VoidCallback onOffersSelected;
  final VoidCallback onCartSelected;

  AccountNavigator(
      {super.key,
      required this.globalKey,
      required this.onOffersSelected,
      required this.onCartSelected});

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
                  return AccountScreen(
                    globalKey: widget.globalKey,
                    onOffersSelected: widget.onOffersSelected,
                    onCartSelected: widget.onCartSelected,
                  );
                case '/WishlistScreen':
                  return WishlistScreen();
                case '/ProductDetailsScreen':
                  if (Get.isRegistered<ProductDetailsController>())
                    Get.delete<ProductDetailsController>();
                  return ProductDetailsScreen(
                      onCartSelected: widget.onCartSelected);
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
