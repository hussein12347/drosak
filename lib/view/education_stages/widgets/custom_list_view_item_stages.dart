import 'package:drosak_mangment_app/model/education_stages/item_stages_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../controller/education_stages/educationStagesController.dart';
import '../../../core/resources/widgets/spaces/horizontal_vertical_space.dart';
import 'custom_item_stage.dart';

class CustomListViewItemStages extends StatelessWidget {
  final List<ItemStageModel> listItemStageModel;

  const CustomListViewItemStages({
    super.key,
    required this.listItemStageModel,
  });


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 24.0.h),
      child: ListView.separated(
        clipBehavior: Clip.none,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return CustomItemStage(
            number: (index + 1).toString(),
            itemModel: listItemStageModel[index],
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return HorizontalVerticalSpace(
            height: 24.h,
          );
        },
        itemCount: listItemStageModel.length,
      ),
    );
  }
}
