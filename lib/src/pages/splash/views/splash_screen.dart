import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) =>
      Scaffold(backgroundColor: Colors.white, body: Text('splash'));

  // Widget _content(BuildContext context) =>
  //     Center(child: ShineEffect(child: _logo(context)));

  Widget _logo(BuildContext context) => SizedBox(
    height: context.height / 1.75,
    width: context.width / 1.75,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        //   Expanded(flex: 2, child: Image.asset(Assets.svg.cup.path)),
        SizedBox(height: 16),
        //  Expanded(flex: 1, child: SvgPicture.asset(Assets.svg.appName)),
        Expanded(flex: 3, child: Text('')),
      ],
    ),
  );
}
