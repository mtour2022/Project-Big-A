class SmallListModel {
  final name;

  final address;
  final website;
  final image1;

  SmallListModel({
    this.name,
    this.address,
    this.website,
    this.image1,
  });

  Map<String, dynamic> toJson() => {
        "name": name,
        "address": address,
        "website": website,
        "image1": image1,
      };

  static SmallListModel fromJson(Map<String, dynamic> json) => SmallListModel(
        name: json['name'],
        address: json['address'],
        website: json['website'],
        image1: json['image1'],
      );
}
