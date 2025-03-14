import 'package:drosak_mangment_app/core/resources/colors_manger.dart';
import 'package:drosak_mangment_app/core/resources/const_values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../controller/education_stages/educationStagesController.dart';
import '../../../core/resources/fonts_manger.dart';
import '../../../core/resources/widgets/spaces/horizontal_vertical_space.dart';
import '../widgets/custom_item_stage.dart';
import '../widgets/custom_list_view_item_stages.dart';

class EducationScreen extends StatefulWidget {
  const EducationScreen({super.key});

  @override
  State<EducationScreen> createState() => _EducationScreenState();
}

class _EducationScreenState extends State<EducationScreen> {
  @override
  late EducationStagesController _controller;

  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = EducationStagesController();
  }

  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: ColorsManger.kPrimaryColor,
            automaticallyImplyLeading: false,
            title: Text(
              ConstValue.kEducationStages,
              style: TextStyle(
                fontFamily: FontsName.geDinerFont,
                fontSize: FontsSize.f20,
              ),
            ),
            actions: [
              IconButton(
                iconSize: 30,
                onPressed: () {},
                icon: const Icon(Icons.search),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.add_circle_outline),
              ),
            ],
          ),
          body: CustomListViewItemStages(listItemStageModel: _controller.listItemStageModel,)),
    );
  }
}
