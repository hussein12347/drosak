import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/resources/colors_manger.dart';
import '../../../../core/resources/const_values.dart';

class CustomBottomNavBarOnBoardingScreen extends StatelessWidget {
  const CustomBottomNavBarOnBoardingScreen({super.key, required this.pageLength,  required this.onTapNext, required this.onTapSkip, required this.outPutDotIndicator});

  final int pageLength;
  final  VoidCallback onTapNext;
  final  VoidCallback onTapSkip;
  final Stream<double> outPutDotIndicator;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorsManger.kPrimaryColor,
      height: 39.h,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap:onTapSkip,

              child: const Text(
                ConstValue.kSkip,
                style: TextStyle(fontSize: 15, fontFamily: "ge_diner"),
              ),
            ),
            Directionality(
              textDirection: TextDirection.rtl,
              child:StreamBuilder<double>(
                stream:outPutDotIndicator ,
                builder: (context,snapshot) {
                  return DotsIndicator(
                    dotsCount: pageLength,
                    position: snapshot.data==null?0:snapshot.data!,
                    decorator: DotsDecorator(
                      color: ColorsManger.kBlackColor.withOpacity(0.3),
                      activeColor: ColorsManger.kBlackColor,
                      spacing: const EdgeInsets.symmetric(horizontal: 3.0), // Adjusts space between dots
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0), // Adds slight roundness
                      ),
                    ),
                  );
                },
              ),

            ),
            InkWell(
              onTap:onTapNext,
              child: const Text(
                ConstValue.kNext,
                style: TextStyle(fontSize: 15, fontFamily: "ge_diner"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
