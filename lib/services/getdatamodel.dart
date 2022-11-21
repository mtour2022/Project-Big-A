import 'package:flutter/cupertino.dart';

import 'package:projectbiga/models/datamodel.dart';

class FetchDataService extends ChangeNotifier {
  late ImageDataModel _fetcheddata;

  ImageDataModel get getstringdata => _fetcheddata;

  void getdata(
    // String controlnumber,
    String imagelink,
  ) async {
    _fetcheddata = ImageDataModel(
      //  controlnumber: controlnumber,
      imagelink: imagelink,
    );

    notifyListeners();
  }

  void cleardata() async {
    _fetcheddata = ImageDataModel(
      imagelink: "",
    );

    notifyListeners();
  }
}
