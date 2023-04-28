// class TransoCreateModel implements Comparable {
//   final int id;
//   final String title;
//   final String target;
//   final String currentStatus;
//   final String totalDays;

//   const TransoCreateModel(
//       this.id, this.title, this.target, this.currentStatus, this.totalDays);
//   TransoCreateModel.fromRow(Map<String, Object?> row)
//       : id = row['ID'] as int,
//         title = row['TITLE'] as String,
//         target = row['TARGET'] as String,
//         currentStatus = row['CURRENT_STATUS'] as String,
//         totalDays = row['TOTAL_DAYS'] as String;
//   @override
//   int compareTo(covariant TransoCreateModel other) => id.compareTo(other.id);
//   @override
//   bool operator ==(covariant TransoCreateModel other) => id == other.id;

//   @override
//   int get hashCode => id.hashCode;
//   @override
//   String toString() => 'TransoCreateModel, id = $id,title : $title';
// }
// To parse this JSON data, do
//
//     final transformationModel = transformationModelFromJson(jsonString);

import 'dart:convert';

class TransformationModel {
  int id;
  String title;
  String target;
  String currentStatus;
  String totalDays;

  TransformationModel({
    required this.id,
    required this.title,
    required this.target,
    required this.currentStatus,
    required this.totalDays,
  });

  factory TransformationModel.fromJson(Map<String, dynamic> json) =>
      TransformationModel(
        id: json["ID"],
        title: json["TITLE"],
        target: json["TARGET"],
        currentStatus: json["CURRENT_STATUS"],
        totalDays: json["TOTAL_DAYS"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "TITLE": title,
        "TARGET": target,
        "CURRENT_STATUS": currentStatus,
        "TOTAL_DAYS": totalDays,
      };
}
