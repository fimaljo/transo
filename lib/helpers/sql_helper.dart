import 'package:sqflite/sqflite.dart';

class SqlHelper {
  SqlHelper._();
  static SqlHelper _instanse = SqlHelper._();
  static late Database database;
  static String tableName = "Transformation";

  //init
  static initDb() async {
    var databasesPath = await getDatabasesPath();

    String path = '$databasesPath/dbName';

    database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE $tableName ( ID INTEGER PRIMARY KEY AUTOINCREMENT, TITLE TEXT,  TARGET TEXT, CURRENT_STATUS TEXT, TOTAL_DAYS TEXT)');
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
  Future<int> updateData(String query) async {
    return await database.rawUpdate(query);
  }

  //delete data
  Future<int> deleteData(String query) async {
    return await database.rawDelete(query);
  }
}
