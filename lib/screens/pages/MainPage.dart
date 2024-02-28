import 'package:flutter/material.dart';
import 'package:neuroaware/components/bottomNav.dart';
import 'package:neuroaware/screens/pages/AnalyticsPage.dart';
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
    AnalyticsPage(),
    ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: BottomNav(
        selectedIndex: _selectedIndex,
        onTap: (value) => setState(() => _selectedIndex = value),
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
    );
  }
}
