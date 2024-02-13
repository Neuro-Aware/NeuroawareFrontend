import 'package:flutter/material.dart';
import 'package:neuroaware/screens/pages/MainPage.dart';
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
  bool login = true;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(fontFamily: 'Raleway'),
        debugShowCheckedModeBanner: false,
        home: login ? MainPage() : StartScreen());
  }
}
