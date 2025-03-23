
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:drosak_mangment_app/model/education_stages/item_stages_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/resources/colors_manger.dart';
import '../../../core/resources/const_values.dart';
import '../../../core/resources/fonts_manger.dart';
import '../../../core/resources/widgets/spaces/horizontal_vertical_space.dart';

class CustomSelectEducationStageAddNewGroup extends StatelessWidget {
  const CustomSelectEducationStageAddNewGroup({
    super.key,
    required this.listItemStageModel,
    required this.onChange,  this.isEdit =false, this.educationID,
  });

  final List<ItemStageModel> listItemStageModel;
  final Function(ItemStageModel?)? onChange;
  final bool isEdit;
  final int? educationID;

  @override
  Widget build(BuildContext context) {
    return Row(
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
            initialItem:isEdit?listItemStageModel.where((element) => element.id==educationID).first :null,

              noResultFoundText: "لا توجد مرحلة تعليمية بهذا الاسم",
              hintText: ConstValue.kChooseEducationStage,
              items: listItemStageModel,
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
                      child: Text((listItemStageModel
                                  .indexWhere((element) => element == item) +
                              1)
                          .toString()),
                    ),
                  ),
              onChanged: onChange, futureRequest: (String query) async {
          return await Future.delayed(const Duration(milliseconds: 300), () {
          return listItemStageModel
              .where((stage) => stage.title.toLowerCase().contains(query.toLowerCase()))
              .toList();
          });
          },),
        ))
      ],
    );
  }
}
