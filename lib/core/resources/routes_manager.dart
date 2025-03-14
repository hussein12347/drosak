import 'package:drosak_mangment_app/view/audience/screens/audience_screen.dart';
import 'package:drosak_mangment_app/view/education_stages/screens/eduction_screen.dart';
import 'package:drosak_mangment_app/view/explore_app/screens/explore_app_screen.dart';
import 'package:drosak_mangment_app/view/groups/screens/groups_screen.dart';
import 'package:drosak_mangment_app/view/paying/screens/paying_screen.dart';
import 'package:drosak_mangment_app/view/students/screens/students_screen.dart';
import 'package:flutter/cupertino.dart';

import '../../view/main_screen/screen/main_screen.dart';
import '../../view/on_boarding_page/screen/on_boarding_screen.dart';
import '../../view/splash_screen/screens/splash_screen.dart';

class RoutesManager{
  static Map<String,WidgetBuilder>routes={
    RoutesName.kSplashScreen:(context)=>const SplashScreen(),
    RoutesName.kOnBoardingScreen:(context)=>const OnBoardingScreen(),
    RoutesName.kExploreAppScreen:(context)=>const ExploreAppScreen(),
    RoutesName.kMainScreen:(context)=>const MainScreen(index: 0,),
    RoutesName.kPayingScreen:(context)=>const PayingScreen(),
    RoutesName.kAudienceScreen:(context)=>const AudienceScreen(),
    RoutesName.kEducationScreen:(context)=>const EducationScreen(),
    RoutesName.kGroupsScreen:(context)=>const GroupScreen(),
    RoutesName.kStudentsScreen:(context)=>const StudentsScreen(),
  };
}class RoutesName{
  static const String kSplashScreen="/kSplashScreen";
  static const String kOnBoardingScreen="/kOnBoardingScreen";
  static const String kExploreAppScreen="/kExploreAppScreen";
  static const String kMainScreen="/kMainScreen";
  static const String kPayingScreen="/kPayingScreen";
  static const String kAudienceScreen="/kAudienceScreen";
  static const String kGroupsScreen="/kGroupsScreen";
  static const String kStudentsScreen="/kStudentsScreen";
  static const String kEducationScreen="/kEducationScreen";
}