import 'package:flutter/material.dart';
import 'package:neuroaware/controller/logout.controller.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  LogoutController _logoutController = LogoutController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Center(
        child: GestureDetector(
          onTap: () => _logoutController.logoutUser(),
          child: Text(
            'Logout',
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}
