
import 'package:flutter/material.dart';

import '../../view/main_screen/screen/main_screen.dart';
class ExploreAppController{
  void goToMainScreen(BuildContext context,int index) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) =>MainScreen( index: index,),));
  }}