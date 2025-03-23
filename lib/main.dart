import 'dart:io';
import 'package:drosak_mangment_app/core/resources/colors_manger.dart';
import 'package:drosak_mangment_app/core/resources/const_values.dart';
import 'package:drosak_mangment_app/core/resources/provider/educatoin_stages.dart';
import 'package:drosak_mangment_app/core/resources/provider/groups.dart';
import 'package:flutter/material.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'core/resources/provider/students_provider.dart';
import 'core/resources/routes_manager.dart';

late String? routeName;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  routeName = await checkWhichScreen();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => EducationStagesProvider()), // تسجيل المزود
        ChangeNotifierProvider(create: (_) => GroupsProvider()), // تسجيل المزود
        ChangeNotifierProvider(create: (_) => StudentsProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

Future<String?> checkWhichScreen() async {
  String? androidVersion = await getAndroidVersion();

  if (androidVersion != null) {
    if (int.tryParse(androidVersion)! >= 12) {
      // الذهاب إلى شاشة السبللاش
      return RoutesName.kSplashScreen;
    }
  }
  return RoutesName.kMainScreen;
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

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(ConstValue.kWidthDesignScreen, ConstValue.kHeightDesignScreen),
      builder: (context, child) {
        return MaterialApp(
          theme: ThemeData(
            scaffoldBackgroundColor: ColorsManger.kBlackColor,
          ),
          debugShowCheckedModeBanner: false,
          routes: RoutesManager.routes,
          initialRoute: routeName,
        );
      },
    );
  }
}
