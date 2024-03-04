import 'package:flutter/material.dart';
import 'package:neuroaware/app.dart';

import 'utils/SessionGetter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SessionId.cacheSessionId();
  bool loggedIn = await SessionId.hasSessionId();
  runApp(App(loggedIn: loggedIn));
}
