import 'package:flutter/material.dart';
import 'package:rawabi/screen/categoryScreen.dart';
import 'package:rawabi/screen/productsByCategoryScreen.dart';
import '../productDetailsScreen.dart';

GlobalKey<NavigatorState> exploreNavigatorKey = GlobalKey<NavigatorState>();
class CategoryNavigator extends StatefulWidget {
  final VoidCallback onCartSelected;
  const CategoryNavigator({super.key,required this.onCartSelected});

  @override
  State<CategoryNavigator> createState() => _CategoryNavigatorState();
}

class _CategoryNavigatorState extends State<CategoryNavigator> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: exploreNavigatorKey,
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
            settings: settings,
            builder: (BuildContext context) {
              switch (settings.name) {
                case '/':
                  return   CategoryScreen();
                case '/ProductsByCategory':
                  return   ProductsByCategory();
                case '/ProductDetailsScreen':
                  return  ProductDetailsScreen(onCartSelected: widget.onCartSelected);
                /*case '/SearchResultScreen':
                  return  const SearchResultScreen();*/
                /*case '/BarcodeResultScreen':
                  return  const BarcodeResultScreen();*/
              }
              throw (e){
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(e.toString())));
              };

            }
        );
      },
    );
  }
}