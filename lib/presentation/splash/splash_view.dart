import 'dart:async';

import 'package:_tut_app/presentation/resources/assets_manager.dart';
import 'package:_tut_app/presentation/resources/color_manager.dart';
import 'package:_tut_app/presentation/resources/routes_manager.dart';
import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  _goNext() async {
    await Future.delayed(Duration(seconds: 5), () {});
    Navigator.pushReplacementNamed(context, Routes.onBoardingRoute);
  }

  @override
  void initState() {
    _goNext();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      body: Center(child: Image(image: AssetImage(ImageAssets.splash_logo))),
    );
  }
}
