
import 'package:flutter/material.dart';
import 'package:rawabi/screen/productsByCategoryScreen.dart';
import '../homeScreen.dart';

class HomeNavigator extends StatefulWidget {
  const HomeNavigator({super.key});

  @override
  State<HomeNavigator> createState() => _HomeNavigatorState();
}

class _HomeNavigatorState extends State<HomeNavigator> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
            settings: settings,
            builder: (BuildContext context) {
              switch (settings.name) {
                case '/':
                  return   const HomeScreen();
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