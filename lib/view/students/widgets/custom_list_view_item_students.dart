import 'package:drosak_mangment_app/core/resources/colors_manger.dart';
import 'package:drosak_mangment_app/model/student_model/student_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'custom_item_student.dart';

class CustomListViewItemStudents extends StatelessWidget {
  const CustomListViewItemStudents({super.key, required this.listItemStudentModel, required this.onRefresh,});
final List<ItemStudentModel> listItemStudentModel;
final  RefreshCallback onRefresh;



@override
  Widget build(BuildContext context) {


        return Padding(
          padding: EdgeInsets.symmetric(vertical: 24.0.h),
          child: RefreshIndicator(
            backgroundColor: ColorsManger.kBlackColor,
            color: ColorsManger.kPrimaryColor,
            onRefresh: onRefresh,
            child: ListView.separated(
              clipBehavior: Clip.none,
              // itemCount: provider.listItemGroupModel.length,
              itemCount: listItemStudentModel.length,
              itemBuilder: (context, index) {
                // final item = provider.listItemGroupModel[index];
                final item = listItemStudentModel[index];
                return CustomItemStudent(
                  number: (index + 1).toString(),
                  itemModel: item,
                );
              },
              separatorBuilder: (_, __) => SizedBox(height: 24.h),
            ),
          ),
        );
  }
}
