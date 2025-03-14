abstract class CRUD{
  Future<bool> insert({required String tableName,required  Map<String, dynamic> values});
  Future<bool> update({required String ColumnIDName,required String tableName,required int id, required Map<String, dynamic> values});
  Future<bool> delete({required String tableName,required int id,required String ColumnIDName});
  Future<List<Map<String, Object?>>>  select({required String tableName});

}