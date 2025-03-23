import 'dart:io';

import 'package:drosak_mangment_app/core/resources/assets_values_manger.dart';
import 'package:drosak_mangment_app/core/resources/const_values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../core/resources/colors_manger.dart';
import '../../../core/resources/fonts_manger.dart';
import '../../../core/resources/provider/educatoin_stages.dart';
import '../../../core/resources/widgets/spaces/horizontal_vertical_space.dart';
import '../../../model/education_stages/item_stages_model.dart';

class CustomItemStage extends StatefulWidget {
  final ItemStageModel itemModel;
  final String number;

  const CustomItemStage({
    super.key,
    required this.itemModel,
    required this.number,
  });

  @override
  State<CustomItemStage> createState() => _CustomItemStageState();
}

class _CustomItemStageState extends State<CustomItemStage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<EducationStagesProvider>(context, listen: false)
          .getAllItemList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EducationStagesProvider>(context);
    return Dismissible(

      confirmDismiss: (direction) async {
        bool? isConfirmDelete;
        if (direction == DismissDirection.startToEnd) {
          isConfirmDelete = await showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    backgroundColor: ColorsManger.kBlackColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 20.h, horizontal: 15.w),
                    iconPadding: EdgeInsets.zero,
                    titlePadding: EdgeInsets.zero,
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Header
                        Text(
                          ConstValue.kDeleteSure,
                          style: TextStyle(
                            color: ColorsManger.kWhiteColor,
                            fontFamily: FontsName.geDinerFont,
                            fontWeight: FontWeight.bold,
                            fontSize: FontsSize.f16,
                          ),
                        ),
                        SizedBox(width: 30.w),

                        SizedBox(height: 20.h),

                        // Content
                        Text(
                          ConstValue.kEducationDeleteSure,
                          style: TextStyle(
                            color: ColorsManger.kWhiteColor,
                            fontFamily: FontsName.geDinerFont,
                            fontSize: FontsSize.f14,
                          ),
                          textAlign: TextAlign.center,
                        ),

                        SizedBox(height: 30.h),

                        // Actions
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(false),
                              child: Text(
                                ConstValue.kNo,
                                style: TextStyle(
                                  color: ColorsManger.kWhiteColor,
                                  fontSize: FontsSize.f14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () async {
                                await provider.softDeleteFun(widget.itemModel);
                                Navigator.of(context).pop(true);
                              },
                              child: Text(
                                ConstValue.kDelete,
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: FontsSize.f14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ));
        } else if (direction == DismissDirection.endToStart) {
          provider.openEditBottomSheet(context: context, itemStageModel: widget.itemModel);
          return false;
        }
        print(isConfirmDelete);
        return isConfirmDelete;
      },
      background: Container(
          alignment: Alignment.centerRight,
          padding: EdgeInsets.all(8.w),
          color: Colors.red,
          child: Text(
            ConstValue.kDelete,
            style: TextStyle(
                color: ColorsManger.kWhiteColor,
                fontFamily: FontsName.geDinerFont,
                fontSize: FontsSize.f20),
          )),
      secondaryBackground: Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.all(8.w),
        color: Colors.green,
        child: Text(
          ConstValue.kEdit,
          style: TextStyle(
              color: ColorsManger.kWhiteColor,
              fontFamily: FontsName.geDinerFont,
              fontSize: FontsSize.f20),
        ),
      ),
      key: ValueKey(widget.itemModel.id),
      child: Stack(clipBehavior: Clip.none, children: [
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
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.itemModel.title,
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
                          widget.itemModel.description,
                          style: TextStyle(
                              fontFamily: FontsName.geDinerFont,
                              fontSize: FontsSize.f10,
                              color: ColorsManger.kWhiteColor.withOpacity(0.6)),
                        ),
                      ),
                      HorizontalVerticalSpace(
                        height: 5.h,
                      ),
                      if (widget.itemModel.createdAt != null)
                        Align(
                          alignment: AlignmentDirectional.bottomEnd,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5.0.w),
                            child: Text(
                              DateFormat('yyyy/MM/dd').format(
                                  DateTime.parse(widget.itemModel.createdAt!)),
                              style: TextStyle(
                                fontFamily: FontsName.geDinerFont,
                                fontSize: FontsSize.f9,
                                color:
                                    ColorsManger.kWhiteColor.withOpacity(0.6),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 8.0.w),
                  child: CircleAvatar(
                    backgroundColor: ColorsManger.kBlackColor,
                    radius: 32.r,
                    backgroundImage: File(widget.itemModel.image).existsSync()
                        ? FileImage(File(widget.itemModel.image))
                        : const AssetImage(AssetsValueManger.kTestImage)
                            as ImageProvider,
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
              child: Text(
                widget.number,
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
