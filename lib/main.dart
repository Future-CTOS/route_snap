import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'src/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final info = await PackageInfo.fromPlatform();
  runApp(App(appName: info.appName));
}
