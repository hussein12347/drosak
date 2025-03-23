import 'package:drosak_mangment_app/core/resources/colors_manger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../model/education_stages/item_stages_model.dart';
import 'custom_item_stage.dart';

class CustomListViewItemStages extends StatelessWidget {
  const CustomListViewItemStages({super.key, required this.itemStageModel, required this.onRefresh,});
final List<ItemStageModel> itemStageModel;
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
              // itemCount: provider.listItemStageModel.length,
              itemCount: itemStageModel.length,
              itemBuilder: (context, index) {
                // final item = provider.listItemStageModel[index];
                final item = itemStageModel[index];
                return CustomItemStage(
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
