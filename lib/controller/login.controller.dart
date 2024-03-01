import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../utils/API_endpoints.dart';

class LoginController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
  }

  Future<http.Response> loginUser() async {
    var url =
        '${ApiEndPoints.baseUrl}/${ApiEndPoints.authEndpoints.loginEmail}';
    print(url);
    try {
      var response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'email': emailController.text.trim(),
          'password': passwordController.text.trim(),
        }),
      );

      print(response);
      return response;
    } catch (e) {
      print(e);
      return http.Response('Error', 500);
    }
  }
}
