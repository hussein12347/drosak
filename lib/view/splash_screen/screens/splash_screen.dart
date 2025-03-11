import 'dart:math';

import 'package:flutter/material.dart';

import '../../../controller/splash_screen/splash_screen_controller.dart';
import '../../../core/resources/assets_values_manger.dart';
import '../../../core/resources/colors_manger.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {


  late SplashScreenController _controller;
  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    _controller =SplashScreenController(vsync: this, context: context);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.disposeController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManger.kBlackColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SlideTransition(
              position: _controller.animationTop,
              child: Image.asset(AssetsValueManger.kSplash_borderImage)),
          Center(
            child: Image.asset(AssetsValueManger.kLogoImage),
          ),
          Align(
            alignment: AlignmentDirectional.bottomEnd,
            child: SlideTransition(
              position: _controller.animationBottom,
              child: Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.rotationZ(-pi),
                  // تدوير 90 درجة للأعلى,
                  child: Image.asset(AssetsValueManger.kSplash_borderImage)),
            ),
          )
        ],
      ),
    );
  }
}
