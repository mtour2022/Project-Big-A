class SmallListModel {
  final name;
  final description;
  final address;
  final webiste;
  final image1;

  SmallListModel({
    this.name,
    this.description,
    this.address,
    this.webiste,
    this.image1,
  });

  Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "address": address,
        "webiste": webiste,
        "image1": image1,
      };

  static SmallListModel fromJson(Map<String, dynamic> json) => SmallListModel(
        name: json['name'],
        description: json['description'],
        address: json['address'],
        webiste: json['webiste'],
        image1: json['image1'],
      );
}
