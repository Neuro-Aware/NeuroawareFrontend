import 'package:flutter/material.dart';
import 'package:neuroaware/app.dart';
import 'package:neuroaware/utils/localStorage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorage.cacheData();
  bool loggedIn = await LocalStorage.hasSessionId();
  runApp(App(loggedIn: loggedIn));
}
