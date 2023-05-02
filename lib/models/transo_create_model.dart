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
