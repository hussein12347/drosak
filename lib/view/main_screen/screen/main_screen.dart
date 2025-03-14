import 'package:drosak_mangment_app/controller/main_screen/mainScreen_controller.dart';
import 'package:drosak_mangment_app/core/resources/assets_values_manger.dart';
import 'package:drosak_mangment_app/core/resources/colors_manger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../model/main_screen/bottom_nav_bar_tab_model.dart';
import '../widgets/custom_bottom_nav_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key,  required this.index});
  final int index;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late MainScreenController _controller;

  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = MainScreenController();
    _controller.currentIndexScreen=widget.index;
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.disposeController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<int>(

        builder: (context, snapshot) {


          return _controller
              .listBottomNavBarModel[_controller.currentIndexScreen].screen;
        },
        stream: _controller.outputDataBody,
      ),
      bottomNavigationBar: StreamBuilder<int>(
        builder: (context,snapshot) {
          return CustomBottomNavBarMainScreen(
            listIcon: _controller.listBottomNavBarModel,
            onTap: (int value) {
              _controller.onTapBottomNavBar(value);
            },
            currentScreen: _controller.currentIndexScreen,
          );
        }, stream: _controller.outputDataBody,
      ),
    );
  }
}
