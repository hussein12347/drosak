import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/resources/colors_manger.dart';
import '../../../core/resources/fonts_manger.dart';
import '../../../core/resources/widgets/spaces/horizontal_vertical_space.dart';
import '../../../model/education_stages/item_stages_model.dart';

class CustomItemStage extends StatelessWidget {
final ItemStageModel itemModel;
final String number;


  const CustomItemStage({


    super.key, required this.itemModel, required this.number,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(

        clipBehavior: Clip.none,children: [
      Positioned(
          top: -15.h,
          right: 6.w,
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
        decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                color: ColorsManger.kPrimaryColor,
                blurStyle: BlurStyle.outer,
                spreadRadius: -2,
                blurRadius: 8,
              )
            ],
            borderRadius: BorderRadius.circular(18.r),
            border: Border.all(color: ColorsManger.kPrimaryColor)),
        margin: EdgeInsets.symmetric(horizontal: 16.w),
        child: Padding(
          padding: EdgeInsets.only(
              right: 22.0.w, left: 10.w, top: 8.h, bottom: 8.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            textDirection: TextDirection.ltr,
            children: [
              Padding(
                padding: EdgeInsets.only(right: 8.0.w),
                child: CircleAvatar(
                  radius: 32.r,
                  backgroundImage:  AssetImage(
                      itemModel.image),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      itemModel.title,
                      style: TextStyle(
                          fontFamily: FontsName.geDinerFont,
                          fontSize: FontsSize.f16,
                          color: ColorsManger.kWhiteColor),
                    ),
                    HorizontalVerticalSpace(
                      height: 5.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 5.0.w),
                      child: Text(

                        itemModel.description
                        , style: TextStyle(
                          fontFamily: FontsName.geDinerFont,
                          fontSize: FontsSize.f10,
                          color: ColorsManger.kWhiteColor
                              .withOpacity(0.6)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      Positioned(
          top: -16.5.h,
          right: 5.w,
          child: CircleAvatar(
            backgroundColor: ColorsManger.kBlackColor,
            radius: 18.5.r,
          )),
      Positioned(
          top: -10.h,
          right: 10.w,
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
    ]);
  }
}
