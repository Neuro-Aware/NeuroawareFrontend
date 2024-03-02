import 'dart:convert';

import 'package:flutter/material.dart';

import '../../controller/logout.controller.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  LogoutController _logoutController = LogoutController();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Stack(
        children: [
          Center(
            child: GestureDetector(
              onTap: () => handleLogout(loading),
              child: Text(
                'Logout',
                style: TextStyle(fontSize: 24),
              ),
            ),
          ),
          if (loading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [CircularProgressIndicator(), Text('Redirecting')],
              ),
            ),
        ],
      ),
    );
  }

  void handleAction() {
    Navigator.pushNamed(context, '/start');
  }

  // handle registration method
  void handleLogout(bool loading) async {
    setState(() {
      loading = true;
    });
    var response = await _logoutController.logoutUser();

    setState(() {
      loading = false;
    });

    var message = jsonDecode(response.body);

    if (response.statusCode == 200) {
      handleAction();
    }
    if (response.statusCode == 401) {
      errorDialog(
        message['message'],
      );
    }
    if (response.statusCode == 500) {
      errorDialog(
        'Internal Server Error',
      );
    }
  }

  void errorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
