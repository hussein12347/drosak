// import 'dart:async';
//
// import 'package:drosak_mangment_app/core/resources/assets_values_manger.dart';
// import 'package:drosak_mangment_app/core/resources/colors_manger.dart';
// import 'package:drosak_mangment_app/core/resources/const_values.dart';
// import 'package:drosak_mangment_app/core/resources/fonts_manger.dart';
// import 'package:drosak_mangment_app/core/resources/widgets/spaces/horizontal_vertical_space.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:image_picker/image_picker.dart';
//
// import '../../core/resources/dataBase/education_stage_operation/education_stage_operation.dart';
// import '../../core/resources/dataBase/my_sql_database.dart';
// import '../../core/widgets/buttons/custom_material_bottun.dart';
// import '../../core/widgets/inputField/custom_text_form_field.dart';
// import '../../model/education_stages/item_stages_model.dart';
// import '../../view/education_stages/widgets/custom_add_new_groubs.dart';
//
// class EducationStagesController {
//   List<ItemStageModel> listItemStageModel = [];
//   TextEditingController controllerAddNewEducationalStageName =
//       TextEditingController();
//   TextEditingController controllerAddNewEducationalStageDescription =
//       TextEditingController();
//   EducationStageOperation educationStageOperation = EducationStageOperation();
//
//   String pathImage = "";
//   late StreamController<List<ItemStageModel>> controllerListItemStageModel;
//   late Sink<List<ItemStageModel>> inputDataListItemStageModel;
//   late Stream<List<ItemStageModel>> outputDataListItemStageModel;
//
//   late StreamController<String?> controllerPathImage;
//   late Sink<String?> inputDataPathImage;
//   late Stream<String?> outputDataPathImage;
//
//   EducationStagesController() {
//     init();
//     initControllers();
//   }
//
//   void initControllers() {
//     controllerListItemStageModel = StreamController();
//     inputDataListItemStageModel = controllerListItemStageModel.sink;
//     outputDataListItemStageModel = controllerListItemStageModel.stream;
//     inputDataListItemStageModel.add(listItemStageModel);
//     //////////////////////////////////////////////
//     controllerPathImage = StreamController();
//     inputDataPathImage = controllerPathImage.sink;
//     outputDataPathImage = controllerPathImage.stream;
//     inputDataPathImage.add(pathImage);
//     /////////////////////////////////////////
//   }
//
//   void disposeControllers() {
//     inputDataListItemStageModel.close();
//     controllerListItemStageModel.close();
//     ///////////////////////////////////
//     inputDataPathImage.close();
//     controllerPathImage.close();
//     ///////////////////////////////////
//     controllerAddNewEducationalStageName.dispose();
//     controllerAddNewEducationalStageDescription.dispose();
//   }
//
//   init() async {
//     getAllItemList();
//
//     print(listItemStageModel);
//   }
//   Future<void> getAllItemList() async {
//     EducationStageOperation educationStageOperation = EducationStageOperation();
//     listItemStageModel = await educationStageOperation.getAllEducationData();
//     inputDataListItemStageModel.add(listItemStageModel);
//
//   }
//
//   void openBottomSheet({required BuildContext context}) {
//     showModalBottomSheet(
//       isScrollControlled: true,
//       context: context,
//       builder: (context) => Padding(
//         padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
//         child: CustomAddNewEducationalStage(
//           controllerAddNewEducationalStageName: controllerAddNewEducationalStageName,
//           controllerAddNewEducationalStageDescription: controllerAddNewEducationalStageDescription,
//           onPressedAdd: () async {
//             bool inserted = await addNewEducation();
//             if (inserted) {
//               pathImage = "";
//               controllerAddNewEducationalStageName.clear();
//               controllerAddNewEducationalStageDescription.clear();
//               getAllItemList(); // إعادة تحميل البيانات بعد الإضافة
//               Navigator.pop(context);
//             }
//           },
//           image: pathImage,
//         ),
//       ),
//     );
//   }
//
//   onPressedDeleteImage() {
//     pathImage = "";
//     inputDataPathImage.add(pathImage); // تحديث الـ Stream
//   }
//
//   Future<bool> addNewEducation() async {
//     bool inserted = await educationStageOperation.insertEducationDetails(
//         ItemStageModel(
//             id: 0,
//             title: controllerAddNewEducationalStageName.text,
//             description: controllerAddNewEducationalStageDescription.text,
//             image: pathImage));
//
//     if (inserted) {
//       await getAllItemList(); // تحديث القائمة بعد الإضافة
//     }
//     return inserted;
//   }
//
//
//   void pickImageFromGallery() async {
//     final ImagePicker picker = ImagePicker();
// // Pick an image.
//     var image = await picker.pickImage(source: ImageSource.gallery);
//     if (image != null) {
//       pathImage = image.path;
//       inputDataPathImage.add(pathImage); // تحديث الـ Stream
//     }
//     void pickImageFromCamera() async {
//       final ImagePicker picker = ImagePicker();
// // Pick an image.
//       var image = await picker.pickImage(source: ImageSource.camera);
//       if (image != null) {
//         pathImage = image.path;
//         inputDataPathImage.add(pathImage);
//       }
// // Capture a photo.
// //           final XFile? photo = await picker.pickImage(source: ImageSource.camera);
//     }
//   }
// }
