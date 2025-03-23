
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:drosak_mangment_app/model/education_stages/item_stages_model.dart';
import 'package:drosak_mangment_app/model/groups/item_groub_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/resources/colors_manger.dart';
import '../../../core/resources/const_values.dart';
import '../../../core/resources/fonts_manger.dart';
import '../../../core/resources/widgets/spaces/horizontal_vertical_space.dart';

class CustomSelectGroupAddNewStudent extends StatelessWidget {
  const CustomSelectGroupAddNewStudent({
    super.key,
    required this.listItemGroupModel,
    required this.onChangeGroup,  this.isEdit =false, required this.listItemEducationModel, required this.onChangeEducation, required this.initialGroupItem, this.initialStageItem,
  });

  final List<ItemStageModel> listItemEducationModel;
  final List<ItemGroupModel> listItemGroupModel;
  final Function(ItemGroupModel?)? onChangeGroup;
  final Function(ItemStageModel?)? onChangeEducation;
  final bool isEdit;
  final ItemGroupModel? initialGroupItem ;
  final ItemStageModel? initialStageItem ;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          textDirection: TextDirection.rtl,
          children: [
            Text(
              ConstValue.kEducation,
              style: TextStyle(
                  color: ColorsManger.kPrimaryColor,
                  fontSize: FontsSize.f14,
                  fontFamily: FontsName.geDinerFont),
            ),
            HorizontalVerticalSpace(
              width: 12.w,
            ),
            Expanded(
                child: Directionality(
              textDirection: TextDirection.rtl,
              child: CustomDropdown<ItemStageModel>.searchRequest(
                initialItem:initialStageItem,

                  noResultFoundText: "لا توجد مرحلة تعليمية بهذا الاسم",
                  hintText: ConstValue.kChooseEducationStage,
                  items: listItemEducationModel,
                  itemsListPadding: EdgeInsets.zero,
                  headerBuilder: (context, selectedItem, enabled) => Text(
                    maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        selectedItem.title,
                        style: TextStyle(
                            fontSize: FontsSize.f14,
                            fontFamily: FontsName.geDinerFont),
                      ),
                  listItemBuilder: (context, item, isSelected, onItemSelect) =>
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          item.title,
                          style: TextStyle(
                              fontSize: FontsSize.f14,
                              fontFamily: FontsName.geDinerFont),
                        ),
                        subtitle: item.description.isNotEmpty?Text(
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          item.description,
                          style: TextStyle(
                              fontSize: FontsSize.f14,
                              fontFamily: FontsName.geDinerFont),
                        ):null,
                        leading: CircleAvatar(
                          child: Text((listItemEducationModel
                                      .indexWhere((element) => element == item) +
                                  1)
                              .toString()),
                        ),
                      ),
                  onChanged: onChangeEducation, futureRequest: (String query) async {
              return await Future.delayed(const Duration(milliseconds: 300), () {
              return listItemEducationModel
                  .where((stage) => stage.title.toLowerCase().contains(query.toLowerCase()))
                  .toList();
              });
              },),
            ))
          ],
        ),
        HorizontalVerticalSpace(height: 15.h,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          textDirection: TextDirection.rtl,
          children: [
            Text(
              ConstValue.kGroups,
              style: TextStyle(
                  color: ColorsManger.kPrimaryColor,
                  fontSize: FontsSize.f14,
                  fontFamily: FontsName.geDinerFont),
            ),
            HorizontalVerticalSpace(
              width: 12.w,
            ),
            Expanded(
                child: Directionality(
              textDirection: TextDirection.rtl,
              child: CustomDropdown<ItemGroupModel>.searchRequest(
                initialItem:initialGroupItem,

                  noResultFoundText: "لا توجد مجموعة بهذا الاسم",
                  hintText: ConstValue.kChooseGroup,
                  items: listItemGroupModel,
                  itemsListPadding: EdgeInsets.zero,
                  headerBuilder: (context, selectedItem, enabled) => Text(
                    maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        selectedItem.title,
                        style: TextStyle(
                            fontSize: FontsSize.f14,
                            fontFamily: FontsName.geDinerFont),
                      ),
                  listItemBuilder: (context, item, isSelected, onItemSelect) =>
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          item.title,
                          style: TextStyle(
                              fontSize: FontsSize.f14,
                              fontFamily: FontsName.geDinerFont),
                        ),
                        subtitle: item.notes.isNotEmpty?Text(
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          item.notes,
                          style: TextStyle(
                              fontSize: FontsSize.f14,
                              fontFamily: FontsName.geDinerFont),
                        ):null,
                        leading: CircleAvatar(
                          child: Text((listItemGroupModel
                                      .indexWhere((element) => element == item) +
                                  1)
                              .toString()),
                        ),
                      ),
                  onChanged: onChangeGroup, futureRequest: (String query) async {
              return await Future.delayed(const Duration(milliseconds: 300), () {
              return listItemGroupModel
                  .where((stage) => stage.title.toLowerCase().contains(query.toLowerCase()))
                  .toList();
              });
              },),
            ))
          ],
        ),
        HorizontalVerticalSpace(height: 15.h,),

      ],
    );
  }
}
