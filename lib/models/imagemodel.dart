class ImageDataModel {
  //final controlnumber;
  final imagelink;

  ImageDataModel({
    // this.controlnumber,
    this.imagelink,
  });

  Map<String, dynamic> toJson() => {
        "imagelink": imagelink,
      };

  static ImageDataModel fromJson(Map<String, dynamic> json) => ImageDataModel(
        imagelink: json['imagelink'],
      );
}
