// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 80),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Text(
                  "Welcome to",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                      color: Color.fromRGBO(40, 65, 98, 1)),
                ),
                Text("NeuroAware!",
                    style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.w600,
                        color: Color.fromRGBO(40, 65, 98, 1))),
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                Image.asset(
                  'assets/images/logo.png',
                  scale: 1.8,
                ),
                SizedBox(height: 80),
                OutlinedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/register');
                    },
                    style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        padding:
                            EdgeInsets.symmetric(horizontal: 130, vertical: 12),
                        backgroundColor: Color.fromRGBO(40, 65, 98, 1)),
                    child: Text(
                      "Sign Up",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    )),
                SizedBox(height: 20),
                OutlinedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        padding:
                            EdgeInsets.symmetric(horizontal: 138, vertical: 12),
                        backgroundColor: Color.fromRGBO(255, 255, 255, 1)),
                    child: Text(
                      "Login",
                      style: TextStyle(
                          color: Color.fromRGBO(40, 65, 98, 1), fontSize: 15),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
