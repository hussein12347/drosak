import 'package:drosak_mangment_app/core/resources/const_values.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart' as sqlDatabase;

import 'crud.dart';

class MySqlDataBase extends CRUD {
  Database? _db;

  Future<Database?> getDatabase() async {
    if (_db == null || !_db!.isOpen) {
      await _initDatabase();
    }
    return _db;
  }

  Future<void> _initDatabase() async {
    String databasePath = await sqlDatabase.getDatabasesPath();
    String databaseName = "drosak.db";
    String realDatabasePath = join(databasePath, databaseName);
    int version = 1;

    _db = await sqlDatabase.openDatabase(
      realDatabasePath,
      version: version,
      onCreate: _onCreate,
      onOpen: (db) async {
      await db.execute('PRAGMA foreign_keys = ON;');  // ✅ تأكيد تفعيل المفاتيح الخارجية
    },
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    /////////////////////////educationStageTable/////////////////////////////////////
    await db.execute(
        "CREATE TABLE IF NOT EXISTS ${ConstValue.kEducationStagesTableName}(${ConstValue.kEducationStagesColumnID} INTEGER PRIMARY KEY AUTOINCREMENT, ${ConstValue.kEducationStagesColumnName} TEXT, ${ConstValue.kEducationStagesColumnCreatedAt} TIMESTAMP DEFAULT CURRENT_TIMESTAMP, ${ConstValue.kEducationStagesColumnDescription} TEXT, ${ConstValue.kEducationStagesColumnStatus} INTEGER DEFAULT 1 NOT NULL  CHECK (${ConstValue.kEducationStagesColumnStatus} IN (0,1)), ${ConstValue.kEducationStagesColumnImage} TEXT)");
    /////////////////////////GroupTable/////////////////////////////////////


    await db.execute(
        "CREATE TABLE IF NOT EXISTS ${ConstValue.kGroupTableName} ("
            "${ConstValue.kGroupColumnID} INTEGER PRIMARY KEY AUTOINCREMENT, "
            "${ConstValue.kGroupColumnEducationID} INTEGER, "
            "${ConstValue.kGroupColumnName} TEXT, "
            "${ConstValue.kGroupCreatedAt} TIMESTAMP DEFAULT CURRENT_TIMESTAMP, "
            "${ConstValue.kGroupColumnNote} TEXT, "
            "${ConstValue.kGroupStatus} INTEGER DEFAULT 1 NOT NULL CHECK (${ConstValue.kGroupStatus} IN (0,1)), "
            "${ConstValue.kGroupColumnImage} TEXT, "
            "FOREIGN KEY (${ConstValue.kGroupColumnEducationID}) REFERENCES ${ConstValue.kEducationStagesTableName} (${ConstValue.kEducationStagesColumnID}) ON DELETE CASCADE ON UPDATE CASCADE"
            ");"
    );

    /////////////////////////appointmentTable/////////////////////////////////////

    await db.execute(
        "CREATE TABLE IF NOT EXISTS ${ConstValue.kAppointmentsTableName} ("
            "${ConstValue.kAppointmentsColumnID} INTEGER PRIMARY KEY AUTOINCREMENT, "
            "${ConstValue.kAppointmentsColumGroupID} INTEGER, "
            "${ConstValue.kAppointmentsColumDay} TEXT, "
            "${ConstValue.kAppointmentsColumTime} TEXT, "
            "FOREIGN KEY (${ConstValue.kAppointmentsColumGroupID}) REFERENCES ${ConstValue.kGroupTableName} (${ConstValue.kGroupColumnID})"
            " ON DELETE CASCADE ON UPDATE CASCADE)"
    );

    /////////////////////////studentTable/////////////////////////////////////


    await db.execute(
        "CREATE TABLE IF NOT EXISTS ${ConstValue.kStudentTableName} ("
            "${ConstValue.kStudentColumnID} INTEGER PRIMARY KEY AUTOINCREMENT, "
            "${ConstValue.kStudentColumnGroupID} INTEGER, "
            "${ConstValue.kStudentColumnNote} TEXT, "
            "${ConstValue.kStudentColumnName} TEXT, "
            "${ConstValue.kStudentColumnImage} TEXT, "
            " ${ConstValue.kStudentStatus} INTEGER DEFAULT 1 NOT NULL  CHECK (${ConstValue.kStudentStatus} IN (0,1)),"
            "${ConstValue.kStudentCreatedAt} TIMESTAMP DEFAULT CURRENT_TIMESTAMP,"
            "FOREIGN KEY (${ConstValue.kStudentColumnGroupID}) REFERENCES ${ConstValue.kGroupTableName} (${ConstValue.kGroupColumnID})"
            " ON DELETE CASCADE ON UPDATE CASCADE)"
    );

    /////////////////////////payingTable/////////////////////////////////////

    await db.execute(
        "CREATE TABLE IF NOT EXISTS ${ConstValue.kPayingTableName} ("
            "${ConstValue.kPayingColumnID} INTEGER PRIMARY KEY AUTOINCREMENT, "
            "${ConstValue.kPayingColumStudentID} INTEGER, "
            "${ConstValue.kPayingColumMonth} TEXT, "
            "${ConstValue.kPayingColumIsPaid} INTEGER DEFAULT 0 CHECK(${ConstValue.kPayingColumIsPaid} IN (0,1)), "
            "FOREIGN KEY (${ConstValue.kPayingColumStudentID}) REFERENCES ${ConstValue.kStudentTableName} (${ConstValue.kStudentColumnID})"
            " ON DELETE CASCADE ON UPDATE CASCADE)"
    );


  }

  @override
  Future<bool> delete(
      {required String tableName,
      required int id,
      required String ColumnIDName}) async {
    final db = await getDatabase();
    int deleted = await db!.delete(
      tableName,
      where: "$ColumnIDName = ?",
      whereArgs: [id],
    );
    return deleted > 0;
  }

  @override
  Future<bool> insert(
      {required String tableName, required Map<String, dynamic> values}) async {
    final db = await getDatabase();
    int inserted = await db!.insert(tableName, values);
    return inserted > 0;
  }
  Future<int> insertReturnedId(
      {required String tableName, required Map<String, dynamic> values}) async {
    final db = await getDatabase();
    int inserted = await db!.insert(tableName, values);
    return inserted ;
  }

  @override
  Future<List<Map<String, Object?>>> select({required String tableName,required String? where}) async {
    final db = await getDatabase();
    // return await db!.query(tableName);
    return await db!.query(tableName,where:where);
  }

  @override
  Future<List<Map<String, Object?>>> search(
      {required String tableName, required String searchWord , }) async {
    final db = await getDatabase();
    return await db!.query(tableName,
        where: "${ConstValue.kEducationStagesColumnName} LIKE ? AND ${ConstValue.kEducationStagesColumnStatus}==1",
        whereArgs: ['%$searchWord%']);
  }

  @override
  Future<bool> update(
      {required String tableName,
      required String ColumnIDName,
      required int id,
      required Map<String, dynamic> values}) async {
    final db = await getDatabase();
    int updated = await db!.update(
      tableName,
      values,
      where: "$ColumnIDName = ?",
      whereArgs: [id],
    );
    return updated > 0;
  }

  @override
  Future<List<Map<String, Object?>>> selectUsingQuery({
    required String query,
    List<Object?>? arguments, // أضف هذا
  }) async {
    final db = await getDatabase();
    return await db!.rawQuery(query, arguments);
  }

}
