
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/resources/colors_manger.dart';
import '../../../core/resources/const_values.dart';
import '../../../core/resources/fonts_manger.dart';
import '../../../core/resources/widgets/spaces/horizontal_vertical_space.dart';
import '../../../core/widgets/buttons/custom_material_bottun.dart';
import '../../../model/groups/time_day_group_model.dart';

class CustomAddTimeAndDayToTable extends StatelessWidget {
  const CustomAddTimeAndDayToTable(
      {super.key,
      required this.listDay,
      this.time,
      required this.clearTime,
      required this.onChangeDay,
      required this.selectTime,
      required this.onPressedAddTimeToTable,
      required this.listTimeDayGroupModel, required this.onPressedDelete,
    });

  final List<String> listDay;
  final String? time;
  final void Function() clearTime;
  final void Function() onPressedAddTimeToTable;
  final void Function() selectTime;
  final void Function(int index) onPressedDelete;
  final Function(String?)? onChangeDay;
  final List<TimeDayGroupModel> listTimeDayGroupModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          textDirection: TextDirection.rtl,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                textDirection: TextDirection.rtl,
                children: [
                  Expanded(
                      child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: CustomDropdown<String>.search(
                      searchHintText: "",
                      noResultFoundText: "",
                      hintText: ConstValue.kChooseDay,
                      items: listDay,
                      onChanged: onChangeDay,
                    ),
                  ))
                ],
              ),
            ),
            HorizontalVerticalSpace(
              width: 10.w,
            ),
            (time == null)
                ? CustomMaterialButton(
                    icon: CupertinoIcons.time_solid,
                    withIcon: true,
                    onPressed: selectTime,
                    text: ConstValue.kChooseTime)
                : CustomMaterialButton(
                    icon: CupertinoIcons.time_solid,
                    withIcon: true,
                    onPressed: clearTime,
                    text: time!,
                  ),

            // Expanded(

            // child: Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   textDirection: TextDirection.rtl,
            //   children: [
            //     Text(
            //       ConstValue.kTime,
            //       style: TextStyle(
            //           color: ColorsManger.kPrimaryColor,
            //           fontSize: FontsSize.f14,
            //           fontFamily: FontsName.geDinerFont),
            //     ),
            //     HorizontalVerticalSpace(
            //       width: 6.w,
            //     ),
            //     Expanded(
            //         child: Directionality(
            //           textDirection: TextDirection.rtl,
            //           child: CustomDropdown<String>.search(
            //             searchHintText: "",
            //             noResultFoundText: "",
            //             hintText: ConstValue.kChooseTime,
            //             items: [],
            //             onChanged: (value) {
            //               log('changing value to: $value');
            //             },
            //           ),
            //         ))
            //   ],
            // ),
            // ),
          ],
        ),
        HorizontalVerticalSpace(
          height: 15.h,
        ),
        CustomMaterialButton(
            withIcon: true,
            infinityWidth: false,
            icon: Icons.download_outlined,
            onPressed: () {
              onPressedAddTimeToTable();
            },
            text: ConstValue.kAddToTable),
        HorizontalVerticalSpace(
          height: 15.h,
        ),
        Directionality(
          textDirection: TextDirection.rtl,
          child: Table(
            border: TableBorder.all(
                color: ColorsManger.kWhiteColor,
                borderRadius: BorderRadius.circular(14.r)),
            children: [
              TableRow(
                  decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(14.r)),
                      color: ColorsManger.kPrimaryColor),
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
                      child: const Center(
                        child: Text(
                          ConstValue.kDay,
                          style: TextStyle(
                            color: ColorsManger.kBlackColor,
                            fontWeight: FontWeight.bold,
                            fontFamily: FontsName.geDinerFont,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
                      child: const Center(
                        child: Text(
                          ConstValue.kTime,
                          style: TextStyle(
                            color: ColorsManger.kBlackColor,
                            fontWeight: FontWeight.bold,
                            fontFamily: FontsName.geDinerFont,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
                      child: const Center(
                        child: Text(
                          ConstValue.kDelete,
                          style: TextStyle(
                            color: ColorsManger.kBlackColor,
                            fontWeight: FontWeight.bold,
                            fontFamily: FontsName.geDinerFont,
                          ),
                        ),
                      ),
                    ),
                  ]),
              for (int i = 0; i < listTimeDayGroupModel.length; i++)
                TableRow(children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 4.w, vertical: 10.h),
                    child: Center(
                      child: Text(
                        listTimeDayGroupModel[i].day,
                        style: const TextStyle(
                          color: ColorsManger.kPrimaryColor,
                          fontWeight: FontWeight.bold,
                          fontFamily: FontsName.geDinerFont,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 4.w, vertical: 10.h),
                    child: Center(
                      child: Text(
                        listTimeDayGroupModel[i].time,
                        style: const TextStyle(
                          color: ColorsManger.kWhiteColor,
                          fontWeight: FontWeight.bold,
                          fontFamily: FontsName.geDinerFont,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      onPressedDelete(i);
                    },
                    icon: const Icon(CupertinoIcons.delete),
                    color: Colors.redAccent,
                  ),
                ])
            ],
          ),
        ),
        if (listTimeDayGroupModel.isEmpty)
          Column(
            children: [
              HorizontalVerticalSpace(
                height: 10.h,
              ),
              const Center(
                child: Text(
                  ConstValue.kNoTimeAndDAyAddedYet,
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontWeight: FontWeight.bold,
                    fontFamily: FontsName.geDinerFont,
                  ),
                ),
              ),
            ],
          )
      ],
    );
  }
}
