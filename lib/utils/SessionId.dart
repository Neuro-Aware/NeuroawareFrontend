import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SessionId {
  static final storage = new FlutterSecureStorage();

  static Future<void> setSessionId(String value) async {
    if (value.endsWith("; Path=/; HttpOnly")) {
      value = value.substring(0, value.length - 18);
    }
    await storage.write(key: 'sessionId', value: value);
  }

  static Future<String> getSessionId() async {
    String? value = await storage.read(key: 'sessionId');
    String sessionId = value.toString();
    return sessionId;
  }
}
