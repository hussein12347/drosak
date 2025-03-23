import 'dart:async';

import 'package:drosak_mangment_app/core/resources/const_values.dart';
import 'package:drosak_mangment_app/model/groups/item_groub_model.dart';
import 'package:drosak_mangment_app/view/groups/widgets/custom_add_new_groubs.dart';
import 'package:drosak_mangment_app/view/groups/widgets/custom_search_delegeate_groubs.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../model/education_stages/item_stages_model.dart';
import '../../../model/groups/time_day_group_model.dart';
import '../../../view/groups/widgets/edit_group.dart';
import '../../widgets/close_keyboard/close_keyboard.dart';
import '../colors_manger.dart';
import '../dataBase/groups_operation/group_operation.dart';
import 'package:fluttertoast/fluttertoast.dart';

class GroupsProvider with ChangeNotifier {
  // String pathImage = "";
  String? time;
  String? day;
  ItemStageModel? selectedEducationStage;

  List<ItemGroupModel> listItemGroupModel = [];
  List<TimeDayGroupModel> listTimeDayGroupModel = [];
  List<TimeDayGroupModel> tempListTimeDayGroupModel = [];
  List<ItemGroupModel> listSearchItemGroupModel = [];
  List<ItemStageModel> listItemStageModel = [];
  final TextEditingController controllerAddNewGroupName =
      TextEditingController();
  final TextEditingController controllerAddNewGroupNote =
      TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  final GroupOperation groupOperation = GroupOperation();

  Future<void> deleteGroub(ItemGroupModel itemGroupModel) async {
    await groupOperation.deleteGroupData(id: itemGroupModel.id);
    listItemGroupModel.removeWhere(
        (item) => item.id == itemGroupModel.id); // Remove from list
    listSearchItemGroupModel.removeWhere(
        (item) => item.id == itemGroupModel.id); // Remove from list
    notifyListeners();
  }

  // void clearImage() {
  //   pathImage = "";
  //   notifyListeners();
  // }
  // Future<void> pickImage(BuildContext context, ImageSource source) async {
  //   try {
  //     final ImagePicker picker = ImagePicker();
  //     final image = await picker.pickImage(source: source);
  //
  //     if (image != null) {
  //
  //       await saveImageOfMyApp(image);
  //     }
  //   } catch (e) {
  //     debugPrint("Error picking image: $e");
  //   }
  // }
  // Future<void> saveImageOfMyApp(XFile image) async {
  //   Directory directory = await getApplicationDocumentsDirectory();
  //   String directoryPath = directory.path;
  //   var finalPath = "$directoryPath/${image.name}";
  //   File fileImage = await File(image.path).copy(finalPath);
  //   pathImage = fileImage.path;
  //   notifyListeners();
  // }

  Future<void> getAllItemList() async {
    try {
      listItemGroupModel = await groupOperation.getAllGroupData();
      notifyListeners();
    } catch (e) {
      debugPrint("Error fetching education stages: $e");
    }
  }

  Future<void> getAllSearchItemList({required String searchWord}) async {
    try {
      GroupOperation groupOperation =
      GroupOperation();
      listSearchItemGroupModel = await groupOperation
          .getSearchWordGroupData(searchWord: searchWord);
      notifyListeners();
    } catch (e) {
      debugPrint("Error fetching education stages: $e");
    }
  }


  Future<void> getAllItemListOfTable() async {
    try {
      tempListTimeDayGroupModel = await groupOperation.getAllGroupTableData();
      notifyListeners();
    } catch (e) {
      debugPrint("Error fetching education stages: $e");
    }
  }

  onChangeSelectEducationStage(ItemStageModel? itemStageModel) {

    selectedEducationStage = itemStageModel;
    notifyListeners();
  }

  onChangeDay(String? value) {
    closeKeyboard();

    if (value != null) {
      day = value;
    }
    value = null;

    notifyListeners();
  }

  void clearInputs() {
    // pathImage = "";
    listTimeDayGroupModel = [];
    controllerAddNewGroupName.clear();
    controllerAddNewGroupNote.clear();
    time = null;
    selectedEducationStage=null;
    notifyListeners();
  }

