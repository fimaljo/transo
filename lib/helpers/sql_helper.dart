import 'package:sqflite/sqflite.dart';

class SqlHelper {
  SqlHelper._();
 
  static late Database database;
  static late Database detailsDatabase;
  static late Database profileDatabase;
  static String transformationTable = "Transformation";
  static String transformationDetailsTable = "TransoDetails";
  static String profileTableName = "ProfileDetails";

  //init
  static initDb() async {
    var databasesPath = await getDatabasesPath();

    try {
      String path = '$databasesPath/transformationDB';

      database = await openDatabase(path, version: 1,
          onCreate: (Database db, int version) async {
        await db.execute(
            'CREATE TABLE $transformationTable ( ID INTEGER PRIMARY KEY AUTOINCREMENT, TITLE TEXT,  TARGET TEXT, CURRENT_STATUS TEXT, TOTAL_DAYS TEXT)');
      });

      String pathD = '$databasesPath/detailsDB';

      detailsDatabase = await openDatabase(pathD, version: 1,
          onCreate: (Database db, int version) async {
        await db.execute(
            'CREATE TABLE $transformationDetailsTable ( ID INTEGER PRIMARY KEY AUTOINCREMENT, CURRENT_STATUS TEXT, DAY TEXT, IMAGE_PATH TEXT, TRANSO_ID INTEGER, FOREIGN KEY (TRANSO_ID) REFERENCES Transformation(ID) ON DELETE CASCADE )');
      });
      String pathP = '$databasesPath/profileDB';
      profileDatabase = await openDatabase(pathP, version: 1,
          onCreate: (Database db, int version) async {
        await db.execute(
            'CREATE TABLE $profileTableName ( ID INTEGER PRIMARY KEY AUTOINCREMENT, NAME TEXT, COMPLETED_COUNT TEXT, IMAGE_PATH TEXT)');
      });
    } catch (_) {}
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

  //insert profile

  static Future<int> insertProfiledata(String query) async {
    return await profileDatabase.rawInsert(query);
  }

  //read profile data
  static Future<List<Map<String, Object?>>> readProfileData(
      String query) async {
    return await profileDatabase.rawQuery(query);
  }

  //update profile data
  static Future<int> updateProfileData(String query) async {
    return await profileDatabase.rawUpdate(query);
  }
}
