import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

Padding customItemOnBoardingScreen(
    {required double screenWidth, required double screenHeight,required String imagePath}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    child: SvgPicture.asset(
      imagePath,
      width: screenWidth * 0.8, // 80% من عرض الشاشة
      height: screenHeight * 0.6, // 60% من ارتفاع الشاشة
      fit: BoxFit.contain, // يجعل الصورة متناسبة دون تشويه
    ),
  );
}