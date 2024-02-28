// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:neuroaware/controller/registration.controller.dart';
import 'package:neuroaware/screens/auth/loginpage.dart';
import 'package:neuroaware/widgets/input_fields.dart';

import '../../widgets/submit_button.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  RegistrationController registerationController = RegistrationController();
  bool visible = true;

  @override
  void dispose() {
    registerationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
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
                SizedBox(height: 15),
                Text("Sign Up",
                    style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.w600,
                        color: Color.fromRGBO(40, 65, 98, 1))),
                SizedBox(height: 15),
                Image.asset(
                  'assets/images/lifesavers-bust.png',
                  height: MediaQuery.of(context).size.height * 0.3,
                ),
                SizedBox(height: 20),
                InputTextFieldWidget(
                    registerationController.usernameController, "Username"),
                SizedBox(height: 10),
                InputTextFieldWidget(
                    registerationController.emailController, "Email"),
                SizedBox(height: 10),
                InputTextFieldWidget(
                    registerationController.passwordController, 'Password',
                    passwordField: true),
                SizedBox(height: 10),
                InputTextFieldWidget(
                    registerationController.confirmPasswordController,
                    'Confirm Password',
                    passwordField: true),
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
                SizedBox(height: 10),
                SubmitButton(
                  onPressed: () => handleRegistration(),
                  title: 'Sign Up',
                ),
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
                                  builder: ((context) => Login())));
                        },
                        child: Text(
                          "Login",
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
    );
  }

  //create handelSubmit function to navigate to login page after successful registration
  void handleSubmit() {
    Navigator.push(context, MaterialPageRoute(builder: ((context) => Login())));
  }

  // handleregisration method
  void handleRegistration() async {
    var response = await registerationController.registerUser();
    if (response[0] == 201) {
      handleSubmit();
    }
    if (response[0] == 400) {
      errorDialog(response[1]);
    }
  }

  errorDialog(String message) {
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
                  child: Text('Close'))
            ],
          );
        });
  }
}
