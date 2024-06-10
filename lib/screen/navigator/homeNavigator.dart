import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rawabi/screen/productDetailsScreen.dart';
import 'package:rawabi/screen/productsByCategoryScreen.dart';
import '../../controller/productsDetailsController.dart';
import '../home/categoryFromHomeScreen.dart';
import '../home/homeScreen.dart';
import '../home/productsFromHomeScreen.dart';

GlobalKey<NavigatorState> homeNavigatorKey = GlobalKey<NavigatorState>();

class HomeNavigator extends StatefulWidget {
  final VoidCallback onCartSelected;
  const HomeNavigator({super.key,required this.onCartSelected});

  @override
  State<HomeNavigator> createState() => _HomeNavigatorState();
}

class _HomeNavigatorState extends State<HomeNavigator> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: homeNavigatorKey,
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
            settings: settings,
            builder: (BuildContext context) {
              switch (settings.name) {
                case '/':
                  return const HomeScreen();
                case '/ProductsByCategory':
                  return  ProductsByCategory();
                /*case '/SearchResultScreen':
                  return const SearchResultScreen();*/
                /*case '/BarcodeResultScreen':
                  return const BarcodeResultScreen();*/
                case '/ProductDetailsScreen':
                  if (Get.isRegistered<ProductDetailsController>())
                    Get.delete<ProductDetailsController>();
                  return ProductDetailsScreen(onCartSelected: widget.onCartSelected);
                case '/ProductsFromHomeScreen':
                  return ProductsFromHomeScreen();
                case '/CategoryFromHomeScreen':
                  return CategoryFromHomeScreen();
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
