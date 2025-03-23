import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../resources/colors_manger.dart';
import '../../resources/fonts_manger.dart';

Widget buildImageSourceButton({
  required IconData icon,
  required String label,
  required VoidCallback onPressed,
}) {
  return Column(
    children: [
      Container(
        decoration: const BoxDecoration(
          color: ColorsManger.kPrimaryColor,
          shape: BoxShape.circle,
        ),
        child: IconButton(
          iconSize: 40.r,
          icon: Icon(icon, color: Colors.black),
          onPressed: onPressed,
          style: IconButton.styleFrom(
            padding: EdgeInsets.all(15.r),
          ),
        ),
      ),
      SizedBox(height: 8.h),
      Text(
        label,
        style: TextStyle(
          color: ColorsManger.kWhiteColor,
          fontFamily: FontsName.geDinerFont,
          fontSize: FontsSize.f14,
        ),
      ),
    ],
  );
}