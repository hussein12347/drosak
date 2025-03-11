import 'dart:io';

import 'package:drosak_mangment_app/core/resources/const_values.dart';
import 'package:flutter/material.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/resources/routes_manager.dart';


late  String? routeName;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  routeName = await checkWhichScreen();
  runApp(const MyApp());
}

Future<String?> checkWhichScreen() async {
  String? androidVersion = await getAndroidVersion();

  if (androidVersion != null) {
    if (int.tryParse(androidVersion)! >= 12) {
      //go to custom splash
      return RoutesName.kSplashScreen;
    }
  }
  return RoutesName.kOnBoardingScreen;
}

Future<String?> getAndroidVersion() async {
  if (Platform.isAndroid) {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    return androidInfo.version.release;
  }
  return null;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(ConstValue.kWidthDesignScreen, ConstValue.kHeightDesignScreen),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: RoutesManager.routes,
        initialRoute: routeName,
      ),
    );
  }
}
