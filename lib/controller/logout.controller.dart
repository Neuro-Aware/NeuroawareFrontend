import 'package:http/http.dart' as http;

import '../utils/API_endpoints.dart';
import '../utils/localStorage.dart';

class LogoutController {
  Future<http.Response> logoutUser() async {
    var url =
        '${ApiEndPoints.baseUrl}/${ApiEndPoints.authEndpoints.logoutEmail}';

    try {
      final response = await http.get(Uri.parse(url), headers: {
        'Cookie': LocalStorage.data['sessionId'].toString(),
      });
      return response;
    } catch (e) {
      return http.Response('Error', 500);
    }
  }
}
