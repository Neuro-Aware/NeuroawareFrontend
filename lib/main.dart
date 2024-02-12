import 'package:flutter/material.dart';
import 'package:neuroaware/screens/HomePage.dart';
import 'package:neuroaware/screens/userLog/start_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool login = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(fontFamily: 'Raleway'),
        debugShowCheckedModeBanner: false,
        initialRoute: login ? 'homepage' : 'startscrern',
        routes: {
          'startscreen': (context) => StartScreen(),
          'homepage': (context) => MyHome(),
        });
  }
}
