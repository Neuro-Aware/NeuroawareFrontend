// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:neuroaware/screens/userLog/signuppage.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
                TextField(
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 20),
                      hintText: "Email",
                      hintStyle:
                          TextStyle(color: Color.fromRGBO(40, 65, 98, 1)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: Color.fromRGBO(40, 65, 98, 1), width: 2))),
                ),
                SizedBox(height: 20),
                TextField(
                  obscureText: visible,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 20),
                    hintText: "Password",
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          visible = !visible;
                        });
                      },
                      icon: Icon(
                          visible ? Icons.visibility : Icons.visibility_off),
                    ),
                    hintStyle: TextStyle(color: Color.fromRGBO(40, 65, 98, 1)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Color.fromRGBO(40, 65, 98, 1),
                        width: 2,
                      ),
                    ),
                  ),
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
                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          backgroundColor: Color.fromRGBO(40, 65, 98, 1)),
                      child: Text(
                        "Login",
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      )),
                ),
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
    );
  }
}
