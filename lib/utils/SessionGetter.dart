import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SessionId {
  static final storage = new FlutterSecureStorage();
  static String cachedSessionId = '';

  static Future<void> setSessionId(String value) async {
    if (value.endsWith("; Path=/; HttpOnly")) {
      value = value.substring(0, value.length - 18);
    }
    cachedSessionId = value;
    await storage.write(key: 'sessionId', value: value);
  }

  static Future<String> getSessionId() async {
    // await storage.delete(key: 'sessionId');
    String? value = await storage.read(key: 'sessionId');

    String sessionId = value.toString();
    cachedSessionId = sessionId;
    return sessionId;
  }

  static Future<void> deleteSessionId() async {
    await storage.delete(key: 'sessionId');
  }

  static Future<bool> hasSessionId() async {
    String? value = await storage.read(key: 'sessionId');
    return value != null;
  }

  static Future<void> cacheSessionId() async {
    cachedSessionId = await getSessionId();
  }
}
