class MediumListModel {
  final name;
  final description;

  final classval;

  final image1;
  final image2;
  final image3;

  MediumListModel({
    this.name,
    this.description,
    this.classval,
    this.image1,
    this.image2,
    this.image3,
  });

  Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "classval": classval,
        "image1": image1,
        "image2": image2,
        "image3": image3,
      };

  static MediumListModel fromJson(Map<String, dynamic> json) => MediumListModel(
        name: json['name'],
        description: json['description'],
        classval: json['classval'],
        image1: json['image1'],
        image2: json['image2'],
        image3: json['image3'],
      );
}
