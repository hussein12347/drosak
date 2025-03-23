import 'package:flutter/cupertino.dart';

class BottomNavBarModel{
  final String name;
  final String imageIcon;
  final Widget screen;
  final IconData iconData;

  BottomNavBarModel( {required this.iconData,required this.screen, required this.name, required this.imageIcon});

}