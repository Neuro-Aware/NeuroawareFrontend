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
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   title: Text(
      //     "Login",
      //     style: TextStyle(
      //         fontWeight: FontWeight.w400,
      //         color: Color.fromRGBO(40, 65, 98, 1)),
      //   ),
      // ),
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
                  onPressed: () => registerationController.registerUser(),
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

  //create handelSignUp method
  void handleSignUp() async {
    RegistrationController registrationController = RegistrationController();
    var result = await registrationController.registerUser();
    if (result != null) {
      print("User registered successfully");
    } else {
      print("User registration failed");
    }
  }
}
