import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import '../../../model/education_stages/item_stages_model.dart';
import '../../../view/education_stages/widgets/custom_add_new_education_stage.dart';
import '../../../view/education_stages/widgets/custom_search_delegeate_education_stage.dart';
import '../dataBase/education_stage_operation/education_stage_operation.dart';

class EducationStagesProvider with ChangeNotifier {
  String pathImage = "";
  List<ItemStageModel> listItemStageModel = [];
  List<ItemStageModel> listSearchItemStageModel = [];

  final TextEditingController controllerAddNewEducationalStageName =
      TextEditingController();
  final TextEditingController controllerAddNewEducationalStageDescription =
      TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  final EducationStageOperation educationStageOperation =
      EducationStageOperation();

  Future<void> pickImage(BuildContext context, ImageSource source) async {
    try {
      final ImagePicker picker = ImagePicker();
      final image = await picker.pickImage(source: source);

      if (image != null) {

        await saveImageOfMyApp(image);
      }
    } catch (e) {
      debugPrint("Error picking image: $e");
    }
  }

  Future<void> saveImageOfMyApp(XFile image) async {
    Directory directory = await getApplicationDocumentsDirectory();
    String directoryPath = directory.path;
    var finalPath = "$directoryPath/${image.name}";
    File fileImage = await File(image.path).copy(finalPath);
    pathImage = fileImage.path;
    notifyListeners();
  }

  void clearImage() {
    pathImage = "";
    notifyListeners();
  }

  Future<void> getAllItemList() async {
    try {
      listItemStageModel = await educationStageOperation.getAllEducationData();
      notifyListeners();
    } catch (e) {
      debugPrint("Error fetching education stages: $e");
    }
  }

  Future<void> getAllSearchItemList({required String searchWord}) async {
    try {
      EducationStageOperation educationStageOperation =
          EducationStageOperation();
      listSearchItemStageModel = await educationStageOperation
          .getSearchWordEducationData(searchWord: searchWord);
      notifyListeners();
    } catch (e) {
      debugPrint("Error fetching education stages: $e");
    }
  }

  Future<bool> addNewEducation(BuildContext context) async {
    try {
      bool inserted = await educationStageOperation.insertEducationDetails(
        ItemStageModel(
          id: 0,
          title: controllerAddNewEducationalStageName.text,
          description: controllerAddNewEducationalStageDescription.text,
          image: pathImage,
        ),
      );

      if (inserted) {
        await getAllItemList();
        clearInputs();
        notifyListeners();
        Navigator.pop(context);
      }
      return inserted;
    } catch (e) {
      debugPrint("Error adding new education stage: $e");
      return false;
    }
  }

  Future<bool> editEducation(BuildContext context,{required int id}) async {
    try {
      bool edit = await educationStageOperation.updateEducationDetails(
        id: id,
        title: controllerAddNewEducationalStageName.text,
        description: controllerAddNewEducationalStageDescription.text,
        image: pathImage,
        createdAt:  DateTime.now().toString(),
      );

      if (edit) {
        await getAllItemList();
        clearInputs();
        notifyListeners();
        Navigator.pop(context);
      }
      return edit;
    } catch (e) {
      debugPrint("Error adding new education stage: $e");
      return false;
    }
  }

  void clearInputs() {
    pathImage = "";
    controllerAddNewEducationalStageName.clear();
    controllerAddNewEducationalStageDescription.clear();
  }

  void openBottomSheet({required BuildContext context}) {
    controllerAddNewEducationalStageDescription.clear();
    controllerAddNewEducationalStageName.clear();
    pathImage = "";
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: CustomAddNewEducationalStage(
          onPressedAdd: () async {
            if (formKey.currentState?.validate() == true) {
              await addNewEducation(context);
            }
          },
          formKey: formKey,
          onPressedEdit: () async {
            if (formKey.currentState?.validate() == true) {
              await editEducation(context, id: 0);
            }
          },
        ),
      ),
    );
  }

  void openEditBottomSheet(
      {required BuildContext context, required ItemStageModel itemStageModel}) {
    controllerAddNewEducationalStageDescription.text =
        itemStageModel.description;
    controllerAddNewEducationalStageName.text = itemStageModel.title;
    pathImage = itemStageModel.image;
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: CustomAddNewEducationalStage(
          isAdd: false,
          onPressedAdd: () async {
            if (formKey.currentState?.validate() == true) {
              await addNewEducation(context);
            }
          },
          formKey: formKey,
          onPressedEdit: () async {
            if (formKey.currentState?.validate() == true) {
              await editEducation(context, id: itemStageModel.id);
            }
          },
        ),
      ),
    );
  }

  Future<void> softDeleteFun(ItemStageModel itemStageModel) async {
    await educationStageOperation.softDeleteEducationData(
        id: itemStageModel.id);
    listItemStageModel.removeWhere(
        (item) => item.id == itemStageModel.id); // Remove from list
    listSearchItemStageModel.removeWhere(
        (item) => item.id == itemStageModel.id); // Remove from list
    notifyListeners();
  }

  Future<void> deleteFun(ItemStageModel itemStageModel) async {
    await educationStageOperation.deleteEducationData(id: itemStageModel.id);
    listItemStageModel.removeWhere(
        (item) => item.id == itemStageModel.id); // Remove from list
    listSearchItemStageModel.removeWhere(
        (item) => item.id == itemStageModel.id); // Remove from list
    notifyListeners();
  }

  @override
  void dispose() {
    controllerAddNewEducationalStageName.dispose();
    controllerAddNewEducationalStageDescription.dispose();
    super.dispose();
  }

  void showCustomSearch({required BuildContext context}) {
    showSearch(context: context, delegate: CustomSearchDelegated());
  }
}
