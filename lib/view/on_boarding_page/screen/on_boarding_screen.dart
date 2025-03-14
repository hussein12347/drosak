import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../controller/on_boarding/on_boarding_controller.dart';
import '../../../core/resources/const_values.dart';
import '../widgets/body/custom_item_on_boarding_screen.dart';
import '../widgets/bottom_nav_bar/custom_bottom_nav_bar_on_boarding_screen.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key,});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  late OnBoardingController _controller;

  @override
  void initState() {
    super.initState();
    _controller=OnBoardingController();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar:CustomBottomNavBarOnBoardingScreen(pageLength:  ConstValue.listOnBoardingImage.length, onTapNext: () {
        if(_controller.currentIndex==ConstValue.listOnBoardingImage){
          _controller.disposeController();
          _controller.skip(context);
        }else{
          _controller.goNext(context);

        }


      }, onTapSkip: () {
        _controller.skip(context);
      }, outPutDotIndicator: _controller.outputDotIndicator,),
      body: SafeArea(
        child: Center(
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: PageView.builder(
                physics: const NeverScrollableScrollPhysics(), // تعطيل التمرير
                controller:_controller.pageControllerOnBoarding ,
                        itemCount: ConstValue.listOnBoardingImage.length,
                        itemBuilder: (context, index) {
              return customItemOnBoardingScreen(
                screenWidth: 343.w,
                screenHeight: 297.h,
                imagePath: ConstValue.listOnBoardingImage[index],
              );
                        },
                      ),
            )),
      ),
    );
  }
}
