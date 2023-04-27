import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io';

import 'package:transo/helpers/sql_helper.dart';

import '../models/transo_create_model.dart';

class TransoProvider with ChangeNotifier {
  late final Database _database;
  List<TransoCreateModel> transoCreateList = [];

  readData() async {
    List<Map<String, dynamic>> data =
        await SqlHelper.readData("select * from ${SqlHelper.tableName}");
    print(data);
  }

  insertData(
      String title, String target, String status, String totalDays) async {
    String query =
        "insert into ${SqlHelper.tableName}(title,target,CURRENT_STATUS,total_days ) values('$title','$target','$status','$totalDays')";
    int result = await SqlHelper.insertdata(query);
    print(result);
    log(result);
  }
}
