import 'dart:io';

import 'package:drosak_mangment_app/core/resources/const_values.dart';
import 'package:drosak_mangment_app/core/resources/dataBase/groups_operation/group_operation.dart';
import 'package:drosak_mangment_app/model/education_stages/item_stages_model.dart';
import 'package:drosak_mangment_app/model/groups/item_groub_model.dart';
import 'package:drosak_mangment_app/model/groups/time_day_group_model.dart';
import 'package:drosak_mangment_app/model/student_model/student_model.dart';
import 'package:drosak_mangment_app/view/paying/widgets/custom_search_delegeate_paying_students.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../../../model/student_model/pying_table_item_model.dart';
import '../../../view/students/widgets/custom_add_new_student.dart';
import '../../../view/students/widgets/custom_edit_student.dart';
import '../../../view/students/widgets/custom_search_delegeate_students.dart';
import '../colors_manger.dart';
import '../dataBase/student_operation/student_operation.dart';

class StudentsProvider with ChangeNotifier{
  final TextEditingController controllerAddNewGroupName =
  TextEditingController();
  final TextEditingController controllerAddNewGroupNote =
  TextEditingController();
  List<ItemStudentModel> listItemStudentModel = [];
  List<ItemStudentModel> listItemStudentModelSelectedByGroup = [];
  List<PayingTableItemModel> listPayingTableItemModel = [];
  List<ItemGroupModel> listItemGroupModel = [];
  List<TimeDayGroupModel> listTimeDayGroupModel = [];
  List<ItemStudentModel> listSearchItemStudentModel = [];
  List<ItemStudentModel> listSearchPayingItemStudentModel = [];
  ItemGroupModel? selectedGroup;
  ItemGroupModel? selectedPayingGroup;
  ItemStageModel? selectedEducation;
  ItemStageModel? selectedPayingEducation;
  String pathImage = "";

  final StudentOperation studentOperation = StudentOperation();

  GlobalKey<FormState> formKey = GlobalKey();


  Future<void> getAllSearchItemList({required String searchWord}) async {
    try {

      listSearchItemStudentModel = await studentOperation
          .getSearchWordStudentData(searchWord: searchWord);
      notifyListeners();
    } catch (e) {
      debugPrint("Error fetching education stages: $e");
    }
  }
  Future<void> getAllSearchPayingItemList({required String searchWord,required int groupID,}) async {
    try {

      listSearchPayingItemStudentModel = await studentOperation
          .getSearchWordPayingStudentData(searchWord: searchWord, groupID:groupID, );

      notifyListeners();
    } catch (e) {
      debugPrint("Error fetching education stages: $e");
    }
  }

  void clearInputs() {
    pathImage = "";
    listTimeDayGroupModel=[];
    listItemStudentModelSelectedByGroup=[];
    controllerAddNewGroupName.clear();
    controllerAddNewGroupNote.clear();
    selectedGroup=null;
    selectedEducation=null;
    listItemGroupModel=[];
    notifyListeners();
  }
  void clearImage() {
    pathImage = "";
    notifyListeners();
  }
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

  onChangeSelectGroup(ItemGroupModel? itemGroupModel  ) async {

    selectedGroup = itemGroupModel;

    if(selectedGroup!=null){
      selectedPayingGroup = selectedGroup;
      GroupOperation groupOperation=GroupOperation();
      var data = await groupOperation.getAppointmentJoinGroupStage(selectedGroup!.id);
      listTimeDayGroupModel=[];
      listTimeDayGroupModel +=
          data.map((item) => TimeDayGroupModel.fromJson(item)).toList();
      notifyListeners();

    }
  }
  onChangeSelectStudentByGroup(ItemGroupModel? itemGroupModel  ) async {

    selectedGroup = itemGroupModel;

    if(selectedGroup!=null){
      selectedPayingGroup = selectedGroup;


      var data = await studentOperation.getStudentJoinGroupStage(selectedGroup!.id);
      listItemStudentModelSelectedByGroup=[];
      listItemStudentModelSelectedByGroup +=
          data.map((item) => ItemStudentModel.fromJson(item)).toList();
      notifyListeners();

    }
    selectedGroup=null;
  }
  onChangeSelectEducation(ItemStageModel? itemStageModel ) async {
    selectedEducation = itemStageModel;
    if (selectedEducation!=null) {

      selectedPayingEducation=selectedEducation;
      GroupOperation groupOperation=GroupOperation();

      var data=  await groupOperation.getGroupInnerJoinEducationStage(itemStageModel!.id);
      listItemGroupModel=[];
      listItemGroupModel +=
          data.map((item) => ItemGroupModel.fromJson(item)).toList();
      listTimeDayGroupModel=[];
      listItemStudentModelSelectedByGroup=[];
      notifyListeners();

    // listItemGroupMode.where((element) => element.education_id==itemStageModel!.id).toList();
    }


  }

