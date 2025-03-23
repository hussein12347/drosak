import 'package:drosak_mangment_app/model/student_model/student_model.dart';

import '../../../../model/student_model/pying_table_item_model.dart';
import '../../const_values.dart';
import '../my_sql_database.dart';

class StudentOperation extends MySqlDataBase {
  Future<int> insertStudentDetails(ItemStudentModel itemStudentModel) {
    return insertReturnedId(
        tableName: ConstValue.kStudentTableName,
        values: itemStudentModel.toJson());
  }

  Future<bool> insertPayingTableDetails(
      PayingTableItemModel itemPayingTableItemModel, int studentID) {
    return insert(
        tableName: ConstValue.kPayingTableName,
        values: itemPayingTableItemModel.toJson(studentID));
  }

  // Future<List<ItemStudentModel>> getSearchWordStudentData(
  //     {required String searchWord}) async {
  //   List<ItemStudentModel> listItemStudentModel = [];
  //   List<Map<String, Object?>> data = await search(
  //       tableName: ConstValue.kStudentTableName,
  //       searchWord: searchWord);
  //   listItemStudentModel +=
  //       data.map((item) => ItemStudentModel.fromJson(item)).toList();
  //   print("+++++++++++++++$listItemStudentModel++++++++++++++++");
  //   return listItemStudentModel;
  // }




  Future<bool> updateStudentDetails({
    required int id,
    required int groupId,
    required String title,
    required String image,
    required String description,
    required String createdAt,
  }) async {
    return update(
        tableName: ConstValue.kStudentTableName,
        id: id,
        ColumnIDName: ConstValue.kStudentColumnID,
        values: {
          ConstValue.kStudentColumnName: title,
          ConstValue.kStudentColumnGroupID: groupId,
          ConstValue.kStudentColumnNote: description,
          ConstValue.kStudentCreatedAt: createdAt,
          ConstValue.kStudentColumnImage: image,

        });
  }

  Future<bool> updatePayingTableDetails({
    required int id,
    required int isPaid,
  }) async {
    return update(
        tableName: ConstValue.kPayingTableName,
        id: id,
        ColumnIDName: ConstValue.kPayingColumnID,
        values: {

          ConstValue.kPayingColumIsPaid: isPaid,
        });
  }


  Future<List<ItemStudentModel>> getSearchWordStudentData({required String searchWord}) async {
    List<ItemStudentModel> listItemStudentModel = [];
    List<Map<String, Object?>> data =
    await selectUsingQuery(
        arguments: ['%$searchWord%'], // تمرير المتغير هنا بأمان
        query: '''
    SELECT ${ConstValue.kStudentTableName}.*
    FROM ${ConstValue.kStudentTableName}, ${ConstValue.kEducationStagesTableName}, ${ConstValue.kGroupTableName}
    WHERE ${ConstValue.kEducationStagesTableName}.${ConstValue.kEducationStagesColumnStatus} = 1
      AND ${ConstValue.kEducationStagesTableName}.${ConstValue.kEducationStagesColumnID} = ${ConstValue.kGroupTableName}.${ConstValue.kGroupColumnEducationID}
      AND ${ConstValue.kStudentTableName}.${ConstValue.kStudentColumnGroupID} = ${ConstValue.kGroupTableName}.${ConstValue.kGroupColumnID} AND ${ConstValue.kStudentTableName}.${ConstValue.kStudentColumnName} LIKE ?
  '''
    );

    listItemStudentModel +=
        data.map((item) => ItemStudentModel.fromJson(item)).toList();
    print(listItemStudentModel);

    return listItemStudentModel;
  }

  Future<List<ItemStudentModel>> getSearchWordPayingStudentData({required String searchWord, required int groupID}) async {
    List<ItemStudentModel> listItemStudentModel = [];
    List<Map<String, Object?>> data =
    await selectUsingQuery(
        arguments: ['%$searchWord%'], // تمرير المتغير هنا بأمان
        query: '''
    SELECT ${ConstValue.kStudentTableName}.*
    FROM ${ConstValue.kStudentTableName}, ${ConstValue.kEducationStagesTableName}, ${ConstValue.kGroupTableName}
    WHERE ${ConstValue.kEducationStagesTableName}.${ConstValue.kEducationStagesColumnStatus} = 1
      AND ${ConstValue.kEducationStagesTableName}.${ConstValue.kEducationStagesColumnID} = ${ConstValue.kGroupTableName}.${ConstValue.kGroupColumnEducationID}
      AND ${ConstValue.kStudentTableName}.${ConstValue.kStudentColumnGroupID} = ${ConstValue.kGroupTableName}.${ConstValue.kGroupColumnID} AND  ${ConstValue.kStudentTableName}.${ConstValue.kStudentColumnGroupID} = $groupID  AND ${ConstValue.kStudentTableName}.${ConstValue.kStudentColumnName} LIKE ?
  '''
    );

    listItemStudentModel +=
        data.map((item) => ItemStudentModel.fromJson(item)).toList();
    print(listItemStudentModel);

    return listItemStudentModel;
  }

