import 'package:drosak_mangment_app/core/resources/colors_manger.dart';
import 'package:drosak_mangment_app/core/resources/const_values.dart';
import 'package:flutter/material.dart';

import '../../../core/resources/fonts_manger.dart';

class EducationScreen extends StatelessWidget {
  const EducationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorsManger.kPrimaryColor,
          automaticallyImplyLeading: false,
          title:  Text(ConstValue.kEducationStages,style: TextStyle(fontFamily: FontsName.geDinerFont,fontSize: FontsSize.f20,),),
          actions: [
            IconButton(
              iconSize: 30,
              onPressed: () {},
              icon: Icon(Icons.search),
            ),
            IconButton(

              onPressed: () {},
              icon: Icon(Icons.add_circle_outline),
            ),


          ],
        ),
      ),
    );
  }
}
