import 'package:flutter/material.dart';
import 'package:neuroaware/screens/pages/MainPage.dart';
import 'package:neuroaware/screens/auth/start_page.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  bool login = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Raleway',
        scaffoldBackgroundColor: Color.fromARGB(255, 237, 237, 237),
      ),
      debugShowCheckedModeBanner: false,
      home: login ? MainPage() : StartScreen(),
      // initialRoute: '/',
      // onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
