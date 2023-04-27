// import 'package:flutter/foundation.dart';
// import 'package:sqflite/sqflite.dart' as sql;

// class SQLHelper {
//   static Future<void> createTables(sql.Database database) async {
//     await database.execute("""CREATE TABLE items(
//         id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
//         title TEXT,
//         description TEXT,
//         createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
//       )
//       """);
//   }
// // id: the id of a item
// // title, description: name and description of your activity
// // created_at: the time that the item was created. It will be automatically handled by SQLite

//   static Future<sql.Database> db() async {
//     return sql.openDatabase(
//       'dbtech.db',
//       version: 1,
//       onCreate: (sql.Database database, int version) async {
//         await createTables(database);
//       },
//     );
//   }

//   // Create new item (journal)
//   static Future<int> createItem(String title, String? descrption) async {
//     final db = await SQLHelper.db();

//     final data = {'title': title, 'description': descrption};
//     final id = await db.insert('items', data,
//         conflictAlgorithm: sql.ConflictAlgorithm.replace);
//     return id;
//   }

//   // Read all items (journals)
//   static Future<List<Map<String, dynamic>>> getItems() async {
//     final db = await SQLHelper.db();
//     return db.query('items', orderBy: "id");
//   }

//   // Read a single item by id
//   // The app doesn't use this method but I put here in case you want to see it
//   static Future<List<Map<String, dynamic>>> getItem(int id) async {
//     final db = await SQLHelper.db();
//     return db.query('items', where: "id = ?", whereArgs: [id], limit: 1);
//   }

//   // Update an item by id
//   static Future<int> updateItem(
//       int id, String title, String? descrption) async {
//     final db = await SQLHelper.db();

//     final data = {
//       'title': title,
//       'description': descrption,
//       'createdAt': DateTime.now().toString()
//     };

//     final result =
//     await db.update('items', data, where: "id = ?", whereArgs: [id]);
//     return result;
//   }

//   // Delete
//   static Future<void> deleteItem(int id) async {
//     final db = await SQLHelper.db();
//     try {
//       await db.delete("items", where: "id = ?", whereArgs: [id]);
//     } catch (err) {
//       debugPrint("Something went wrong when deleting an item: $err");
//     }
//   }
// }

import 'dart:async';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:transo/models/transo_create_model.dart';

class LocalDB {
  final String dbName;
  Database? _db;
  List<TransoCreateModel> transoCreateList = [];
  final _streamController =
      StreamController<List<TransoCreateModel>>.broadcast();
  LocalDB(this.dbName);
  Future<List<TransoCreateModel>> _fechTranso() async {
    final db = _db;
    if (db == null) {
      return [];
    }
    try {
      final read = await db.query('TRANSOCREATE',
          distinct: true,
          columns: ['ID', 'TITLE', 'TARGET', 'CURRENT_STATUS', 'TOTAL_DAYS'],
          orderBy: 'ID');
      final transoCreate =
          read.map((row) => TransoCreateModel.fromRow(row)).toList();
      return transoCreate;
    } catch (e) {
      print("feaching table error $e");
      return [];
    }
  }

  Future<bool> close() async {
    final db = _db;

    if (db == null) {
      return false;
    }
    await db.close();
    return true;
  }

  Future<bool> open() async {
    if (_db != null) {
      return true;
    }
    final directory = await getApplicationDocumentsDirectory();
    final path = '${directory.path}/$dbName';

    try {
      final db = await openDatabase(path);
      _db = db;

      // create table
      const create = '''CREATE TABLE IF NOT EXISTS TRANSOCREATE(
        ID INTEGER PRIMARY KEY AUTOINCREMENT,
        TITLE STRING NOT NULL,
        TARGET STRING NOT NULL,
        CURRENT_STATUS STRING NOT NULL,
        TOTAL_DAYS STRING NOT NULL

      )''';
      await db.execute(create);

      // read all existing Transo objects from the db
      transoCreateList = await _fechTranso();

      _streamController.add(transoCreateList);
      return true;
    } catch (e) {
      print("creating table error $e");
      return false;
    }
  }
}
