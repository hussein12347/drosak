import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../controller/explore_app_screen/explore_app_controller.dart';
import '../../../core/resources/const_values.dart';
import 'custom_container_of_name_and_image.dart';

class BodyExploreScreen extends StatefulWidget {
  const BodyExploreScreen({
    super.key,
  });

  @override
  State<BodyExploreScreen> createState() => _BodyExploreScreenState();
}

class _BodyExploreScreenState extends State<BodyExploreScreen> {
  late ExploreAppController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = ExploreAppController();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        padding: EdgeInsets.only(left: 30.w, right: 30.w, top: 30.h),
        itemCount: 5,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 138 / 108,
            crossAxisCount: 2,
            crossAxisSpacing: 39,
            mainAxisSpacing: 34),
        itemBuilder: (context, index) {
          return CustomContainerOfNameAndImage(
            name: ConstValue.listExploreName[index],
            image: ConstValue.listExploreImage[index],
            number: (index + 1).toString(),
            onTap: () {
              controller.goToMainScreen(context,index);
            },);
        }

    );
  }
}
