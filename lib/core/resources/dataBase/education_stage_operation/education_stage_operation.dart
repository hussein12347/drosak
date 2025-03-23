import '../../../../model/education_stages/item_stages_model.dart';
import '../../const_values.dart';
import '../my_sql_database.dart';

class EducationStageOperation extends MySqlDataBase {
  Future<bool> insertEducationDetails(ItemStageModel itemStageModel) {
    return insert(
        tableName: ConstValue.kEducationStagesTableName,
        values: itemStageModel.toJson());
  }

  Future<List<ItemStageModel>> getAllEducationData() async {
    List<ItemStageModel> listItemStageModel = [];
    List<Map<String, Object?>> data = await select(
        tableName: ConstValue.kEducationStagesTableName,
        where: "${ConstValue.kEducationStagesColumnStatus}==1");
    listItemStageModel +=
        data.map((item) => ItemStageModel.fromJson(item)).toList();
    print(listItemStageModel);

    return listItemStageModel;
  }

  Future<List<ItemStageModel>> getSearchWordEducationData(
      {required String searchWord}) async {
    List<ItemStageModel> listItemStageModel = [];
    List<Map<String, Object?>> data = await search(
        tableName: ConstValue.kEducationStagesTableName,
        searchWord: searchWord);
    listItemStageModel +=
        data.map((item) => ItemStageModel.fromJson(item)).toList();
    print("+++++++++++++++$listItemStageModel++++++++++++++++");
    return listItemStageModel;
  }

  Future<void> deleteEducationData({required int id}) async {
    await delete(
        tableName: ConstValue.kEducationStagesTableName,
        id: id,
        ColumnIDName: ConstValue.kEducationStagesColumnID);
  }

  Future<void> softDeleteEducationData({required int id}) async {
    await update(
        tableName: ConstValue.kEducationStagesTableName,
        id: id,
        ColumnIDName: ConstValue.kEducationStagesColumnID,
        values: {ConstValue.kEducationStagesColumnStatus: 0});
  }

  Future<bool> updateEducationDetails({
    required int id,
    required String title,
    required String description,
    required String image,
    required String createdAt,
  }) async {
    return update(
        tableName: ConstValue.kEducationStagesTableName,
        id: id,
        ColumnIDName: ConstValue.kEducationStagesColumnID,
        values: {
          ConstValue.kEducationStagesColumnName: title,
          ConstValue.kEducationStagesColumnDescription: description,
          ConstValue.kEducationStagesColumnImage: image,
          ConstValue.kEducationStagesColumnCreatedAt: createdAt,
        });
  }




}
