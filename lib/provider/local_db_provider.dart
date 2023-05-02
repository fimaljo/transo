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
// read data from tranasfromartion table
  readData() async {
    transoCreateList = [];
    List<Map<String, dynamic>> data = await SqlHelper.readData(
        "select * from ${SqlHelper.transformationTable}");

    for (Map<String, dynamic> element in data) {
      transoCreateList.add(TransformationModel.fromJson(element));
    }
    notifyListeners();
  }
// insert data from tranasfromartion table
  insertData(
      String title, String target, String status, String totalDays) async {
    String query =
        "insert into ${SqlHelper.transformationTable}(title,target,CURRENT_STATUS,total_days ) values('$title','$target','$status','$totalDays')";
    await SqlHelper.insertdata(query);
  }
// updateData from tranasfromartion table
  updateData(String title, String target, String status, String totalDays,
      int id) async {
    String query =
        "update ${SqlHelper.transformationTable} set title='$title',target='$target',CURRENT_STATUS='$status',total_days='$totalDays' where id='$id'";
    await SqlHelper.updateData(query);
  }
//  delete data from tranasfromartion table
  delete(int id) async {
    String query =
        "delete from ${SqlHelper.transformationTable} where id='$id'";
    await SqlHelper.deleteData(query);
  }

//  insert data from tranasfromartionDetails table

  insertDeatilsData(
    String status,
    String day,
    String imagePath,
    int transoId,
  ) async {
    String query =
        "insert into ${SqlHelper.transformationDetailsTable}(CURRENT_STATUS,DAY,IMAGE_PATH,TRANSO_ID ) values('$status','$day','$imagePath','$transoId')";
    await SqlHelper.insertDetailsdata(query);
  }

//  insert read from tranasfromartionDetails table
  readDetailsData() async {
    
    transoDetailsCreateList = [];
    List<Map<String, dynamic>> data = await SqlHelper.readDetailsData(
        "select * from ${SqlHelper.transformationDetailsTable}");

    for (Map<String, dynamic> element in data) {
      transoDetailsCreateList.add(TransoCreateDetailsModel.fromJson(element));
    }
  }
//delete details data

  deleteDetail(int id) async {
    String query =
        "delete from ${SqlHelper.transformationDetailsTable} where id='$id'";
    await SqlHelper.deleteDetailsData(query);
  }

  updateDetailsData(String status, String path, int id) async {
    String query =
        "update ${SqlHelper.transformationDetailsTable} set CURRENT_STATUS='$status',IMAGE_PATH='$path' where id='$id'";
    await SqlHelper.updateDetailsData(query);
  }

  void getDetails(int id) {
    final result =
        transoDetailsCreateList.where((item) => item.transoId == id).toList();
    transoDetailsCreateListT = result;
  }

  // profile operation

  readProfileData() async {
    List<Map<String, dynamic>> data = await SqlHelper.readProfileData(
        "select * from ${SqlHelper.profileTableName}");

    for (Map<String, dynamic> element in data) {
      transoProfileList.add(ProfileModel.fromJson(element));
    }
    notifyListeners();
  }

  insertProfileData(
    String name,
    String completedCount,
    String imagePath,
  ) async {
    String query =
        "insert into ${SqlHelper.profileTableName}(NAME,COMPLETED_COUNT,IMAGE_PATH ) values('$name','$completedCount','$imagePath')";
    await SqlHelper.insertProfiledata(query);
  }

  updateProfileData(
    String name,
    String completedCount,
    String imagePath,
  ) async {
    try {
      String query =
          "update ${SqlHelper.profileTableName} set NAME='$name',COMPLETED_COUNT='$completedCount',IMAGE_PATH='$imagePath'";
    await SqlHelper.updateProfileData(query);
    } catch (_) {}
  }

  addIntialDatasToProfile() {
    final ProfileModel data =
        ProfileModel(id: 1, name: "Buddy", completedCount: "0", imagePath: "B");
    transoProfileList.add(data);
  }
}
