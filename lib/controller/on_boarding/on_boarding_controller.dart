import 'dart:async';

import 'package:drosak_mangment_app/core/resources/const_values.dart';
import 'package:flutter/material.dart';

import '../../core/resources/duration_values_manger.dart';

class OnBoardingController {
  double currentIndex = 0.0;
  late StreamController<double> streamControllerDotIndicator;
  late Sink<double> inputDotIndicator;
  late Stream<double> outputDotIndicator;
  PageController pageControllerOnBoarding = PageController(initialPage: 0);
  OnBoardingController(){
    initController();
  }
  void initController(){
    streamControllerDotIndicator=StreamController();
    inputDotIndicator=streamControllerDotIndicator.sink;
    outputDotIndicator=streamControllerDotIndicator.stream;
    inputDotIndicator.add(currentIndex);
  }
  void disposeController(){
    streamControllerDotIndicator.close();
    inputDotIndicator.close();
  }
  void goNext(BuildContext context) {
    if(currentIndex+2>ConstValue.listOnBoardingImage.length){
      skip(context);

    }
    else {
      currentIndex++;
    }
    pageControllerOnBoarding.animateToPage(currentIndex.toInt(), duration: const Duration(seconds: DurationValuesManger.s1), curve: Curves.easeInOut);
    inputDotIndicator.add(currentIndex);


  }
  void skip(BuildContext context) {
    // Navigator.pushReplacementNamed(context, RoutesName.kExploreAppScreen);
  }
}
