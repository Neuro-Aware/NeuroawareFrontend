import 'package:http/http.dart' as http;

import '../utils/API_endpoints.dart';
import '../utils/SessionGetter.dart';

class GetProfileDetails {
  Future<http.Response> getProfileDetails() async {
    var url = '${ApiEndPoints.baseUrl}/${ApiEndPoints.userEndpoints.getUser}';
    try {
      var response = await http.get(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          // set session cookie here
          'Cookie': SessionId.cachedSessionId,
        },
      );

      return response;
    } catch (e) {
      return http.Response('Error', 500);
    }
  }
  Future<http.Response> getProfileImage() async {
    var url = '${ApiEndPoints.baseUrl}/${ApiEndPoints.userEndpoints.imageGet}';
    try {
      var response = await http.get(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          // set session cookie here
          'Cookie': SessionId.cachedSessionId,
        },
      );

      return response;
    } catch (e) {
      return http.Response('Error', 500);
    }
  }
}