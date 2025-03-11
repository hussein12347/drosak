import 'package:flutter/material.dart';

import '../../../core/resources/colors_manger.dart';
import '../../../core/resources/const_values.dart';
import '../../../core/resources/fonts_manger.dart';

class customAppBarExploreScreen extends StatelessWidget implements PreferredSizeWidget {
  const customAppBarExploreScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(title: Text(ConstValue.kExplore,style: TextStyle(fontFamily: FontsName.geDinerFont,fontSize: FontsSize.f20,color: ColorsManger.kPrimaryColor,fontWeight: FontWeight.bold),) ,backgroundColor: Colors.transparent,);
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
