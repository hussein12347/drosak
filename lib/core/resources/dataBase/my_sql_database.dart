import 'package:drosak_mangment_app/core/resources/const_values.dart';
import 'package:sqflite/sqflite.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart' as sqlDatabase;

import 'crud.dart';

class MySqlDataBase extends CRUD {


  Database? _db;

  Future<Database?> _initDatabase() async {
    String databasePath = await sqlDatabase.getDatabasesPath();

    String databaseName = "drosak.db";
    String realDatabasePath = join(databasePath, databaseName);
    int version = 1;
    _db ??= await sqlDatabase.openDatabase(
      realDatabasePath,
      version: version,
      onCreate: _onCreate,
    );
    return _db;
  }

  _onCreate(Database db, int version) async {
     await db.execute(
        "CREATE TABLE IF NOT EXISTS ${ConstValue.kEducationStagesTableName}(${ConstValue.kEducationStagesColumnID} INTEGER PRIMARY KEY AUTOINCREMENT, ${ConstValue.kEducationStagesColumnName} TEXT,${ConstValue.kEducationStagesColumnDescription} TEXT,${ConstValue.kEducationStagesColumnImage} TEXT)");
  //   await db.execute(
  //       "CREATE TABLE IF NOT EXISTS $kProductTable($kProductColumnID INTEGER PRIMARY KEY AUTOINCREMENT, $kProductColumnName TEXT ,$kProductColumnPrice REAL ,$kProductColumnCount  INTEGER )");
  //   await db.execute(
  //       "CREATE TABLE IF NOT EXISTS $kSalesTable($kSalesColumnID INTEGER PRIMARY KEY AUTOINCREMENT,$kSalesColumnProductName TEXT , $kSalesColumnUsername TEXT )");

    }



  @override

  Future<bool> delete({required String tableName,required int id,required String ColumnIDName}) async {
    if (_db == null) {
      await _initDatabase(); // Initialize the database if it's not already
    }
    // TODO: implement delete
    int? deleted = await _db?.delete(
      tableName,
      where: "$ColumnIDName == $id",

    );
    await _db?.close();
    return deleted! > 0 ? true : false;
  }

  @override
  Future<bool> insert({required String tableName,required Map<String, dynamic> values}) async {
    if (_db == null) {
      await _initDatabase(); // Initialize the database if it's not already
    }

    // TODO: implement insert
    int? inserted = await _db?.insert(tableName, values);
    await _db?.close();
    return inserted! > 0 ? true : false;
  }

  @override
  Future<List<Map<String, Object?>>>  select({required String tableName}) async {
    if (_db == null) {
      await _initDatabase(); // Initialize the database if it's not already
    }

    // TODO: implement insert
    List<Map<String, Object?>>? data = await _db?.query(tableName,);
    await _db?.close();
    return data!;
  }

  @override
  Future<bool> update({required String tableName,required String ColumnIDName,required int id, required Map<String, dynamic> values}) async {
    if (_db == null) {
      await _initDatabase(); // Initialize the database if it's not already
    }
    // TODO: implement update
    int? updated = await _db?.update(
      tableName,
      values,
      where: "$ColumnIDName == $id",
    );
    await _db?.close();
    return updated! > 0 ? true : false;
  }
}