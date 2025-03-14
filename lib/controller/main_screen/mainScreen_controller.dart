import 'dart:async';

import 'package:drosak_mangment_app/core/resources/assets_values_manger.dart';
import 'package:drosak_mangment_app/core/resources/routes_manager.dart';

import '../../model/main_screen/bottom_nav_bar_tab_model.dart';
import '../../view/audience/screens/audience_screen.dart';
import '../../view/education_stages/screens/eduction_screen.dart';
import '../../view/groups/screens/groups_screen.dart';
import '../../view/paying/screens/paying_screen.dart';
import '../../view/students/screens/students_screen.dart';

class MainScreenController {
  List<BottomNavBarModel> listBottomNavBarModel = [
    BottomNavBarModel(
        name: 'المراحل التعليمية',
        imageIcon: AssetsValueManger.kBottomNavBar_5,
        screen: EducationScreen()),
    BottomNavBarModel(
        name: 'المجموعات',
        imageIcon: AssetsValueManger.kBottomNavBar_4,
        screen: GroupScreen()),
    BottomNavBarModel(
        name: 'الطلاب',
        imageIcon: AssetsValueManger.kBottomNavBar_3,
        screen: StudentsScreen()),
    BottomNavBarModel(
        name: 'الحضور',
        imageIcon: AssetsValueManger.kBottomNavBar_2,
        screen: AudienceScreen()),
    BottomNavBarModel(
        name: 'الدفع',
        imageIcon: AssetsValueManger.kBottomNavBar_1,
        screen: PayingScreen()),
  ];
  int currentIndexScreen = 0;

  void onTapBottomNavBar(int index) {
    currentIndexScreen = index;
    inputDataBody.add(currentIndexScreen);
  }

  late StreamController<int> streamControllerBody;
  late Sink<int> inputDataBody;
  late Stream<int> outputDataBody;

  MainScreenController() {
    initControllers();
  }

  void initControllers() {
    streamControllerBody = StreamController<int>.broadcast();
    inputDataBody = streamControllerBody!.sink;
    outputDataBody = streamControllerBody!.stream;
    inputDataBody.add(currentIndexScreen);
  }

  void disposeController() {
    inputDataBody.close();
    streamControllerBody.close();
  }
}
