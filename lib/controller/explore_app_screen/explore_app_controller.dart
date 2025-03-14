import 'package:drosak_mangment_app/core/resources/const_values.dart';
import 'package:drosak_mangment_app/core/resources/routes_manager.dart';
import 'package:flutter/material.dart';

import '../../view/main_screen/screen/main_screen.dart';
class ExploreAppController{
  void goToMainScreen(BuildContext context,int index) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) =>MainScreen( index: index,),));
  }}