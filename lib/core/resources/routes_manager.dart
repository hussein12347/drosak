import 'package:drosak_mangment_app/view/explore_app/explore_app_screen.dart';
import 'package:flutter/cupertino.dart';

import '../../view/on_boarding_page/screen/on_boarding_screen.dart';
import '../../view/splash_screen/screens/splash_screen.dart';

class RoutesManager{
  static Map<String,WidgetBuilder>routes={
    RoutesName.kSplashScreen:(context)=>const SplashScreen(),
    RoutesName.kOnBoardingScreen:(context)=>const OnBoardingScreen(),
    RoutesName.kExploreAppScreen:(context)=>const ExploreAppScreen(),
  };
}class RoutesName{
  static const String kSplashScreen="/kSplashScreen";
  static const String kOnBoardingScreen="/kOnBoardingScreen";
  static const String kExploreAppScreen="/kExploreAppScreen";
}