import 'dart:async';

import 'package:flutter/material.dart';

import '../../core/resources/routes_manager.dart';

class SplashScreenController{
  late AnimationController _animationController;
  late Animation<Offset> animationBottom;
  late Animation<Offset>animationTop;
  
  final BuildContext context;
  final TickerProvider vsync;
  SplashScreenController({required this.vsync,required this.context,}){
    initController();
  }
  void initController(){
    startAnimation();
  }

  void disposeController(){
  _animationController.dispose();

}

  void startAnimation() {
       _animationController =
    AnimationController(duration: const Duration(seconds: 2), vsync: vsync)..addStatusListener((status) {
      if(status==AnimationStatus.completed){
        Timer(const Duration(seconds: 2), () {
          goToOnBoardingScreen();
        });
      }
    });
    animationBottom = Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
        .animate(CurvedAnimation(
        parent: _animationController, curve: Curves.easeInOut));
    animationTop = Tween<Offset>(begin: const Offset(0, -1), end: Offset.zero)
        .animate(CurvedAnimation(
        parent: _animationController, curve: Curves.easeInOut));
    _animationController.forward();
  }

  void goToOnBoardingScreen() {
       Navigator.pushReplacementNamed(context,RoutesName.kOnBoardingScreen );
  }
}