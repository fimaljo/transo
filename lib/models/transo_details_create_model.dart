class TransoCreateDetailsModel {
  int id;
  String currentStatus;
  String day;
  String imagePath;
  int transoId;

  TransoCreateDetailsModel({
    required this.id,
    required this.currentStatus,
    required this.day,
    required this.imagePath,
    required this.transoId,
  });

  factory TransoCreateDetailsModel.fromJson(Map<String, dynamic> json) =>
      TransoCreateDetailsModel(
        id: json["ID"],
        currentStatus: json["CURRENT_STATUS"],
        day: json["DAY"],
        imagePath: json["IMAGE_PATH"],
        transoId: json["TRANSO_ID"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "CURRENT_STATUS": currentStatus,
        "DAY": day,
        "IMAGE_PATH": imagePath,
        "TRANSO_ID": transoId,
      };
}
