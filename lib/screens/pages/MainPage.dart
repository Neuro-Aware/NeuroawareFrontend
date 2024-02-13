import 'package:flutter/material.dart';
import 'package:neuroaware/screens/components/bottom_nav.dart';
import 'package:neuroaware/screens/pages/ExercisePage.dart';
import 'package:neuroaware/screens/pages/HomePage.dart';
import 'package:neuroaware/screens/pages/PDanalysisPage.dart';
import 'package:neuroaware/screens/pages/ProfilePage.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    MyHome(),
    PDanalysisPage(),
    ExercisePage(),
    ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNav(
        selectedIndex: _selectedIndex,
        onTap: (value) => setState(() => _selectedIndex = value),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
    );
  }
}
