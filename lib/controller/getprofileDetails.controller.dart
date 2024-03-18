import 'package:http/http.dart' as http;

import '../utils/API_endpoints.dart';
import '../utils/localStorage.dart';

class GetProfileDetails {
  Future<http.Response> getProfileDetails() async {
    var url = '${ApiEndPoints.baseUrl}/${ApiEndPoints.userEndpoints.getUser}';
    var sessionId = await LocalStorage.data['sessionId'];
    try {
      var response = await http.get(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          // set session cookie here
          'Cookie': sessionId.toString(),
        },
      );

      return response;
    } catch (e) {
      return http.Response('Error', 500);
    }
  }

  Future<http.Response> getProfileImage() async {
    var url = '${ApiEndPoints.baseUrl}/${ApiEndPoints.userEndpoints.imageGet}';
    // print(LocalStorage.data['sessionId'].toString());
    try {
      var response = await http.get(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          // set session cookie here
          'Cookie': LocalStorage.data['sessionId'].toString(),
        },
      );

      return response;
    } catch (e) {
      return http.Response('Error', 500);
    }
  }
}
