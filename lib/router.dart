// Comment Out These Imports to run the application

import 'package:flutter/material.dart';
import 'package:rawabi/screen/splashScreen.dart';

class Router {

  static Route<dynamic> generateRoute(RouteSettings settings) {

    switch (settings.name) {

      case "/":
        return MaterialPageRoute(
          builder: (_) => SplashScreen(),
        );

      default:

        try {

          if (settings.name != null) {

            Uri uri = Uri.parse(settings.name!);

            print("Deep Link URI => ${uri.pathSegments}");
            if (uri.pathSegments.isNotEmpty &&
                uri.pathSegments[0] == "group") {

              String groupId = uri.pathSegments.last;

              print("Group ID => $groupId");

              return MaterialPageRoute(
                builder: (_) => SplashScreen(
                  groupId: groupId,
                ),
              );
            }

            else if (uri.pathSegments.isNotEmpty &&
                uri.pathSegments[0] == "flayer") {

              return MaterialPageRoute(
                builder: (_) => SplashScreen(
                  flyer: true,
                ),
              );
            }

            else if (uri.pathSegments.isNotEmpty) {

              String productId = uri.pathSegments.last;

              print("Product ID => $productId");

              return MaterialPageRoute(
                builder: (_) => SplashScreen(
                  productId: productId,
                ),
              );
            }
          }
        } catch (e) {
          print("Deep Link Error => $e");
        }

        return MaterialPageRoute(
          builder: (_) => SplashScreen(),
        );
    }
  }
}