import 'package:flutter/material.dart';
import 'package:neuroaware/screens/pages/MainPage.dart';
import 'package:neuroaware/screens/auth/start_page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final login = settings.arguments;
    switch (settings.name) {
      case '/':
        {
          if (login == null) {
            return MaterialPageRoute(builder: (_) => StartScreen());
          } else {
            return MaterialPageRoute(builder: (_) => const MainPage());
          }
        }

      default:
        return _errorRoute();
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
