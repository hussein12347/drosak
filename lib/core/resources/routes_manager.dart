import 'package:flutter/cupertino.dart';

import '../../view/splash_screen/screens/splash_screen.dart';

class RoutesManager{
  static Map<String,WidgetBuilder>routes={
    RoutesName.kSplashScreen:(context)=>const SplashScreen()
  };
}class RoutesName{
  static const String kSplashScreen="/kSplashScreen";
}