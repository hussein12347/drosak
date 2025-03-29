import 'package:drosak_mangment_app/core/resources/colors_manger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../model/groups/item_groub_model.dart';
import 'custom_item_groub.dart';

class CustomListViewItemGroups extends StatelessWidget {
  const CustomListViewItemGroups({super.key, required this.listItemGroupModel, required this.onRefresh, required this.isSearch,});
final List<ItemGroupModel> listItemGroupModel;
final  RefreshCallback onRefresh;
final bool isSearch;


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
              itemCount: listItemGroupModel.length,
              itemBuilder: (context, index) {
                // final item = provider.listItemGroupModel[index];
                final item = listItemGroupModel[index];
                return CustomItemGroup(

                  number: (index + 1).toString(),
                  itemModel: item, search_update_edit_items: onRefresh, isSearch: isSearch,
                );
              },
              separatorBuilder: (_, __) => SizedBox(height: 24.h),
            ),
          ),
        );
  }
}
