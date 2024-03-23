
import 'package:flutter/material.dart';
import 'package:rawabi/screen/categoryScreen.dart';
import 'package:rawabi/screen/productsByCategoryScreen.dart';

class CategoryNavigator extends StatefulWidget {
  const CategoryNavigator({super.key});

  @override
  State<CategoryNavigator> createState() => _CategoryNavigatorState();
}

class _CategoryNavigatorState extends State<CategoryNavigator> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
            settings: settings,
            builder: (BuildContext context) {
              switch (settings.name) {
                case '/':
                  return   CategoryScreen();
                case '/ProductsByCategory':
                  return  ProductsByCategory();
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