import 'package:flutter/material.dart';
import 'package:spincircle_bottom_bar/modals.dart';
import 'package:spincircle_bottom_bar/spincircle_bottom_bar.dart';

import '../../../core/resources/colors_manger.dart';
import '../../../model/main_screen/bottom_nav_bar_tab_model.dart';

class CustomBottomNavBarMainScreen extends StatelessWidget {
  const CustomBottomNavBarMainScreen({
    super.key,
    required this.listIcon,
    required this.onTap,
    required this.currentScreen,
    required this.child,
  });

  final List<BottomNavBarModel> listIcon;
  final ValueChanged<int>? onTap;
  final int currentScreen;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SpinCircleBottomBarHolder(
      bottomNavigationBar: SCBottomBarDetails(
        circleColors: [
          ColorsManger.kWhiteColor,
          Colors.amber,
          ColorsManger.kPrimaryColor,
          Colors.blueGrey.shade800,  // لمسة أزرق غامق تعطي عمقًا
        ],


        items: [
          for (int i = 0; i < listIcon.length; i++)
            SCBottomBarItem(
              icon: listIcon[i].iconData,
              title: listIcon[i].name,
              onPressed: () => onTap?.call(i),
            ),
        ],
        circleItems: [
          //Suggested Count: 3
          SCItem(icon: const Icon(Icons.add), onPressed: () {

          }),
          SCItem(icon: const Icon(Icons.quiz), onPressed: () {}),
          SCItem(icon: const Icon(Icons.map), onPressed: () {}),
        ],
        iconTheme: const IconThemeData(
          color: ColorsManger.kWhiteColor, // لون الأيقونات العادي
        ),
        activeIconTheme: const IconThemeData(
          color: ColorsManger.kPrimaryColor, // لون الأيقونة المختارة
        ),
        titleStyle: const TextStyle(
          color: ColorsManger.kWhiteColor, // لون النص العادي
        ),
        activeTitleStyle: const TextStyle(
          color: ColorsManger.kPrimaryColor, // لون النص عند التحديد
          fontWeight: FontWeight.bold,
        ),
        actionButtonDetails: SCActionButtonDetails(
          color: ColorsManger.kPrimaryColor,
          icon: const Icon(Icons.expand_less, color: Colors.black),
          elevation: 0,
        ),
        backgroundColor: ColorsManger.kGrayBottomNavBarColor,
      ),
      child: child,
    );
  }
}
