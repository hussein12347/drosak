import 'package:drosak_mangment_app/core/resources/fonts_manger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/resources/colors_manger.dart';
import '../../../model/main_screen/bottom_nav_bar_tab_model.dart';

class CustomBottomNavBarMainScreen extends StatelessWidget {
  const CustomBottomNavBarMainScreen({
    super.key,
    required this.listIcon,
    required this.onTap,
    required this.currentScreen,
  });

  final List<BottomNavBarModel> listIcon;
  final ValueChanged<int>? onTap;
  final int currentScreen;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        // تأكد من أنه ثابت

        currentIndex: currentScreen,
        onTap: onTap,
        backgroundColor: ColorsManger.kGrayBottomNavBarColor,
        selectedItemColor: ColorsManger.kPrimaryColor,
        unselectedItemColor: ColorsManger.kGrayIconColor,
        selectedLabelStyle: TextStyle(fontSize: FontsSize.f10),
        unselectedLabelStyle: TextStyle(fontSize: FontsSize.f10),
        items: [
          for (int i = 0; i < listIcon.length; i++)
            BottomNavigationBarItem(
                activeIcon: SvgPicture.asset(
                  listIcon[i].imageIcon,
                  color: ColorsManger.kPrimaryColor,
                ),

                label: listIcon[i].name,
                icon: SvgPicture.asset(listIcon[i].imageIcon))
        ],
      ),
    );
  }
}
