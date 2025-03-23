import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../core/resources/colors_manger.dart';
import '../../../core/resources/fonts_manger.dart';
import '../../../core/resources/provider/students_provider.dart';
import '../../../model/student_model/pying_table_item_model.dart';

class TableWidget extends StatefulWidget {
  final void Function(PayingTableItemModel index) onPressedChangePayingStat;
  final int studentID;
  const TableWidget({super.key, required this.onPressedChangePayingStat, required this.studentID});

  @override
  State<TableWidget> createState() => _TableWidgetState();
}

class _TableWidgetState extends State<TableWidget> {
  bool _isTableVisible = false; // متغير للتحكم في إظهار الجدول

  @override
  Widget build(BuildContext context) {
    final provider =  Provider.of<StudentsProvider>(context,);
    return Column(
      children: [
        /// زر إظهار/إخفاء الجدول
        Center(
          child: TextButton(
            onPressed: () {
             provider.getAllItemPayingListOfTable( studentID: widget.studentID) ;

              setState(() {
                _isTableVisible = !_isTableVisible; // تبديل حالة الإظهار
              });
            },
            child: Text(
              _isTableVisible ? "إخفاء الجدول" : "انقر لعرض الجدول",
              style: const TextStyle(color: ColorsManger.kPrimaryColor, fontSize: 16),
            ),
          ),
        ),

        /// إضافة مسافة بين الزر والجدول
        SizedBox(height: 10.h),

        /// استخدام `Visibility` لإظهار الجدول عند الحاجة
        Visibility(
          visible: _isTableVisible,
          child: Table(
            border: TableBorder.all(
                color: ColorsManger.kWhiteColor,
                borderRadius: BorderRadius.circular(14.r)),
            children: [
              TableRow(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(14.r)),
                  color: ColorsManger.kPrimaryColor,
                ),
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
                    child: const Center(
                      child: Text("الشهر",
                          style: TextStyle(color: ColorsManger.kBlackColor)),
                    ),
                  ),
                  Padding(
                    padding:
                    EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
                    child: const Center(
                      child: Text(
                        "حالة الدفع",
                        style: TextStyle(
                          color: ColorsManger.kBlackColor,
                          fontWeight: FontWeight.bold,
                          fontFamily: FontsName.geDinerFont,
                        ),
                      ),
                    ),
                  ),

                ],
              ),
              for (int i = 0; i < provider.listPayingTableItemModel.length; i++)
                TableRow(children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 10.h),
                    child: Center(
                      child: Text(
                        provider.listPayingTableItemModel[i].month,
                        style: const TextStyle(
                          color: ColorsManger.kPrimaryColor,
                          fontWeight: FontWeight.bold,
                          fontFamily: FontsName.geDinerFont,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      widget.onPressedChangePayingStat(provider.listPayingTableItemModel[i]);
                    },
                    icon: (provider.listPayingTableItemModel[i].isPaid ==1)?const Icon(Icons.check):const Icon(Icons.close),
                    color: (provider.listPayingTableItemModel[i].isPaid == 1)?Colors.green:Colors.redAccent,
                  ),
                ]),
            ],
          ),
        ),
      ],
    );
  }
}

