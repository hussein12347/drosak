import '../../../../model/groups/item_groub_model.dart';
import '../../../../model/groups/time_day_group_model.dart';
import '../../const_values.dart';
import '../my_sql_database.dart';

class GroupOperation extends MySqlDataBase {
  Future<List<ItemGroupModel>> getAllGroupData() async {
    List<ItemGroupModel> listItemGroupModel = [];
    List<Map<String, Object?>> data =
        await selectUsingQuery(query: 'SELECT ${ConstValue.kGroupTableName}.* FROM ${ConstValue.kGroupTableName} , ${ConstValue.kEducationStagesTableName} WHERE ${ConstValue.kEducationStagesTableName}.${ConstValue.kEducationStagesColumnStatus } = 1 AND ${ConstValue.kEducationStagesTableName}.${ConstValue.kEducationStagesColumnID} = ${ConstValue.kGroupColumnEducationID}');
    listItemGroupModel +=
        data.map((item) => ItemGroupModel.fromJson(item)).toList();
    print(listItemGroupModel);

    return listItemGroupModel;
  }

  Future<List<ItemGroupModel>> getSearchWordGroupData(
      {required String searchWord}) async {
    List<ItemGroupModel> listItemGroupModel = [];
    List<Map<String, Object?>> data =
    await selectUsingQuery(
      query: '''
    SELECT ${ConstValue.kGroupTableName}.*
    FROM ${ConstValue.kGroupTableName}, ${ConstValue.kEducationStagesTableName}
    WHERE ${ConstValue.kEducationStagesTableName}.${ConstValue.kEducationStagesColumnStatus} = 1
    AND ${ConstValue.kEducationStagesTableName}.${ConstValue.kEducationStagesColumnID} = ${ConstValue.kGroupTableName}.${ConstValue.kGroupColumnEducationID}
    AND ${ConstValue.kGroupTableName}.${ConstValue.kGroupColumnName} LIKE ? 
  ''',
      arguments: ['%$searchWord%'],
    );

    listItemGroupModel +=
        data.map((item) => ItemGroupModel.fromJson(item)).toList();
    print(listItemGroupModel);

    return listItemGroupModel;
  }


  // Future<List<ItemGroupModel>> getSearchWordGroupData(
  //     {required String searchWord}) async {
  //   List<ItemGroupModel> listItemStageModel = [];
  //   List<Map<String, Object?>> data = await search(
  //       tableName: ConstValue.kGroupTableName,
  //       searchWord: searchWord);
  //   listItemStageModel +=
  //       data.map((item) => ItemGroupModel.fromJson(item)).toList();
  //   print("+++++++++++++++$listItemStageModel++++++++++++++++");
  //   return listItemStageModel;
  // }

  Future<List<TimeDayGroupModel>> getAllGroupTableData() async {
    List<TimeDayGroupModel> listTimeDayGroupModel = [];
    List<Map<String, Object?>> data = await select(
        tableName: ConstValue.kAppointmentsTableName, where: 'TRUE');
    listTimeDayGroupModel +=
        data.map((item) => TimeDayGroupModel.fromJson(item)).toList();
    print(listTimeDayGroupModel);

    return listTimeDayGroupModel;
  }

  Future<int> insertGroupDetails(ItemGroupModel itemGroupModel) {
    return insertReturnedId(
        tableName: ConstValue.kGroupTableName, values: itemGroupModel.toJson());
  }

  Future<bool> insertGroupDetailsReturnId(ItemGroupModel itemGroupModel) {
    return insert(
        tableName: ConstValue.kGroupTableName, values: itemGroupModel.toJson());
  }

  Future<bool> insertGroupTableDetails(
      TimeDayGroupModel itemTimeDayGroupModel, int groupId) {
    return insert(
        tableName: ConstValue.kAppointmentsTableName,
        values: itemTimeDayGroupModel.toJson(groupId));
  }

  Future<void> deleteGroupData({required int id}) async {
    await delete(
        tableName: ConstValue.kGroupTableName,
        id: id,
        ColumnIDName: ConstValue.kGroupColumnID);
  }

  // Future<bool> updateGroupTableDetails({
  //   required int id,
  //   required String day,
  //   required String time,
  // }) async {
  //   return update(
  //       tableName: ConstValue.kAppointmentsTableName,
  //       id: id,
  //       ColumnIDName: ConstValue.kEducationStagesColumnID,
  //       values: {
  //
  //         ConstValue.kAppointmentsColumTime: time,
  //         ConstValue.kAppointmentsColumDay: day,
  //       });
  // }

  Future<void> deleteGroupTableData({required int id}) async {
    await delete(
        tableName: ConstValue.kAppointmentsTableName,
        id: id,
        ColumnIDName: ConstValue.kAppointmentsColumnID);
  }



  Future<bool> updateGroupDetails({
    required int id,
    required int educationId,
    required String title,
    required String description,
    required String createdAt,
  }) async {
    return update(
        tableName: ConstValue.kGroupTableName,
        id: id,
        ColumnIDName: ConstValue.kGroupColumnID,
        values: {
          ConstValue.kGroupColumnName: title,
          ConstValue.kGroupColumnEducationID: educationId,
          ConstValue.kGroupColumnNote: description,
          ConstValue.kGroupCreatedAt: createdAt,
        });
  }
  Future<List<Map<String, Object?>>> getGroupInnerJoinEducationStage(int educationId) async {
    var a = await selectUsingQuery(
        query: "SELECT ${ConstValue.kGroupTableName}.*  FROM ${ConstValue.kGroupTableName} INNER JOIN ${ConstValue.kEducationStagesTableName} ON ${ConstValue.kGroupTableName}.${ConstValue.kGroupColumnEducationID} = ${ConstValue.kEducationStagesTableName}.${ConstValue.kEducationStagesColumnID} AND ${ConstValue.kGroupTableName}.${ConstValue.kGroupColumnEducationID} = $educationId"
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

  Future<List<Map<String, Object?>>> getAppointmentJoinGroupStage(int groupId) async {
    var a = await selectUsingQuery(
        query: "SELECT ${ConstValue.kAppointmentsTableName}.*  FROM ${ConstValue.kAppointmentsTableName} INNER JOIN ${ConstValue.kGroupTableName} ON ${ConstValue.kGroupTableName}.${ConstValue.kGroupColumnID} = ${ConstValue.kAppointmentsTableName}.${ConstValue.kAppointmentsColumGroupID} AND ${ConstValue.kAppointmentsTableName}.${ConstValue.kAppointmentsColumGroupID} = $groupId"
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

}
