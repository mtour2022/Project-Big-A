import 'package:flutter/cupertino.dart';
import 'package:projectbiga/models/listmodel.dart';

import 'package:projectbiga/models/datamodel.dart';

class FetchDataService extends ChangeNotifier {
  late ListModel _fetcheddataaccommodation;

  ListModel get getstringdataaccommodation => _fetcheddataaccommodation;

  void getdata(
    String name,
    String description,
    String address,
    String classval,
    String website,
    String lat,
    String long,
    String image1,
    String image2,
    String image3,
  ) async {
    _fetcheddataaccommodation = ListModel(
        name: name,
        description: description,
        address: address,
        classval: classval,
        website: website,
        lat: lat,
        long: long,
        image1: image1,
        image2: image2,
        image3: image3);

    notifyListeners();
  }

  void cleardata() async {
    _fetcheddataaccommodation = ListModel(
      name: "",
      description: "",
      address: "",
      classval: "",
      website: "",
      lat: "",
      long: "",
      image1: "",
      image2: "",
      image3: "",
    );

    notifyListeners();
  }
}
