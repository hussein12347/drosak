import 'package:drosak_mangment_app/controller/main_screen/mainScreen_controller.dart';
import 'package:flutter/material.dart';

import '../widgets/custom_bottom_nav_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key, required this.index});
  final int index;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late MainScreenController _controller;

  @override
  void initState() {
    super.initState();
    _controller = MainScreenController();
    _controller.currentIndexScreen = widget.index;
  }

  @override
  void dispose() {
    super.dispose();
    _controller.disposeController();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: _controller.outputDataBody,
      builder: (context, snapshot) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
              body:CustomBottomNavBarMainScreen(
                listIcon: _controller.listBottomNavBarModel,
                onTap: (int value) {
                  _controller.onTapBottomNavBar(value);
                },
                currentScreen: _controller.currentIndexScreen,
                child: _controller.listBottomNavBarModel[_controller.currentIndexScreen].screen,
              )
          ),
        );
      },
    );
  }
}
