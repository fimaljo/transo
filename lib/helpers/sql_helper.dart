import 'package:sqflite/sqflite.dart';

import '../models/joined_model.dart';

class SqlHelper {
  SqlHelper._();
  static SqlHelper _instanse = SqlHelper._();
  static late Database database;
  static late Database detailsDatabase;
  static String tableName = "Transformation";
  static String secondTableName = "TransoDetails";

  //init
  static initDb() async {
    var databasesPath = await getDatabasesPath();

    String path = '$databasesPath/dbName';

    database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE $tableName ( ID INTEGER PRIMARY KEY AUTOINCREMENT, TITLE TEXT,  TARGET TEXT, CURRENT_STATUS TEXT, TOTAL_DAYS TEXT)');
    });

    String pathD = '$databasesPath/dbNam';

    detailsDatabase = await openDatabase(pathD, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE $secondTableName ( ID INTEGER PRIMARY KEY AUTOINCREMENT, CURRENT_STATUS TEXT, DAY TEXT, IMAGE_PATH TEXT, TRANSO_ID INTEGER, FOREIGN KEY (TRANSO_ID) REFERENCES Transformation(ID) ON DELETE CASCADE )');
    });
  }

  //insert

  static Future<int> insertdata(String query) async {
    return await database.rawInsert(query);
  }

  //read data
  static Future<List<Map<String, Object?>>> readData(String query) async {
    return await database.rawQuery(query);
  }

  //update data
  static Future<int> updateData(String query) async {
    return await database.rawUpdate(query);
  }

  //delete data
  static Future<int> deleteData(String query) async {
    return await database.rawDelete(query);
  }

  //insert details

  static Future<int> insertDetailsdata(String query) async {
    return await detailsDatabase.rawInsert(query);
  }

  //read details data
  static Future<List<Map<String, Object?>>> readDetailsData(
      String query) async {
    return await detailsDatabase.rawQuery(query);
  }

  //update details data
  static Future<int> updateDetailsData(String query) async {
    return await detailsDatabase.rawUpdate(query);
  }

  //delete  details data
  static Future<int> deleteDetailsData(String query) async {
    return await detailsDatabase.rawDelete(query);
  }

  //inner join
}