  void selectTime(BuildContext context) async {
    // time="4:33";
    // notifyListeners();
    closeKeyboard();
    TimeOfDay? timeSelected = await showTimePicker(
        barrierDismissible: false,
        cancelText: ConstValue.kNo,
        confirmText: ConstValue.kOk,
        helpText: ConstValue.kChooseTime,
        context: context,
        initialTime: TimeOfDay.now());
    if (timeSelected != null) {
      // تحويل `TimeOfDay` إلى `DateTime`
      final now = DateTime.now();
      final formattedTime =
          DateFormat('a h:mm') // وضع "صباحًا" أو "مساءً" في البداية
              .format(DateTime(now.year, now.month, now.day, timeSelected.hour,
                  timeSelected.minute))
              .replaceAll('AM', 'صباحًا - ') // تحويل AM إلى صباحًا
              .replaceAll('PM', 'مساءً - '); // تحويل PM إلى مساءً

      time = formattedTime; // تحديث قيمة الوقت
      notifyListeners(); // تحديث الواجهة
    }
  }

  void onPressedAddTimeToTable() {
    closeKeyboard();
    print("اليوم: $day, الوقت: $time");
    if (day == null || time == null || day!.isEmpty || time!.isEmpty) {
      Fluttertoast.showToast(
        msg: "يرجى اختيار اليوم والوقت!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    } else if (day!.isNotEmpty && time!.isNotEmpty) {
      addTimeAndDayToTable();
    }

    // تنفيذ العملية إذا كان day و time غير null
  }

  void addTimeAndDayToTable() {
    listTimeDayGroupModel.add(TimeDayGroupModel(day: day!, time: time!, id: 1));
    time = null;
    notifyListeners();
  }

  void onPressedDelete(int index) {
    listTimeDayGroupModel.removeAt(index);

    notifyListeners();
  }

  void clearTime() {
    time = null;
    notifyListeners();
  }

  Future<bool> addNewGroup({required BuildContext context}) async {
    if (selectedEducationStage != null && listTimeDayGroupModel.isNotEmpty) {
      try {
        print(selectedEducationStage);
        int insertedGroup = await groupOperation.insertGroupDetails(
          ItemGroupModel(
            id: 0,
            title: controllerAddNewGroupName.text,
            notes: controllerAddNewGroupNote.text,
            image: "",
            education_id: selectedEducationStage!.id,
          ),
        );
        for (var item in listTimeDayGroupModel) {
          bool insertedTable =
              await groupOperation.insertGroupTableDetails(item, insertedGroup);
          print(item);
          if (insertedTable == false) {
            break;
          }
        }

        if (insertedGroup > 0) {
          await getAllItemList();
          await getAllItemListOfTable();
          clearInputs();
          notifyListeners();
          Navigator.pop(context);
        }
        return insertedGroup > 0;
      } catch (e) {
        debugPrint("Error adding new group: $e");
        return false;
      }
    } else if (listTimeDayGroupModel.isEmpty) {
      Fluttertoast.showToast(
        msg: "يرجى إضافة عناصر إلى الجدول!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );

      return false;
    } else {
      Fluttertoast.showToast(
        msg: "يرجى اختيار المرحلة التعليمية!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );

      return false;
    }
  }


  void showCustomSearch({required BuildContext context}) {
    showSearch(context: context, delegate: CustomSearchDelegatedGroup());
  }

  Future<bool> updateGroup(
      {required BuildContext context, required int id}) async {
    if (selectedEducationStage != null && listTimeDayGroupModel.isNotEmpty) {
      try {
        bool insertedGroup = await groupOperation.updateGroupDetails(
          id: id,
          title: controllerAddNewGroupName.text,
          description: controllerAddNewGroupNote.text,
          createdAt: DateTime.now().toString(),
          educationId: selectedEducationStage!.id,
        );
        for (var item in tempListTimeDayGroupModel.where((element) => element.groupId==id)) {
          await groupOperation.deleteGroupTableData(
              id: item.id,);
          print("+++++++++++$item");
        }
        for (var item in listTimeDayGroupModel) {
          await groupOperation.insertGroupTableDetails(
               item,id);
          print("+++++++++++$item");
        }

        if (insertedGroup) {
          await getAllItemList();
          await getAllItemListOfTable();
          clearInputs();
          notifyListeners();
          Navigator.pop(context);
        }
        return insertedGroup;
      } catch (e) {
        debugPrint("Error adding new group: $e");
        return false;
      }
    } else if (listTimeDayGroupModel.isEmpty) {
      Fluttertoast.showToast(
        msg: "يرجى إضافة عناصر إلى الجدول!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );

      return false;
    } else {
      Fluttertoast.showToast(
        msg: "يرجى اختيار المرحلة التعليمية!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );

      return false;
    }
  }

  void openBottomSheet({required BuildContext context}) {
    clearInputs();
    // pathImage = "";

    showModalBottomSheet(
      backgroundColor: ColorsManger.kBlackColor,
      isScrollControlled: true,
      context: context,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.75,
        // يبدأ بملء الشاشة تقريبًا
        minChildSize: 0.2,
        // يمكن سحبه حتى 20% قبل الإغلاق
        maxChildSize: 0.9,
        // الحد الأقصى للحجم
        expand: false,
        builder: (context, scrollController) {
          return NotificationListener<DraggableScrollableNotification>(
            onNotification: (notification) {
              if (notification.extent <= 0.2) {
                // عند الوصول للحد الأدنى يغلق
                Navigator.pop(context);
                return true;
              }
              return false;
            },
            child: Column(
              children: [
                Container(
                  width: 40,
                  height: 5,
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    color: ColorsManger.kPrimaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    controller: scrollController,
                    // لتمكين التمرير داخل الـ BottomSheet
                    child: CustomAddNewGroup(
                      formKey: formKey,
                      onPressedAdd: () async {
                        if (formKey.currentState?.validate() == true) {
                          await addNewGroup(
                            context: context,
                          );
                        }
                      },
                      onPressedEdit: () async {
                        // تنفيذ عملية التعديل
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void editGroup({
    required List<TimeDayGroupModel> listTimeDayGroupModelEdit,
    required BuildContext context,
    required ItemGroupModel itemGroupModel,
  }) {
    clearInputs();
    controllerAddNewGroupName.text = itemGroupModel.title;
    controllerAddNewGroupNote.text = itemGroupModel.notes;
    listTimeDayGroupModel = listTimeDayGroupModelEdit;

    showModalBottomSheet(
      backgroundColor: ColorsManger.kBlackColor,
      isScrollControlled: true,
      context: context,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.75,
        // يبدأ بملء الشاشة تقريبًا
        minChildSize: 0.2,
        // يمكن سحبه حتى 20% قبل الإغلاق
        maxChildSize: 0.9,
        // الحد الأقصى للحجم
        expand: false,
        builder: (context, scrollController) {
          return NotificationListener<DraggableScrollableNotification>(
            onNotification: (notification) {
              if (notification.extent <= 0.2) {
                // عند الوصول للحد الأدنى يغلق
                Navigator.pop(context);
                return true;
              }
              return false;
            },
            child: Column(
              children: [
                Container(
                  width: 40,
                  height: 5,
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    color: ColorsManger.kPrimaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    controller: scrollController,
                    // لتمكين التمرير داخل الـ BottomSheet
                    child: CustomEditGroup(
                      formKey: formKey,
                      onPressedAdd: () async {
                        if (formKey.currentState?.validate() == true) {
                          await updateGroup(
                            context: context,
                            id: itemGroupModel.id,
                          );
                        }
                      },
                      onPressedEdit: () async {
                        // تنفيذ عملية التعديل
                      },
                      controllerAddNewGroupName: controllerAddNewGroupName,
                      controllerAddNewGroupDescription:
                          controllerAddNewGroupNote,
                      listTimeDayGroupModel: listTimeDayGroupModelEdit,
                      educationID: itemGroupModel.education_id,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
