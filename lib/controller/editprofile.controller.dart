import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:neuroaware/utils/API_endpoints.dart';
import 'package:neuroaware/utils/localStorage.dart';

class EditProfileController {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneControlller = TextEditingController();

  void dispose() {
    nameController.dispose();
    phoneControlller.dispose();
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
          'Cookie': LocalStorage.data['sessionId'].toString(),
        },
        body: jsonEncode({
          'name': nameController.text.trim(),
          'phoneNo': phoneControlller.text.trim(),
        }),
      );

      return response;
    } catch (e) {
      return http.Response('Error', 500);
    }
  }

  Future<http.Response> editProfileImage(File image) async {
    var url =
        '${ApiEndPoints.baseUrl}/${ApiEndPoints.userEndpoints.updateImage}';
    var headers = {
      'Cookie': LocalStorage.data['sessionId'].toString(),
    };

    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));

      // Check if the image file exists
      if (!image.existsSync()) {
        throw Exception('Image file does not exist');
      }

      var multipartFile =
          await http.MultipartFile.fromPath('profileImage', image.path);

      request.files.add(multipartFile);
      request.headers.addAll(headers);

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      return response;
    } catch (e) {
      print('Error sending profile image: $e');
      return http.Response('Error', 500);
    }
  }
}
