import 'package:drosak_mangment_app/core/resources/widgets/spaces/horizontal_vertical_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../resources/colors_manger.dart';
import '../../resources/fonts_manger.dart';

class CustomMaterialButton extends StatelessWidget {
  const CustomMaterialButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.infinityWidth = false,
    this.withIcon = false,  this.icon=Icons.save,
  });

  final VoidCallback onPressed;
  final String text;
  final bool infinityWidth;
  final bool withIcon;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: infinityWidth ? double.infinity : 0,
      shape: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
      padding: REdgeInsets.symmetric(vertical: 10.h, horizontal: 40.w),
      color: ColorsManger.kPrimaryColor,
      onPressed: onPressed,
      child: withIcon
          ? Row(mainAxisSize: MainAxisSize.min,mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(
                icon,
                color: ColorsManger.kBlackColor,
              ),
              HorizontalVerticalSpace(
                width: 8.w,
              ),
              Text(
                text,
                style: TextStyle(
                  fontFamily: FontsName.geDinerFont,
                  fontSize: FontsSize.f16,
                ),
              )
            ])
          : Text(
              text,
              style: TextStyle(
                fontFamily: FontsName.geDinerFont,
                fontSize: FontsSize.f16,
              ),
            ),
    );
  }
}
