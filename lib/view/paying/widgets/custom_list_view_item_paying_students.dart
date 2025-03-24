import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../core/resources/provider/educatoin_stages.dart';
import '../../../core/resources/provider/groups.dart';
import '../../../core/resources/provider/students_provider.dart';
import '../../../core/resources/widgets/spaces/horizontal_vertical_space.dart';
import '../../../model/student_model/student_model.dart';
import 'custom_item_paying_student.dart';
import 'custom_select_group_education_pay.dart';

class CustomListViewItemPayingStudents extends StatefulWidget {
  final bool isSearch;
  final List<ItemStudentModel> listItemStudentModelSelectedByGroup;
  const CustomListViewItemPayingStudents({
    super.key, required this.listItemStudentModelSelectedByGroup, required this.isSearch,
  });

  @override
  State<CustomListViewItemPayingStudents> createState() =>
      _CustomListViewItemPayingStudentsState();
}

class _CustomListViewItemPayingStudentsState
    extends State<CustomListViewItemPayingStudents> {
  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    Future.microtask(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<StudentsProvider>(
      context,
    );
    final providerEducation = Provider.of<EducationStagesProvider>(context);
    final providerGroup = Provider.of<GroupsProvider>(context);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 18.0.h),
      child: Column(
        children: [
      widget.isSearch?SizedBox.shrink(): CustomSelectGroupAndEducationStagePay(
            listItemGroupModel: provider.listItemGroupModel,
            onChangeGroup: (p0) {
              provider.onChangeSelectStudentByGroup(p0);
            },
            listItemEducationModel: providerEducation.listItemStageModel,
            onChangeEducation: (p0) {
              provider.onChangeSelectEducation(p0);
            },
            initialGroupItem: provider.selectedGroup,
          ),
          HorizontalVerticalSpace(height: 10.h), // إضافة مسافة لمنع التراكب
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.only(top: 10.h), // تحسين التباعد
              itemCount: widget.listItemStudentModelSelectedByGroup.length,
              itemBuilder: (context, index) {
                final item = widget.listItemStudentModelSelectedByGroup[index];
                return CustomItemPayingStudent(
                  number: (index + 1).toString(),
                  itemModel: item,
                  onPressedChangePayingStat: (p0) {
                    provider.ChangePayingState(p0);
                  },  onPressedDelete:  () async {
                  await provider
                      .deleteStudent(widget
                      .listItemStudentModelSelectedByGroup[index]);

                  Navigator.of(context)
                      .pop(true);
                },
                );
              },
              separatorBuilder: (_, __) => SizedBox(height: 24.h),
            ),
          ),
        ],
      ),
    );
  }
}
