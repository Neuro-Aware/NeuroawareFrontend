import 'package:http/http.dart' as http;
import 'package:neuroaware/utils/SessionId.dart';

import '../utils/API_endpoints.dart';

class LogoutController {
  void logoutUser() async {
    var url =
        '${ApiEndPoints.baseUrl}/${ApiEndPoints.authEndpoints.logoutEmail}';
    print(await SessionId.getSessionId());
    final response = await http.get(Uri.parse(url), headers: {
      'Cookie': await SessionId.getSessionId(),
    });
    print(response);
  }
}
