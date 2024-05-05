import 'package:flutter/material.dart';
import 'package:neuroaware/routes.dart';
import 'package:neuroaware/screens/auth/loginpage.dart';
import 'package:neuroaware/screens/auth/start_page.dart';
import 'package:neuroaware/screens/pages/AnalyticsPage.dart';
import 'package:neuroaware/screens/pages/EditProfilePage.dart';
import 'package:neuroaware/screens/pages/HomePage.dart';
import 'package:neuroaware/screens/pages/MainPage.dart';
import 'package:neuroaware/screens/pages/PDanalysisPage.dart';
import 'package:neuroaware/screens/pages/ProfilePage.dart';

import 'screens/auth/signuppage.dart';
import 'test.dart';

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
      // initialRoute: '/test',
      initialRoute: RouteGenerator.generateRoute(widget.loggedIn),
      // onGenerateRoute: RouteGenerator.generateRoute,
      routes: {
        '/test': (context) => MyTest(),
        '/login': (context) => Login(),
        '/register': (context) => SignUp(),
        '/main': (context) => MainPage(),
        '/start': (context) => StartScreen(),
        '/home': (context) => MyHome(),
        '/PDanalysis': (context) => PDanalysisPage(),
        '/analytics': (context) => AnalyticsPage(),
        '/profile': (context) => ProfilePage(),
        '/editProfile': (context) => EditProfile()
      },
    );
  }
}
