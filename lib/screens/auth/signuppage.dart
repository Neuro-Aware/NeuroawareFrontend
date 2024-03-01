import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:neuroaware/controller/registration.controller.dart';
import 'package:neuroaware/widgets/input_fields.dart';

import '../../widgets/submit_button.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  RegistrationController registrationController = RegistrationController();
  bool loading = false;

  @override
  void dispose() {
    registrationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30, left: 15, right: 15),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: SizedBox(
                      height: 35,
                      width: 114,
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "< Go Back",
                          style: TextStyle(
                            color: Color.fromRGBO(40, 65, 98, 1),
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    "Sign Up",
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.w600,
                      color: Color.fromRGBO(40, 65, 98, 1),
                    ),
                  ),
                  SizedBox(height: 15),
                  Image.asset(
                    'assets/images/lifesavers-bust.png',
                    height: MediaQuery.of(context).size.height * 0.3,
                  ),
                  SizedBox(height: 20),
                  InputTextFieldWidget(
                    registrationController.usernameController,
                    "Username",
                  ),
                  SizedBox(height: 10),
                  InputTextFieldWidget(
                    registrationController.emailController,
                    "Email",
                  ),
                  SizedBox(height: 10),
                  InputTextFieldWidget(
                    registrationController.passwordController,
                    'Password',
                    passwordField: true,
                  ),
                  SizedBox(height: 10),
                  InputTextFieldWidget(
                    registrationController.confirmPasswordController,
                    'Confirm Password',
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
                        fontSize: 15,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  SubmitButton(
                    onPressed: () => handleRegistration(),
                    title: 'Sign Up',
                    loading: loading,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: TextStyle(
                          color: Color.fromRGBO(40, 65, 98, 1),
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/login');
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(
                            color: Color.fromRGBO(40, 65, 98, 1),
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // if (loading)
          //   Container(
          //     color: Colors.black.withOpacity(0.5),
          //     child: Center(
          //       child: CircularProgressIndicator(),
          //     ),
          //   ),
        ],
      ),
    );
  }

  //create handleSubmission function to navigate to login page after successful registration
  void handleSubmission() {
    Navigator.pushNamed(context, '/login');
  }

  // handle registration method
  void handleRegistration() async {
    setState(() {
      loading = true; // show loading indicator
    });
    var response = await registrationController.registerUser();
    setState(() {
      loading = false; // hide loading indicator
    });
    if (response[0] == 201) {
      handleSubmission();
    }
    if (response[0] == 400) {
      // convert response to JSON and show error message
      var error = response[1];
      var errorJson = jsonDecode(error);
      errorDialog(errorJson['message']);
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
