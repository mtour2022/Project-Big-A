class AccommodationsModel {
  final name;
  final description;
  final address;
  final classval;
  final website;
  final lat;
  final long;
  final image1;
  final image2;
  final image3;

  AccommodationsModel({
    this.name,
    this.description,
    this.address,
    this.classval,
    this.website,
    this.lat,
    this.long,
    this.image1,
    this.image2,
    this.image3,
  });

  Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "address": address,
        "classval": classval,
        "website": website,
        "lat": lat,
        "long": long,
        "image1": image1,
        "image2": image2,
        "image3": image3,
      };

  static AccommodationsModel fromJson(Map<String, dynamic> json) =>
      AccommodationsModel(
        name: json['name'],
        description: json['description'],
        address: json['address'],
        classval: json['classval'],
        website: json['website'],
        lat: json['lat'],
        long: json['long'],
        image1: json['image1'],
        image2: json['image2'],
        image3: json['image3'],
      );
}
