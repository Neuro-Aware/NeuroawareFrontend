import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalStorage {
  static final storage = new FlutterSecureStorage();
  static Map<String, dynamic> data = {};

  static Future<void> write(String key, dynamic value) async {
    data[key] = value;
    await storage.write(key: key, value: value);
  }

  static Future<dynamic> read(String key) async {
    var value = await storage.read(key: key);
    data[key] = value;
    return value;
  }

  static Future<Map<String, dynamic>> readAll() async {
    var allValues = await storage.readAll();
    data.addAll(allValues);
    return allValues;
  }

  static Future<void> delete(String key) async {
    await storage.delete(key: key);
  }

  static Future<bool> hasSessionId() async {
    String? value = await storage.read(key: 'sessionId');
    return value != null;
  }

  static Future<void> clear() async {
    await storage.deleteAll();
  }

  static Future<void> cacheData() async {
    data = await storage.readAll();
  }
}
