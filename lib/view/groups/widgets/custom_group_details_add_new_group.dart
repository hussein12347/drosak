
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/resources/const_values.dart';
import '../../../core/resources/widgets/spaces/horizontal_vertical_space.dart';
import '../../../core/widgets/inputField/custom_text_form_field.dart';

class CustomGroupDetailsAddNewGroup extends StatelessWidget {
  const CustomGroupDetailsAddNewGroup ({super.key, required this.context, required this.controllerAddNewGroupName, required this.controllerAddNewGroupDescription, required this.formKey});
final BuildContext context;
final TextEditingController controllerAddNewGroupName;
final TextEditingController controllerAddNewGroupDescription;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Form(
          key: formKey,
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: CustomTextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return ConstValue.kCantEmpty;
                }
                return null;
              },
              hintText: ConstValue.kGroupName,
              controller:
              controllerAddNewGroupName,
            ),
          ),
        ),
        HorizontalVerticalSpace(
          height: 15.h,
        ),
        CustomTextFormField(
          minLines: 1,
          hintText: ConstValue.kGroupNote,
          controller: controllerAddNewGroupDescription,
          maxLines: 3,
        ),

      ],
    );
  }
}

