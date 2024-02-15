import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

class BottomNav extends StatefulWidget {
  BottomNav({
    Key? key,
    required this.selectedIndex,
    required this.onTap,
  }) : super(key: key);

  int selectedIndex;
  final ValueChanged<int> onTap;

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 8),
            child: GNav(
              gap: 2.9,
              activeColor: Colors.black,
              iconSize: 22,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: Duration(milliseconds: 400),
              tabBackgroundColor: Color.fromARGB(255, 90, 224, 95),
              color: Colors.white,
              tabs: [
                GButton(
                  icon: LineIcons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: LineIcons.heartbeat,
                  text: 'Diagnosis',
                ),
                GButton(
                  icon: LineIcons.fire,
                  text: 'Analytics',
                ),
                GButton(
                  icon: LineIcons.user,
                  text: 'Profile',
                ),
              ],
              selectedIndex: widget.selectedIndex,
              onTabChange: (index) {
                widget.onTap(index);
              },
            ),
          ),
        ),
      ),
    );
  }
}
