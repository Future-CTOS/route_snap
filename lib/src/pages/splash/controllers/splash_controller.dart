import 'dart:io';

import 'package:package_info_plus/package_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../infrastructure/routes/route_names.dart';
import 'package:geolocator/geolocator.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startTheApp();
    });
  }

  final RxBool isLoading = false.obs;
  final RxBool hasError = false.obs;

  Future<void> _startTheApp() async {
    isLoading.value = true;

    final bool internet = await _checkInternet();
    if (!internet) return _showRetryDialog('اتصال به اینترنت برقرار نیست.');

    final bool gps = await _checkGpsStatus();
    if (!gps) return _showRetryDialog('GPS غیرفعال است.');

    final bool permission = await _checkLocationPermission();
    if (!permission) return _showRetryDialog('دسترسی لوکیشن داده نشد.');

    final bool versionOk = await _checkAppVersion();
    if (!versionOk) return _showUpdateDialog();

    _goToHome();
  }

  Future<bool> _checkInternet() async {
    try {
      final result = await InternetAddress.lookup('https://www.digikala.com');
      return result.isNotEmpty;
    } catch (_) {
      return false;
    }
  }

  Future<bool> _checkGpsStatus() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    return serviceEnabled;
  }

  Future<bool> _checkLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    return permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse;
  }

  Future<bool> _checkAppVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    final buildNumber = int.parse(packageInfo.buildNumber);

    final latestBuild = await _fakeCheckFromServer();

    return buildNumber >= latestBuild;
  }

  Future<int> _fakeCheckFromServer() async {
    await Future.delayed(1.seconds);
    return 10;
  }

  void _showRetryDialog(String message) => Get.defaultDialog(
    title: 'خطا',
    middleText: message,
    confirm: ElevatedButton(onPressed: _startTheApp, child: Text('تلاش مجدد')),
  );

  void _showUpdateDialog() => Get.defaultDialog(
    title: 'بروزرسانی لازم است',
    middleText: 'لطفاً اپلیکیشن را بروزرسانی کنید.',
    confirm: ElevatedButton(onPressed: () {}, child: Text('بروزرسانی')),
  );

  void _goToHome() => Get.offAllNamed(RouteNames.mapSelector);
}
