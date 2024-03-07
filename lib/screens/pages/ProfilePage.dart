// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:neuroaware/utils/API_endpoints.dart';

import '../../components/topBar.dart';
import '../../controller/logout.controller.dart';
import '../../utils/SessionGetter.dart';

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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: TopBar(greetingView: false, title: 'UserName'),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 10, 12, 0),
            child: Center(
              child: Column(
                children: [
                  Column(
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      // FutureBuilder(
                      //   future: getImage(),
                      //   builder:
                      //       (BuildContext context, AsyncSnapshot snapshot) {
                      //     if (snapshot.connectionState ==
                      //         ConnectionState.done) {
                      //       return snapshot.data;
                      //     }
                      //     if (snapshot.connectionState ==
                      //         ConnectionState.waiting) {
                      //       return CircularProgressIndicator();
                      //     }
                      //     return CircularProgressIndicator();
                      //   },
                      // ),
                      ClipOval(
                        child: Image.asset(
                          'assets/images/logo.png',
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'John Doe',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'email',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        '+91 phone no.',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/editProfile');
                    },
                    child: Text(
                      'Edit Profile',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  Divider(
                    color: Colors.black,
                  ),
                  profileOptions(context, 'Logout', Icons.logout, false,
                      Colors.black, true, handleLogout, '')
                ],
              ),
            ),
          ),
          if (loading) logoutLoading(),
        ],
      ),
    );
  }

  Container logoutLoading() {
    return Container(
      alignment: Alignment.center,
      color: Colors.black.withOpacity(0.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: Colors.white,
            strokeCap: StrokeCap.round,
          ),
          Text('Redirecting',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ))
        ],
      ),
    );
  }

  Future<Image> getImage() async {
    var url = '${ApiEndPoints.baseUrl}/user/imageqGet';
    var response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'image/jpeg',
        'Cookies': await SessionId.getSessionId(),
      },
    );
    if (response.statusCode == 200) {
      return Image.memory(response.bodyBytes);
    } else {
      return Image.asset('assets/images/logo.png');
    }
  }

  void handleAction() {
    Navigator.pushNamed(context, '/start');
  }

  // handle registration method
  void handleLogout() async {
    setState(() {
      loading = true;
    });
    var response = await _logoutController.logoutUser();
    setState(() {
      loading = false;
    });
    var message = jsonDecode(response.body);

    if (response.statusCode == 200) {
      SessionId.deleteSessionId();
      handleAction();
    }
    if (response.statusCode == 401) {
      handleAction();
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

  Row profileOptions(
    BuildContext context,
    String title,
    IconData icon,
    bool arrow,
    Color textColor,
    bool action,
    Function? function,
    String page,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            if (action) {
              if (function != null) {
                function();
              }
            } else {
              Navigator.pushNamed(context, page);
            }
          },
          child: Container(
            width: MediaQuery.of(context).size.width * 0.861,
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.35),
                borderRadius: BorderRadius.circular(10)),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black.withOpacity(0.7),
                  ),
                  child: Icon(
                    icon,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(title,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    )),
              ],
            ),
          ),
        ),
        arrow
            ? Container(
                padding: EdgeInsets.all(13),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.3),
                ),
                child: Text(
                  '>',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              )
            : Container(
                padding: EdgeInsets.all(13),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.transparent,
                ),
                child: Text(
                  '',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              )
      ],
    );
  }
}
