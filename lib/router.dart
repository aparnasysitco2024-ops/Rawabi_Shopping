// Comment Out These Imports to run the application

import 'package:flutter/material.dart';
import 'package:rawabi/screen/splashScreen.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(builder: (_) => SplashScreen());

      // Default route, if no route this will show
      default:
        // AS this function need a return type so passing the default type to avoid errors.
        return MaterialPageRoute(builder: (_) => SplashScreen());
    }
  }
}
