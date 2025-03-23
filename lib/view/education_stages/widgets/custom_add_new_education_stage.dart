import 'dart:io';

import 'package:drosak_mangment_app/core/resources/fonts_manger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../core/resources/assets_values_manger.dart';
import '../../../core/resources/colors_manger.dart';
import '../../../core/resources/const_values.dart';
import '../../../core/resources/provider/educatoin_stages.dart';
import '../../../core/resources/widgets/spaces/horizontal_vertical_space.dart';
import '../../../core/widgets/buttons/custom_material_bottun.dart';
import '../../../core/widgets/inputField/custom_text_form_field.dart';
import '../../../core/widgets/image_source/build_image_source_button.dart';

class CustomAddNewEducationalStage extends StatefulWidget {
  const CustomAddNewEducationalStage({
    super.key,
    required this.onPressedAdd,
    required this.formKey,  this.isAdd = true, required this.onPressedEdit,
  });

  final VoidCallback onPressedAdd;
  final VoidCallback onPressedEdit;
  final bool isAdd;
  final GlobalKey<FormState> formKey;

  @override
  State<CustomAddNewEducationalStage> createState() =>
      _CustomAddNewEducationalStageState();
}

class _CustomAddNewEducationalStageState
    extends State<CustomAddNewEducationalStage> {
  @override
  void initState() {
    super.initState();

    /// 🔹 تحميل قائمة المراحل التعليمية عند فتح الشاشة
    final provider =
        Provider.of<EducationStagesProvider>(context, listen: false);
    provider.getAllItemList();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EducationStagesProvider>(context);

    return Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 20.h),
        decoration: BoxDecoration(
            color: ColorsManger.kBlackColor,
            borderRadius: BorderRadiusDirectional.only(
                topEnd: Radius.circular(12.r),
                topStart: Radius.circular(12.r))),
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                provider.pathImage.isNotEmpty
                    ? Stack(
                        clipBehavior: Clip.none,
                        alignment: Alignment.topRight,
                        // يجعل أيقونة X في أعلى اليمين
                        children: [
                          CircleAvatar(
                            radius: 30, // ضبط حجم الصورة
                            backgroundColor: ColorsManger.kPrimaryColor,
                            backgroundImage:
                                FileImage(File(provider.pathImage)),
                          ),
                          Positioned(
                            top: -4, // رفع الأيقونة قليلًا خارج الدائرة
                            right: -4,
                            child: GestureDetector(
                              onTap: provider.clearImage,
                              // استدعاء الوظيفة بشكل صحيح
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.red, // لون الخلفية لأيقونة X
                                ),
                                child: const Icon(Icons.close,
                                    color: Colors.white, size: 18),
                              ),
                            ),
                          ),
                        ],
                      )
                    : IconButton.filled(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorsManger.kPrimaryColor,
                        ),
                        onPressed: () {
                          showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (context) => AlertDialog(
                              backgroundColor: ColorsManger.kBlackColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              contentPadding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 15.w),
                              iconPadding: EdgeInsets.zero,
                              titlePadding: EdgeInsets.zero,
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // Header
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.close, color: ColorsManger.kWhiteColor),
                                        onPressed: () => Navigator.pop(context),
                                      ),
                                      Text(
                                        "أختر مصدر الصورة",
                                        style: TextStyle(
                                          color: ColorsManger.kWhiteColor,
                                          fontFamily: FontsName.geDinerFont,
                                          fontWeight: FontWeight.bold,
                                          fontSize: FontsSize.f16,
                                        ),
                                      ),
                                      SizedBox(width: 30.w), // For balance alignment
                                    ],
                                  ),

                                  SizedBox(height: 30.h),

                                  // Buttons Section
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      buildImageSourceButton(
                                        icon: Icons.image_outlined,
                                        label: "المعرض",
                                        onPressed: () {
                                          Navigator.pop(context);

                                          provider.pickImage(context,ImageSource.gallery);
                                        },
                                      ),
                                      buildImageSourceButton(
                                        icon: Icons.camera_alt_outlined,
                                        label: "الكاميرا",
                                        onPressed: () {
                                          Navigator.pop(context);

                                          provider.pickImage(context,ImageSource.camera);


                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );

                        },
                        icon: SvgPicture.asset(AssetsValueManger.kPlaceholder),
                      ),
                HorizontalVerticalSpace(
                  width: 6.w,
                ),
                Expanded(
                  child: Form(
                    key: widget.formKey,
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: CustomTextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return ConstValue.kCantEmpty;
                          }
                          return null;
                        },
                        hintText: ConstValue.kEducationStagesName,
                        controller:
                            provider.controllerAddNewEducationalStageName,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            HorizontalVerticalSpace(
              height: 16.h,
            ),
            CustomTextFormField(
              minLines: 1,
              hintText: ConstValue.kEducationStagesDescription,
              controller: provider.controllerAddNewEducationalStageDescription,
              maxLines: 3,
            ),

            HorizontalVerticalSpace(
              height: 40.h,
            ),
            //   image!=""?Image.file(File(image),height: 200.h,width: double.infinity,fit:BoxFit.contain ,):const SizedBox.shrink(),
            CustomMaterialButton(
              onPressed: widget.isAdd == true ?widget.onPressedAdd:widget.onPressedEdit,
              text: widget.isAdd == true ? ConstValue.kAdd : ConstValue.kEdit,
            ),

          ],
        ));
  }
}
