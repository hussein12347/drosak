import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/resources/colors_manger.dart';
import '../../../core/resources/fonts_manger.dart';

class CustomContainerOfNameAndImage extends StatelessWidget {
  const CustomContainerOfNameAndImage({
    super.key, required this.name, required this.image, required this.number, required this.onTap,
  });
  final String name;
  final String image;
  final String number;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Stack(clipBehavior: Clip.none, children: [
        Positioned(
            bottom: -16.h,
            left: -16.w,
            child: Container(
              width: 32.w,
              height: 32.h,
              decoration: BoxDecoration(
                  color: ColorsManger.kBlackColor,
                  borderRadius: BorderRadius.all(Radius.circular(18.r)),
                  boxShadow: const [
                    BoxShadow(
                        color: ColorsManger.kPrimaryColor,
                        blurRadius: 12,
                        offset: Offset(0, 0),
                        spreadRadius: 1,
                        blurStyle: BlurStyle.outer)
                  ]),
            )),
        Container(
          width: double.infinity,
          decoration:  BoxDecoration(
            border: Border.all(color: ColorsManger.kPrimaryColor,width: 2.w),
              borderRadius: const BorderRadius.all(Radius.circular(18)),
              boxShadow: const [
                BoxShadow(
                    color: ColorsManger.kPrimaryColor,
                    blurRadius: 10,
                    offset: Offset(0, 0),
                    spreadRadius: 1,
                    blurStyle: BlurStyle.outer)
              ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(

                padding:
                EdgeInsets.symmetric(horizontal: 7.w, vertical: 3.h),
                width: double.infinity,
                decoration: BoxDecoration(

                  borderRadius: BorderRadius.all(Radius.circular(12.r)),
                ),
                margin:
                EdgeInsets.symmetric(horizontal: 1.w, vertical: 5.h),
                child: Text(
                  name,
                  style: TextStyle(
                      color: ColorsManger.kWhiteColor,
                      fontFamily: FontsName.geDinerFont,
                      fontWeight: FontWeight.bold,
                      fontSize: FontsSize.f15),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 7.w),
                child: SvgPicture.asset(
                  image,
                  width: 95.w,
                  height: 63.h,
                ),
              )
            ],
          ),
        ),
        Positioned(
            bottom: -18.5.h,
            left: -16.w,
            child: CircleAvatar(
              backgroundColor: ColorsManger.kBlackColor,
              radius: 18.5.r,
            )),
        Positioned(
            bottom: -13.h,
            left: -10.5.w,
            child: CircleAvatar(
              backgroundColor: ColorsManger.kPrimaryColor,
              radius: 12.5.r,
              child:  Text(
                number,
                style: const TextStyle(
                    color: ColorsManger.kBlackColor,
                    fontWeight: FontWeight.w500,
                    fontFamily: FontsName.geDinerFont),
              ),
            )),
      ]),
    );
  }
}
