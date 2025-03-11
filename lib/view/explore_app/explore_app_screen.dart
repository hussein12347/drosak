import 'package:drosak_mangment_app/core/resources/colors_manger.dart';
import 'package:drosak_mangment_app/core/resources/const_values.dart';
import 'package:drosak_mangment_app/core/resources/fonts_manger.dart';
import 'package:drosak_mangment_app/view/explore_app/widgets/appBar.dart';
import 'package:flutter/material.dart';

class ExploreAppScreen extends StatelessWidget {
  const ExploreAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: ColorsManger.kBlackColor,
      appBar: customAppBarExploreScreen(),
      ),
    );
  }
}

