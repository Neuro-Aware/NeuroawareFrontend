import 'package:flutter/material.dart';

class RouteGenerator {
  static String generateRoute(bool loggedIn) {
    // print("generating route");

    if (loggedIn) {
      // print("going to main");
      return '/main';
    } else {
      return '/start';
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (context) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            'Page not found',
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: Colors.white,
                ),
          ),
        ),
        body: Center(
          child: Text(
            'Page does not exist',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Colors.white,
                ),
          ),
        ),
      );
    });
  }
}
