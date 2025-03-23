import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/resources/const_values.dart';
import '../../../core/resources/provider/educatoin_stages.dart';
import '../../../core/widgets/app_bar/custom_app_bar.dart';
import '../widgets/custom_list_view_item_stages.dart';

class EducationScreen extends StatefulWidget {
  const EducationScreen({super.key});

  @override
  State<EducationScreen> createState() => _EducationScreenState();
}

class _EducationScreenState extends State<EducationScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<EducationStagesProvider>(context, listen: false)
          .getAllItemList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EducationStagesProvider>(context);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: buildAppBar( context: context, length: provider.listItemStageModel.length, openBottomSheet: () {
          provider.openBottomSheet(context: context);

        }, showCustomSearch: () {
          provider.showCustomSearch(context: context);
        }, title: ConstValue.kEducationStages),
        body: CustomListViewItemStages(
          itemStageModel:
          Provider.of<EducationStagesProvider>(context, listen: true)
              .listItemStageModel,
          onRefresh: () async {
            await provider.getAllItemList();
          },

        ),
      ),
    );
  }

}
