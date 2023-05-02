import 'dart:math';

import 'package:flutter/foundation.dart';

import 'package:transo/helpers/sql_helper.dart';
import 'package:transo/models/profile_model.dart';

import '../models/transo_create_model.dart';
import '../models/transo_details_create_model.dart';

class TransoProvider with ChangeNotifier {
  List<TransformationModel> transoCreateList = [];
  List<TransoCreateDetailsModel> transoDetailsCreateList = [];

  List<TransoCreateDetailsModel> transoDetailsCreateListT = [];
  List<ProfileModel> transoProfileList = [];
  var isLoading = false;
  setIsLoading(bool status) {
    isLoading = status;
    notifyListeners();
  }

  readData() async {
    setIsLoading(true);
    transoCreateList = [];
    List<Map<String, dynamic>> data =
        await SqlHelper.readData("select * from ${SqlHelper.tableName}");
    // print(data);
    for (Map<String, dynamic> element in data) {
      transoCreateList.add(TransformationModel.fromJson(element));
    }
    notifyListeners();
    setIsLoading(false);
  }

  insertData(
      String title, String target, String status, String totalDays) async {
    String query =
        "insert into ${SqlHelper.tableName}(title,target,CURRENT_STATUS,total_days ) values('$title','$target','$status','$totalDays')";
    int result = await SqlHelper.insertdata(query);
    // print(result);
    log(result);
  }

  updateData(String title, String target, String status, String totalDays,
      int id) async {
    String query =
        "update ${SqlHelper.tableName} set title='$title',target='$target',CURRENT_STATUS='$status',total_days='$totalDays' where id='$id'";
    int result = await SqlHelper.updateData(query);
    // print(result);
    log(result);
  }

  delete(int id) async {
    setIsLoading(true);
    String query = "delete from ${SqlHelper.tableName} where id='$id'";
    int result = await SqlHelper.deleteData(query);
    print(result);
    setIsLoading(false);
  }

  ///

  insertDeatilsData(
    String status,
    String day,
    String imagePath,
    int transoId,
  ) async {
    String query =
        "insert into ${SqlHelper.secondTableName}(CURRENT_STATUS,DAY,IMAGE_PATH,TRANSO_ID ) values('$status','$day','$imagePath','$transoId')";
    int result = await SqlHelper.insertDetailsdata(query);
    // print(result);
    log(result);
  }

//
  readDetailsData() async {
    //setIsLoading(true);
    transoDetailsCreateList = [];
    List<Map<String, dynamic>> data = await SqlHelper.readDetailsData(
        "select * from ${SqlHelper.secondTableName}");
    // print(data);
    for (Map<String, dynamic> element in data) {
      transoDetailsCreateList.add(TransoCreateDetailsModel.fromJson(element));
    }
    // notifyListeners();
    // setIsLoading(false);
  }
//delete details data

  deleteDetail(int id) async {
    setIsLoading(true);
    String query = "delete from ${SqlHelper.secondTableName} where id='$id'";
    int result = await SqlHelper.deleteDetailsData(query);
    print(result);
    setIsLoading(false);
  }

  updateDetailsData(String status, String path, int id) async {
    String query =
        "update ${SqlHelper.secondTableName} set CURRENT_STATUS='$status',IMAGE_PATH='$path' where id='$id'";
    int result = await SqlHelper.updateDetailsData(query);
    // print(result);
    log(result);
  }

  void getDetails(int id) {
    final result =
        transoDetailsCreateList.where((item) => item.transoId == id).toList();
    transoDetailsCreateListT = result;
  }

  // profile operation

  readProfileData() async {
    setIsLoading(true);

    List<Map<String, dynamic>> data = await SqlHelper.readProfileData(
        "select * from ${SqlHelper.profileTableName}");

    for (Map<String, dynamic> element in data) {
      transoProfileList.add(ProfileModel.fromJson(element));
    }
    notifyListeners();
    setIsLoading(false);
  }

  insertProfileData(
    String name,
    String completedCount,
    String imagePath,
  ) async {
    String query =
        "insert into ${SqlHelper.profileTableName}(NAME,COMPLETED_COUNT,IMAGE_PATH ) values('$name','$completedCount','$imagePath')";
    int result = await SqlHelper.insertProfiledata(query);
    print(result);
    log(result);
  }

  updateProfileData(
    String name,
    String completedCount,
    String imagePath,
  ) async {
    try {
      String query =
          "update ${SqlHelper.profileTableName} set NAME='$name',COMPLETED_COUNT='$completedCount',IMAGE_PATH='$imagePath'";
      int result = await SqlHelper.updateProfileData(query);
      print(result);
      log(result);
    } catch (e) {
      print(e);
    }
  }

  addIntialDatasToProfile() {
    final ProfileModel data =
        ProfileModel(id: 1, name: "Buddy", completedCount: "0", imagePath: "B");
    transoProfileList.add(data);
  }
}
