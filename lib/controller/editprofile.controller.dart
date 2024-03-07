import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:neuroaware/utils/API_endpoints.dart';
import 'package:neuroaware/utils/SessionGetter.dart';

class EditProfileController {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  void dispose() {
    nameController.dispose();
    emailController.dispose();
  }

  Future<http.Response> editProfileDetails() async {
    var url =
        '${ApiEndPoints.baseUrl}/${ApiEndPoints.userEndpoints.updateUser}';
    try {
      var response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          // set session cookie here
          'Cookie': SessionId.cachedSessionId,
        },
        body: {
          'name': nameController.text.trim(),
          'email': emailController.text.trim(),
        },
      );

      return response;
    } catch (e) {
      return http.Response('Error', 500);
    }
  }

  Future<http.Response> editProfileImage(File? image) async {
    var url =
        '${ApiEndPoints.baseUrl}/${ApiEndPoints.userEndpoints.updateImage}';
    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));

      // request.cookies.addAll([
      //   http.Cookie('name', nameController.text.trim()),
      //   http.Cookie('email', emailController.text.trim())
      // ]);
      request.files.add(http.MultipartFile.fromBytes(
          'profileImage', image!.readAsBytesSync(),
          filename: image!.path.split("/").last));

      http.StreamedResponse response = await request.send();
      return http.Response.fromStream(response);
    } catch (e) {
      return http.Response('Error', 500);
    }
  }
}
