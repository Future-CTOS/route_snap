import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'infrastructure/routes/app_route_pages.dart';
import 'infrastructure/routes/route_paths.dart';

class App extends StatelessWidget {
  final String appName;

  const App({required this.appName, super.key});

  @override
  Widget build(BuildContext context) => GetMaterialApp(
    title: appName,
    debugShowCheckedModeBanner: false,
    // theme: DarkLightTheme.theme,
    initialRoute: RoutePaths.splash,
    getPages: AppRoutePages.routes,
  );
}
