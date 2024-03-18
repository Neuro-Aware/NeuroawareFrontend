// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:neuroaware/controller/getprofileDetails.controller.dart';

import '../../components/shimmerLoading.dart';
import '../../components/topBar.dart';
import '../../controller/logout.controller.dart';
import '../../utils/localStorage.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  LogoutController _logoutController = LogoutController();
  GetProfileDetails _userDetails = GetProfileDetails();
  LocalStorage localStorage = LocalStorage();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: FutureBuilder(
            future: LocalStorage.readAll(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return TopBar(
                  title: snapshot.data['username'],
                  greetingView: false,
                );
              } else {
                return TopBar(
                  loading: true,
                );
              }
            },
          )),
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
                      FutureBuilder(
                          future: getMeImage(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              return ClipOval(
                                child: Image.memory(
                                  snapshot.data,
                                  width:
                                      MediaQuery.of(context).size.height * 0.15,
                                  height:
                                      MediaQuery.of(context).size.height * 0.15,
                                  fit: BoxFit.cover,
                                ),
                              );
                            } else {
                              return ShimmerLoading(
                                shape: BoxShape.circle,
                                width:
                                    MediaQuery.of(context).size.height * 0.15,
                                height:
                                    MediaQuery.of(context).size.height * 0.15,
                              );
                            }
                          }),
                      SizedBox(height: 4),
                      FutureBuilder(
                          future: LocalStorage.readAll(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              return Column(
                                children: [
                                  Text(
                                    snapshot.data['name'],
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    snapshot.data['email'],
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    '+91 ${snapshot.data['phoneNo']}',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              );
                            } else {
                              return Column(
                                children: [
                                  // create a gradient animated shimmer effect for loading
                                  ShimmerLoading(
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                  ),
                                  SizedBox(height: 4),
                                  ShimmerLoading(
                                    width:
                                        MediaQuery.of(context).size.width * 0.6,
                                  ),
                                  SizedBox(height: 4),
                                  ShimmerLoading(
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                  ),
                                ],
                              );
                            }
                          }),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/editProfile');
                    },
                    // ignore: sort_child_properties_last
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
          Text(
            'Logging out...',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          )
        ],
      ),
    );
  }

  Future<dynamic> getMeImage() async {
    var response = await _userDetails.getProfileImage();

    var data = response.bodyBytes;
    return data;
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

    if (response.statusCode == 200) {
      LocalStorage.clear();
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
