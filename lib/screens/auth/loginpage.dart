// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:neuroaware/controller/login.controller.dart';
import 'package:neuroaware/screens/auth/signuppage.dart';
import 'package:neuroaware/screens/pages/MainPage.dart';
import 'package:neuroaware/utils/SessionId.dart';
import 'package:neuroaware/widgets/input_fields.dart';
import 'package:neuroaware/widgets/submit_button.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  LoginController loginController = LoginController();
  bool visible = true;
  bool loading = false;

  @override
  void dispose() {
    loginController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Padding(
          padding: const EdgeInsets.only(top: 30, left: 15, right: 15),
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: SizedBox(
                      height: 35,
                      width: 114,
                      child: OutlinedButton(
                          style: OutlinedButton.styleFrom(),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "< Go Back",
                            style: TextStyle(
                                color: Color.fromRGBO(40, 65, 98, 1),
                                fontWeight: FontWeight.w500,
                                fontSize: 14),
                          )),
                    ),
                  ),
                  SizedBox(height: 18),
                  Text(
                    "Welcome Back",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(40, 65, 98, 1)),
                  ),
                  Text("Login",
                      style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.w600,
                          color: Color.fromRGBO(40, 65, 98, 1))),
                  SizedBox(height: 20),
                  Image.asset(
                    'assets/images/lifesavers-bust.png',
                    scale: 2,
                  ),
                  SizedBox(height: 20),
                  InputTextFieldWidget(
                    loginController.emailController,
                    "Email",
                  ),
                  SizedBox(height: 20),
                  InputTextFieldWidget(
                    loginController.passwordController,
                    'Password',
                    passwordField: true,
                  ),
                  SizedBox(height: 5),
                  Align(
                    alignment: AlignmentDirectional.bottomEnd,
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(
                          color: Color.fromRGBO(40, 65, 98, 1),
                          fontWeight: FontWeight.w500,
                          fontSize: 15),
                    ),
                  ),
                  SizedBox(height: 15),
                  SubmitButton(onPressed: () => handleLogin(), title: 'Login'),
                  SizedBox(height: 0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: TextStyle(
                            color: Color.fromRGBO(40, 65, 98, 1),
                            fontWeight: FontWeight.w500,
                            fontSize: 15),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUp()));
                          },
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                                color: Color.fromRGBO(40, 65, 98, 1),
                                fontWeight: FontWeight.w500,
                                fontSize: 15),
                          ))
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        if (loading)
          Container(
            color: Colors.black.withOpacity(0.5),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
      ]),
    );
  }

  void handleSubmission() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: ((context) => MainPage()),
      ),
    );
  }

  // handle registration method
  void handleLogin() async {
    setState(() {
      loading = true; // show loading indicator
    });
    var response = await loginController.loginUser();
    setState(() {
      loading = false; // hide loading indicator
    });
    var message = jsonDecode(response.body);

    if (response.statusCode == 200) {
      SessionId.setSessionId(response.headers['set-cookie']!);
      print(response.headers['set-cookie']);
      print(await SessionId.getSessionId());
      handleSubmission();
    }
    if (response.statusCode == 400 ||
        response.statusCode == 401 ||
        response.statusCode == 404) {
      errorDialog(message['message']);
    }
    if (response.statusCode == 500) {
      errorDialog('Internal Server Error');
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
