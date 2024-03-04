import 'package:flutter/material.dart';
import 'package:neuroaware/screens/auth/loginpage.dart';
import 'package:neuroaware/screens/auth/start_page.dart';
import 'package:neuroaware/screens/pages/MainPage.dart';

import 'routes.dart';
import 'screens/auth/signuppage.dart';

class App extends StatefulWidget {
  const App({
    super.key,
    required this.loggedIn,
  });

  final bool loggedIn;

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  // bool login = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Raleway',
        scaffoldBackgroundColor: Color.fromARGB(255, 237, 237, 237),
      ),
      debugShowCheckedModeBanner: false,
      // home: login ? MainPage() : StartScreen(),
      initialRoute: RouteGenerator.generateRoute(widget.loggedIn),
      // onGenerateRoute: RouteGenerator.generateRoute,
      routes: {
        '/login': (context) => Login(),
        '/register': (context) => SignUp(),
        '/main': (context) => MainPage(),
        '/start': (context) => StartScreen(),
      },
    );
  }
}