  Future<bool> addNewStudent({required BuildContext context}) async {
    if (selectedGroup != null && selectedEducation !=null&&(selectedGroup!.education_id==selectedEducation!.id) ) {
      try {
        print(selectedGroup);
        print(selectedEducation);
        int insertedGroup = await studentOperation.insertStudentDetails(
          ItemStudentModel(
            id: 0,
            title: controllerAddNewGroupName.text,
            notes: controllerAddNewGroupNote.text,
            image: pathImage,
            groupId: selectedGroup!.id,
          ),
        );
        for (var item in ConstValue.listMonths) {
          bool insertedTable =
          await studentOperation.insertPayingTableDetails(PayingTableItemModel(id: 0, month: item, isPaid: 0), insertedGroup);
          print(item);
          if (insertedTable == false) {
            break;
          }
        }
        if (insertedGroup > 0) {
          await getAllItemList();
          clearInputs();
          notifyListeners();
          Navigator.pop(context);
        }
        return insertedGroup > 0;
      } catch (e) {
        debugPrint("Error adding new group: $e");
        return false;
      }
    } else {
      Fluttertoast.showToast(
        msg: "يرجى اختيار المرحلة التعليمية و المجموعة!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );

      return false;
    }
  }
  Future<bool> updateStudent({required ItemGroupModel?  selectedGroup,required ItemStageModel?  selectedEducation    ,required BuildContext context,required int id}) async {
    if (selectedGroup != null && selectedEducation !=null&&(selectedGroup.education_id==selectedEducation.id) ) {
      try {
        print(selectedGroup);
        print(selectedEducation);
        bool editedStudent = await studentOperation.updateStudentDetails(
           id: id, groupId: selectedGroup.id, title: controllerAddNewGroupName.text, image: pathImage, description:controllerAddNewGroupNote.text ,
          createdAt: DateTime.now().toString(),

        );



        if (editedStudent) {
          await getAllItemList();
          clearInputs();
          notifyListeners();
          Navigator.pop(context);
        }
        return editedStudent;
      } catch (e) {
        debugPrint("Error adding new group: $e");
        return false;
      }
    } else {
      Fluttertoast.showToast(
        msg: "يرجى اختيار المرحلة التعليمية و المجموعة!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );

      return false;
    }
  }


  Future<void> deleteStudent(ItemStudentModel itemStudentModel) async {
    await studentOperation.deleteStudentData(id: itemStudentModel.id);
    listItemStudentModel.removeWhere(
            (item) => item.id == itemStudentModel.id);

    listSearchItemStudentModel.removeWhere(
            (item) => item.id == itemStudentModel.id);
    listSearchPayingItemStudentModel.removeWhere(
            (item) => item.id == itemStudentModel.id); // Remove from list

    notifyListeners();
  }
  void showCustomSearch({required BuildContext context}) {
    showSearch(context: context, delegate: CustomSearchDelegatedStudent());
  }  void showCustomPayingSearch({required BuildContext context}) {
    showSearch(context: context, delegate: CustomSearchDelegatedPayingStudent(groupID: selectedPayingGroup!.id));
  }


  Future<void> ChangePayingState(PayingTableItemModel payingTableItemModel)async {
    int isPaid=0;
    if(payingTableItemModel.isPaid==0){
      isPaid=1;
    }else if(payingTableItemModel.isPaid==1){
      isPaid=0;
    }

    bool editedPayingState = await studentOperation.updatePayingTableDetails(
        id:payingTableItemModel.id, isPaid:isPaid);
    if (editedPayingState) {
      await getAllItemPayingListOfTable(studentID: payingTableItemModel.studentId);
    }
  }




  Future<void> getAllItemList() async {
    try {
      listItemStudentModel = await studentOperation.getAllStudentData();
      notifyListeners();
    } catch (e) {
      debugPrint("Error fetching education stages: $e");
    }
  }
  Future<List<PayingTableItemModel> > getAllItemPayingListOfTable({required int studentID}) async {
    try {
      listPayingTableItemModel = await studentOperation.getAllPayingData(studentID: studentID);
      notifyListeners();
    } catch (e) {
      debugPrint("Error fetching education stages: $e");
    }
    return listPayingTableItemModel;
  }

  void openBottomSheet({required BuildContext context}) {
    clearInputs();

    showModalBottomSheet(
      backgroundColor: ColorsManger.kBlackColor,
      isScrollControlled: true,
      context: context,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.6,
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
                    child: CustomAddNewStudent(
                      formKey: formKey,
                      onPressedAdd: () async {
                        if (formKey.currentState?.validate() == true) {
                          await addNewStudent(
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





  Future<void> openEditBottomSheet({required BuildContext context,required ItemStudentModel itemStudentModel,required ItemGroupModel InitialItemGroupModel,required ItemStageModel initialStageItem , required int educationId}) async {
    clearInputs();
    controllerAddNewGroupName.text = itemStudentModel.title;
    controllerAddNewGroupNote.text = itemStudentModel.notes;
    pathImage=itemStudentModel.image;
    GroupOperation groupOperation=GroupOperation();
    var data=  await groupOperation.getAppointmentJoinGroupStage( educationId);
    listTimeDayGroupModel +=
        data.map((item) => TimeDayGroupModel.fromJson(item)).toList();

    showModalBottomSheet(
      backgroundColor: ColorsManger.kBlackColor,
      isScrollControlled: true,
      context: context,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.6,
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
                    child: CustomEditStudent(
                      isAdd: false,
                      formKey: formKey,

                        onPressedAdd: () async {
                          if (formKey.currentState?.validate() == true) {
                            await updateStudent(
                              context: context,
                              id: itemStudentModel.id, selectedGroup:InitialItemGroupModel , selectedEducation: initialStageItem,
                            );
                            await getAllItemPayingListOfTable(studentID: itemStudentModel.id);
                          }
                      },
                      onPressedEdit: () async {
                        // تنفيذ عملية التعديل
                      }, InitialItemGroupModel: InitialItemGroupModel, initialStageItem: initialStageItem,
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