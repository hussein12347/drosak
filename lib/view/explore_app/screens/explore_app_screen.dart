import 'package:drosak_mangment_app/core/resources/colors_manger.dart';
import 'package:drosak_mangment_app/view/explore_app/widgets/appBar.dart';
import 'package:flutter/material.dart';


import '../../../controller/explore_app_screen/explore_app_controller.dart';
import '../widgets/body.dart';

class ExploreAppScreen extends StatefulWidget {
  const ExploreAppScreen({super.key});

  @override
  State<ExploreAppScreen> createState() => _ExploreAppScreenState();
}

class _ExploreAppScreenState extends State<ExploreAppScreen> {

  @override
  Widget build(BuildContext context) {
    return const Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: ColorsManger.kBlackColor,
        appBar: customAppBarExploreScreen(),
        body: BodyExploreScreen(),
      ),
    );
  }
}


