import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../resources/colors_manger.dart';
import '../../resources/fonts_manger.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key, required this.hintText, required this.controller, this.onFieldSubmitted,  this.maxLines=1, this.minLines=1, this.validator,
  });

  final String? hintText;
  final int? maxLines;
  final int? minLines;
  final TextEditingController controller;
  final ValueChanged<String>? onFieldSubmitted;
  final  FormFieldValidator<String>? validator;


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator:validator ,
      minLines:minLines ,
      maxLines: maxLines,
      textDirection: TextDirection.rtl,
      controller: controller,
      onFieldSubmitted: onFieldSubmitted,
      decoration: InputDecoration(
          hintTextDirection: TextDirection.rtl,
          // hintText: ConstValue.kEducationStagesName,
          hintText:hintText,
          hintStyle: TextStyle(
              color: ColorsManger.kGrayIconColor,
              fontFamily: FontsName.geDinerFont,
              fontSize: FontsSize.f14,
              fontWeight: FontWeight.bold),
          fillColor: ColorsManger.kWhiteColor,
          filled: true,
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(12.r))),
    );
  }
}