  Future<List<PayingTableItemModel>> getAllPayingData({required int studentID}) async {
    List<PayingTableItemModel> listPayingTableItemModel = [];
    List<Map<String, Object?>> data =await selectUsingQuery(
        query: "SELECT ${ConstValue.kPayingTableName}.*  FROM ${ConstValue.kPayingTableName} INNER JOIN ${ConstValue.kStudentTableName} ON ${ConstValue.kStudentTableName}.${ConstValue.kStudentColumnID} = ${ConstValue.kPayingTableName}.${ConstValue.kPayingColumStudentID} AND ${ConstValue.kPayingTableName}.${ConstValue.kPayingColumStudentID} = $studentID"
    );
    listPayingTableItemModel +=
        data.map((item) => PayingTableItemModel.fromJson(item)).toList();
    print(listPayingTableItemModel);

    return listPayingTableItemModel;
  }
  Future<List<Map<String, Object?>>> getStudentJoinGroupStage(int groupId) async {
    var a = await selectUsingQuery(
        query: "SELECT ${ConstValue.kStudentTableName}.*  FROM ${ConstValue.kStudentTableName} INNER JOIN ${ConstValue.kGroupTableName} ON ${ConstValue.kStudentTableName}.${ConstValue.kStudentColumnGroupID} = ${ConstValue.kGroupTableName}.${ConstValue.kGroupColumnID} AND ${ConstValue.kStudentTableName}.${ConstValue.kStudentColumnGroupID} = $groupId"
    );

    // طباعة كل صف في النتيجة بشكل منسق
    print("++++++++++++++ النتائج ++++++++++++++");
    for (var row in a) {
      print("-----------------------------");
      row.forEach((key, value) {
        print("$key: $value");
      });
    }
    print("++++++++++++++++++++++++++++++++++");

    return a;
  }



    Future<List<ItemStudentModel>> getAllStudentData() async {
    List<ItemStudentModel> listItemStudentModel = [];
    List<Map<String, Object?>> data =
    await selectUsingQuery(
        query: '''
    SELECT ${ConstValue.kStudentTableName}.*
    FROM ${ConstValue.kStudentTableName}, ${ConstValue.kEducationStagesTableName}, ${ConstValue.kGroupTableName}
    WHERE ${ConstValue.kEducationStagesTableName}.${ConstValue.kEducationStagesColumnStatus} = 1
      AND ${ConstValue.kEducationStagesTableName}.${ConstValue.kEducationStagesColumnID} = ${ConstValue.kGroupTableName}.${ConstValue.kGroupColumnEducationID}
      AND ${ConstValue.kStudentTableName}.${ConstValue.kStudentColumnGroupID} = ${ConstValue.kGroupTableName}.${ConstValue.kGroupColumnID}
  '''
    );

    listItemStudentModel +=
        data.map((item) => ItemStudentModel.fromJson(item)).toList();
    print(listItemStudentModel);

    return listItemStudentModel;
  }
  Future<void> deleteStudentData({required int id}) async {
    await delete(
        tableName: ConstValue.kStudentTableName,
        id: id,
        ColumnIDName: ConstValue.kStudentColumnID);
  }


// Future<List<ItemStudentModel>> getAllStudentData() async {
  //   List<ItemStudentModel> listItemStudentModel = [];
  //   List<Map<String, Object?>> data = await select(
  //       tableName: ConstValue.kStudentTableName,
  //       where: "${ConstValue.kStudentStatus}==1");
  //   listItemStudentModel +=
  //       data.map((item) => ItemStudentModel.fromJson(item)).toList();
  //   print(listItemStudentModel);
  //
  //   return listItemStudentModel;
  // }
}
