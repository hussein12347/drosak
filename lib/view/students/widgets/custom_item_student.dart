import 'dart:io';

import 'package:drosak_mangment_app/core/resources/assets_values_manger.dart';
import 'package:drosak_mangment_app/core/resources/const_values.dart';
import 'package:drosak_mangment_app/core/resources/provider/educatoin_stages.dart';
import 'package:drosak_mangment_app/core/resources/provider/groups.dart';
import 'package:drosak_mangment_app/model/student_model/student_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../core/resources/colors_manger.dart';
import '../../../core/resources/fonts_manger.dart';
import '../../../core/resources/provider/students_provider.dart';
import '../../../core/resources/widgets/spaces/horizontal_vertical_space.dart';
import '../../../model/education_stages/item_stages_model.dart';
import '../../../model/groups/item_groub_model.dart';
import '../../../model/groups/time_day_group_model.dart';

class CustomItemStudent extends StatefulWidget {
  final ItemStudentModel itemModel;
  final String number;
  final bool isSearch;
  final VoidCallback? search_update_edit_items;

  const CustomItemStudent({
    super.key,
    required this.itemModel,
    required this.number, required this.isSearch,  this.search_update_edit_items,
  });

  @override
  State<CustomItemStudent> createState() => _CustomItemStudentState();
}

