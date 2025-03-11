import 'package:flutter/cupertino.dart';

class HorizontalVerticalSpace extends StatelessWidget {
  const HorizontalVerticalSpace({super.key, this.width =0,  this.height = 0});
final double width;
final double height;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width:width,
      height: height,
    );
  }
}
