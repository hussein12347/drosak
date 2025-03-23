
import 'package:drosak_mangment_app/core/resources/provider/groups.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../core/resources/colors_manger.dart';
import '../../../core/resources/const_values.dart';
import '../../../core/resources/provider/educatoin_stages.dart';
import '../../../core/resources/widgets/spaces/horizontal_vertical_space.dart';
import '../../../core/widgets/buttons/custom_material_bottun.dart';
import '../../../model/groups/time_day_group_model.dart';
import 'custom_add_time_and_day_to_table.dart';
import 'custom_group_details_add_new_group.dart';
import 'custom_select_education_stage_add_new_group.dart';

class CustomEditGroup extends StatefulWidget {
  const CustomEditGroup({
    super.key,
    required this.onPressedAdd,
    required this.formKey,
    this.isAdd = true,
    required this.onPressedEdit, required this.controllerAddNewGroupName, required this.controllerAddNewGroupDescription,    required this.listTimeDayGroupModel, required this.educationID,
  });

  final VoidCallback onPressedAdd;
  final VoidCallback onPressedEdit;
  final bool isAdd;
  final int educationID;
  final GlobalKey<FormState> formKey;
  final TextEditingController controllerAddNewGroupName;
  final TextEditingController controllerAddNewGroupDescription;
  final List<TimeDayGroupModel>listTimeDayGroupModel;

  @override
  State<CustomEditGroup> createState() => _CustomEditGroupState();
}

class _CustomEditGroupState extends State<CustomEditGroup> {
  @override
  void initState() {
    super.initState();

    /// 🔹 تحميل قائمة المراحل التعليمية عند فتح الشاشة
    final provider = Provider.of<GroupsProvider>(context, listen: false);
    final providerEducation = Provider.of<EducationStagesProvider>(context, listen: false);
    provider.getAllItemList();
    providerEducation.getAllItemList();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GroupsProvider>(context);
    final providerEducation = Provider.of<EducationStagesProvider>(context);

    return Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 20.h),
        decoration: BoxDecoration(
            color: ColorsManger.kBlackColor,
            borderRadius: BorderRadiusDirectional.only(
                topEnd: Radius.circular(12.r),
                topStart: Radius.circular(12.r))),
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomGroupDetailsAddNewGroup(
              context: context,
              controllerAddNewGroupName: widget.controllerAddNewGroupName,
              controllerAddNewGroupDescription:widget.controllerAddNewGroupDescription
              ,
              formKey: widget.formKey,
            ),
            HorizontalVerticalSpace(
              height: 15.h,
            ),
            CustomSelectEducationStageAddNewGroup(
              educationID: widget.educationID,
              isEdit: true,

              listItemStageModel: providerEducation.listItemStageModel,
              onChange: provider.onChangeSelectEducationStage,
            ),
            HorizontalVerticalSpace(
              height: 15.h,
            ),
            CustomAddTimeAndDayToTable(
              listDay: ConstValue.daysOfWeek,
              clearTime: provider.clearTime,
              time: provider.time,
              onChangeDay: provider.onChangeDay,
              selectTime: () {
                provider.selectTime(context);
              },
              onPressedAddTimeToTable: () {
                provider.onPressedAddTimeToTable();
              },
              listTimeDayGroupModel: widget.listTimeDayGroupModel, onPressedDelete:
            provider.onPressedDelete
              ,

            ),
            HorizontalVerticalSpace(
              height: 20.h,
            ),
            //   image!=""?Image.file(File(image),height: 200.h,width: double.infinity,fit:BoxFit.contain ,):const SizedBox.shrink(),
            CustomMaterialButton(
              withIcon: true,
              infinityWidth: true,
              onPressed: widget.isAdd == true
                  ? widget.onPressedAdd
                  : widget.onPressedEdit,
              text:
              widget.isAdd == true ? ConstValue.kSaveAll : ConstValue.kEdit,
            ),
          ],
        ));
  }
}
