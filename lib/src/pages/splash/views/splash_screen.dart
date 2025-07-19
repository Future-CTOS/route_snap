import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/splash_controller.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.white,
    body: Obx(() => SafeArea(child: _body(context))),
  );

  Widget _body(BuildContext context) {
    if (controller.isLoading.value) {
      return CircularProgressIndicator();
    }
    if (controller.hasError.value) {
      return _retry();
    }

    return SizedBox(
      height: context.height / 1.75,
      width: context.width / 1.75,
      child: CircularProgressIndicator(),
    );
  }

  Widget _retry() =>
      ElevatedButton(onPressed: controller.startTheApp, child: Text('Retry'));
}
