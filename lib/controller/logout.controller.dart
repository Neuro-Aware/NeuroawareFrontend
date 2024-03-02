import 'package:http/http.dart' as http;
import 'package:neuroaware/utils/SessionId.dart';

import '../utils/API_endpoints.dart';

class LogoutController {
  Future<http.Response> logoutUser() async {
    var url =
        '${ApiEndPoints.baseUrl}/${ApiEndPoints.authEndpoints.logoutEmail}';

    try {
      final response = await http.get(Uri.parse(url), headers: {
        'Cookie': await SessionId.getSessionId(),
      });
      return response;
    } catch (e) {
      return http.Response('Error', 500);
    }
  }
}
