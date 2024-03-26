import 'package:flutter/material.dart';
import 'package:rawabi/screen/productDetailsScreen.dart';
import 'package:rawabi/screen/productsByCategoryScreen.dart';
import '../offresScreen.dart';
import '../search/SearchResultScreen.dart';
import '../search/barcodeResultScreen.dart';

class OfferNavigator extends StatefulWidget {
  const OfferNavigator({super.key});

  @override
  State<OfferNavigator> createState() => _OfferNavigatorState();
}

class _OfferNavigatorState extends State<OfferNavigator> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
            settings: settings,
            builder: (BuildContext context) {
              switch (settings.name) {
                case '/':
                  return  OffersScreen();
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