class _CustomItemStudentState extends State<CustomItemStudent> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<GroupsProvider>(context, listen: false)
          .getAllItemListOfTable();
      Provider.of<StudentsProvider>(context, listen: false)
          .getAllItemList();
      Provider.of<EducationStagesProvider>(context, listen: false)
          .getAllItemList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final EducationProvider = Provider.of<EducationStagesProvider>(context);
    final providerGroup = Provider.of<GroupsProvider>(context);
    final provider= Provider.of<StudentsProvider>(context);
    List<TimeDayGroupModel> listTimeDayGroupModel =
        providerGroup.tempListTimeDayGroupModel;
    listTimeDayGroupModel = listTimeDayGroupModel
        .where((element) => element.groupId == widget.itemModel.groupId)
        .toList();
    String stageTitle = EducationProvider.listItemStageModel
            .firstWhere(
              (stage) => providerGroup.listItemGroupModel
                  .any((group) => group.education_id == stage.id && group.id==widget.itemModel.groupId),orElse: () => ItemStageModel(id: 1, title: '', description: '', image: ''),
            )
            .title ??
        'غير معروف';

    String groupTitle = providerGroup.listItemGroupModel
        .firstWhere((element) => element.id == widget.itemModel.groupId,orElse: () => ItemGroupModel(notes: '', education_id: 1, id: 1, title: '', image: ''),)
        .title;

    return Stack(clipBehavior: Clip.none, children: [
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
          padding:
              EdgeInsets.only(right: 8.0.w, left: 8.w, top: 8.h, bottom: 8.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HorizontalVerticalSpace(
                      height: 10.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(right: 2.0.w),
                                  child: CircleAvatar(
                                    backgroundColor: ColorsManger.kWhiteColor,
                                    radius: 28.r,
                                    backgroundImage:
                                        File(widget.itemModel.image)
                                                .existsSync()
                                            ? FileImage(
                                                File(widget.itemModel.image))
                                            : const AssetImage(AssetsValueManger
                                                    .kStudentTestImage)
                                                as ImageProvider,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  widget.itemModel.title,
                                  style: TextStyle(
                                      fontFamily: FontsName.geDinerFont,
                                      fontSize: FontsSize.f16,
                                      color: ColorsManger.kWhiteColor),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        PopupMenuButton(
                          color: ColorsManger.kBlackColor,
                          itemBuilder: (context) => [
                            PopupMenuItem(
                                onTap: () async {
                                     await provider.openEditBottomSheet( context: context,itemStudentModel:widget.itemModel, educationId: providerGroup.listItemGroupModel.firstWhere((element) => element.id==widget.itemModel.groupId).education_id, InitialItemGroupModel: providerGroup.listItemGroupModel.firstWhere((element) => element.id== widget.itemModel.groupId), initialStageItem:EducationProvider.listItemStageModel.firstWhere((element) => element.id== providerGroup.listItemGroupModel.firstWhere((element) => element.id==widget.itemModel.groupId).education_id) ,);
                                     widget.isSearch? widget.search_update_edit_items:null;
                                     },
                                child: Text(
                                  ConstValue.kEdit,
                                  style: TextStyle(
                                      fontFamily: FontsName.geDinerFont,
                                      fontSize: FontsSize.f16,
                                      color: ColorsManger.kWhiteColor),
                                )),
                            PopupMenuItem(
                                onTap: () async {
                                  showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                            backgroundColor:
                                                ColorsManger.kBlackColor,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.r),
                                            ),
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    vertical: 20.h,
                                                    horizontal: 15.w),
                                            iconPadding: EdgeInsets.zero,
                                            titlePadding: EdgeInsets.zero,
                                            content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                // Header
                                                Text(
                                                  ConstValue.kDeleteSure,
                                                  style: TextStyle(
                                                    color: ColorsManger
                                                        .kWhiteColor,
                                                    fontFamily:
                                                        FontsName.geDinerFont,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: FontsSize.f16,
                                                  ),
                                                ),
                                                SizedBox(width: 30.w),

                                                SizedBox(height: 20.h),

                                                // Content
                                                Text(
                                                  ConstValue
                                                      .kStudentDeleteSure,
                                                  style: TextStyle(
                                                    color: ColorsManger
                                                        .kWhiteColor,
                                                    fontFamily:
                                                        FontsName.geDinerFont,
                                                    fontSize: FontsSize.f14,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),

                                                SizedBox(height: 30.h),

                                                // Actions
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    TextButton(
                                                      onPressed: () =>
                                                          Navigator.of(context)
                                                              .pop(false),
                                                      child: Text(
                                                        ConstValue.kNo,
                                                        style: TextStyle(
                                                          color: ColorsManger
                                                              .kWhiteColor,
                                                          fontSize:
                                                              FontsSize.f14,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                    TextButton(
                                                      onPressed: () async {
                                                        await provider
                                                            .deleteStudent(widget
                                                                .itemModel);

                                                        Navigator.of(context)
                                                            .pop(true);
                                                      },
                                                      child: Text(
                                                        ConstValue.kDelete,
                                                        style: TextStyle(
                                                          color: Colors.red,
                                                          fontSize:
                                                              FontsSize.f14,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ));
                                },
                                child: Text(
                                  ConstValue.kDelete,
                                  style: TextStyle(
                                      fontFamily: FontsName.geDinerFont,
                                      fontSize: FontsSize.f16,
                                      color: ColorsManger.kWhiteColor),
                                )),
                          ],
                          child: const Icon(
                            Icons.more_vert,
                            color: ColorsManger.kWhiteColor,
                          ),
                        ),
                      ],
                    ),
                    HorizontalVerticalSpace(
                      height: 10.h,
                    ),
                    Text(
                      "$groupTitle/  $stageTitle",
                      style: TextStyle(
                          fontFamily: FontsName.geDinerFont,
                          fontSize: FontsSize.f16,
                          color: ColorsManger.kWhiteColor),
                    ),
                    HorizontalVerticalSpace(
                      height: 10.h,
                    ),
       Table(
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
                    HorizontalVerticalSpace(
                      height: 5.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 5.0.w),
                      child: Text(
                        widget.itemModel.notes,
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
                              color: ColorsManger.kWhiteColor.withOpacity(0.6),
                            ),
                          ),
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
            child: Text(
              widget.number,
              style: const TextStyle(
                  color: ColorsManger.kBlackColor,
                  fontWeight: FontWeight.w500,
                  fontFamily: FontsName.geDinerFont),
            ),
          )),
    ]);
  }
}
