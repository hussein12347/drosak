import 'package:flutter/material.dart';

import '../../resources/colors_manger.dart';
import '../../resources/fonts_manger.dart';

AppBar buildAppBar({required int length,required String title, required BuildContext context,required Function()? openBottomSheet,required Function()? showCustomSearch}) {
  return AppBar(
    backgroundColor: ColorsManger.kPrimaryColor,
    automaticallyImplyLeading: false,
    title: Text(
      "$title ($length)",

// " (${provider.listItemStageModel.length})",

      style: TextStyle(
        fontFamily: FontsName.geDinerFont,
        fontSize: FontsSize.f20,
      ),
    ),
    actions: [
      IconButton(
        onPressed:openBottomSheet,
        icon: const Icon(Icons.add_circle_outline),
      ),
      IconButton(
        iconSize: 30,
        onPressed:showCustomSearch,
        icon: const Icon(Icons.search),
      ),
    ],
  );
}
