import 'dart:math';

import 'package:flutter/material.dart';

import '../../../core/resources/assets_values_manger.dart';
import '../../../core/resources/colors_manger.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: ColorManger.kBlackColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(AssetsValueManger.kSplash_borderImage),
          Center(child: Image.asset(AssetsValueManger.kLogoImage),),
          Align(alignment: AlignmentDirectional.bottomEnd,child: Transform(alignment: Alignment.center,transform: Matrix4.rotationZ(-pi), // تدوير 90 درجة للأعلى,
          child: Image.asset(AssetsValueManger.kSplash_borderImage)),)
        ],
      ),
    );
  }
}
