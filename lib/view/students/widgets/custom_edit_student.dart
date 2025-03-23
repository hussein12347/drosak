
import 'package:drosak_mangment_app/core/resources/fonts_manger.dart';
import 'package:drosak_mangment_app/model/education_stages/item_stages_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../core/resources/colors_manger.dart';
import '../../../core/resources/const_values.dart';
import '../../../core/resources/provider/educatoin_stages.dart';
import '../../../core/resources/provider/students_provider.dart';
import '../../../core/resources/widgets/spaces/horizontal_vertical_space.dart';
import '../../../core/widgets/buttons/custom_material_bottun.dart';
import '../../../model/groups/item_groub_model.dart';
import '../../../model/groups/time_day_group_model.dart';
import 'custom_select_group_add_new_student.dart';
import 'custom_student_details_add_new_student.dart';

class CustomEditStudent extends StatefulWidget {
  const CustomEditStudent({
    super.key,
    required this.onPressedAdd,
    required this.formKey,
    this.isAdd = true,
    required this.onPressedEdit, required this.InitialItemGroupModel, required this.initialStageItem,
  });

  final VoidCallback onPressedAdd;
  final VoidCallback onPressedEdit;
  final bool isAdd;
  final GlobalKey<FormState> formKey;
  final ItemGroupModel InitialItemGroupModel;
  final ItemStageModel initialStageItem;

  @override
  State<CustomEditStudent> createState() => _CustomEditStudentState();
}

class _CustomEditStudentState extends State<CustomEditStudent> {
  @override
  void initState() {
    super.initState();

    /// 🔹 تحميل قائمة المراحل التعليمية عند فتح الشاشة
    final provider = Provider.of<StudentsProvider>(context, listen: false);
    final providerEducation = Provider.of<EducationStagesProvider>(context, listen: false);
    provider.getAllItemList();
    providerEducation.getAllItemList();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<StudentsProvider>(context);
    final providerEducation = Provider.of<EducationStagesProvider>(context);


    List<TimeDayGroupModel>listTimeDayGroupModel=provider.listTimeDayGroupModel;

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
            CustomStudentDetailsAddNewStudent(

              context: context,
              controllerAddNewGroupName: provider.controllerAddNewGroupName,
              controllerAddNewGroupDescription:
                  provider.controllerAddNewGroupNote,
              formKey: widget.formKey,
            ),
            HorizontalVerticalSpace(
              height: 15.h,
            ),
            CustomSelectGroupAddNewStudent(

              listItemGroupModel: provider.listItemGroupModel,
              onChangeGroup:(p0) {
                provider.onChangeSelectGroup(p0);
              }, listItemEducationModel: providerEducation.listItemStageModel, onChangeEducation:(p0) {
              provider.onChangeSelectEducation(p0);
              }, initialGroupItem: widget.InitialItemGroupModel,isEdit: true,initialStageItem: widget.initialStageItem ,
            ),

            HorizontalVerticalSpace(
              height: 10.h,
            ),
            listTimeDayGroupModel.isEmpty?              const Center(
              child: Text(
                ConstValue.kSureChooseGroup,
                style: TextStyle(
                  color: Colors.redAccent,
                  fontWeight: FontWeight.bold,
                  fontFamily: FontsName.geDinerFont,
                ),
              ),
            ):Directionality(
              textDirection: TextDirection.rtl,
              child: Table(
                border: TableBorder.all(
                    color: ColorsManger.kWhiteColor,
                    borderRadius: BorderRadius.circular(14.r)),
                children: [
                  TableRow(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.vertical(
                              top: Radius.circular(14.r)),
                          color: ColorsManger.kPrimaryColor),
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 4.w, vertical: 4.h),
                          child: const Center(
                            child: Text(
                              "اليوم",
                              style: TextStyle(
                                  color: ColorsManger.kBlackColor),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 4.w, vertical: 4.h),
                          child: const Center(
                            child: Text(
                              "الوقت",
                              style: TextStyle(
                                  color: ColorsManger.kBlackColor),
                            ),
                          ),
                        ),
                      ]),
                  for (int i = 0; i < listTimeDayGroupModel.length; i++)
                    TableRow(children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 4.w, vertical: 10.h),
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
                        padding: EdgeInsets.symmetric(
                            horizontal: 4.w, vertical: 10.h),
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
                    ]),
                ],
              ),
            ),
            HorizontalVerticalSpace(
              height: 20.h,
            ),
            //   image!=""?Image.file(File(image),height: 200.h,width: double.infinity,fit:BoxFit.contain ,):const SizedBox.shrink(),
            CustomMaterialButton(
              withIcon: true,
              infinityWidth: true,
              onPressed:
                   widget.onPressedAdd,

              text:
                  widget.isAdd == true ? ConstValue.kSaveAll : ConstValue.kEdit,
            ),
          ],
        ));
  }
}
