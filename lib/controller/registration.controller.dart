import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:neuroaware/utils/API_endpoints.dart';

class RegistrationController {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  Future<Map<String, dynamic>> registerUser() async {
    final response = await http.post(
      Uri.parse(
          '${ApiEndPoints.baseUrl}/${ApiEndPoints.authEndpoints.registerEmail}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': usernameController.text,
        'email': emailController.text,
        'password': passwordController.text,
        'confirmPassword': confirmPasswordController.text,
      }),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to register user');
    }
    // return {
    //   'message': 'User registered successfully',
    //   'status': 'success',
    //   'data': {
    //     'email': email,
    //     'password': password,
    //   }
    // };
  }
}
