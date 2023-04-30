

class ProfileModel {
    int id;
    String name;
    String completedCount;
    String imagePath;

    ProfileModel({
        required this.id,
        required this.name,
        required this.completedCount,
        required this.imagePath,
    });

    factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        id: json["ID"],
        name: json["NAME"],
        completedCount: json["COMPLETED_COUNT"],
        imagePath: json["IMAGE_PATH"],
    );

    Map<String, dynamic> toJson() => {
        "ID": id,
        "NAME": name,
        "COMPLETED_COUNT": completedCount,
        "IMAGE_PATH": imagePath,
    };
}
