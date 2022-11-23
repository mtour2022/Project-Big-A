import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/accommodationsmodel.dart';

class ItemPageService extends ChangeNotifier {
  FirebaseFirestore? instance;

  List<AccommodationsModel> _accommodationlist = [];

  List<AccommodationsModel> getAccommodationItems() {
    return _accommodationlist;
  }

  Future<void> getAccommodationCollectionFromFirebase() async {
    var _firestoreInstance = FirebaseFirestore.instance;
    QuerySnapshot qn =
        await _firestoreInstance.collection('accommodations').get();

    var data = qn.docs.forEach((element) {
      var itemdata = element.data() as Map;
      var getitem = itemdata as Map<String, dynamic>;
      AccommodationsModel itemaccom = AccommodationsModel.fromJson(getitem);

      _accommodationlist.add(itemaccom);
    });
  }

  List<AccommodationsModel> _restaurantlist = [];

  List<AccommodationsModel> getRestaurantItems() {
    return _restaurantlist;
  }

  Future<void> getRestaurantCollectionFromFirebase() async {
    var _firestoreInstance = FirebaseFirestore.instance;
    QuerySnapshot qn = await _firestoreInstance.collection('restaurants').get();

    var data = qn.docs.forEach((element) {
      var itemdata = element.data() as Map;
      var getitem = itemdata as Map<String, dynamic>;
      AccommodationsModel itemaccom = AccommodationsModel.fromJson(getitem);

      _restaurantlist.add(itemaccom);
    });
  }

  List<AccommodationsModel> _attractionlist = [];

  List<AccommodationsModel> getAttractionItems() {
    return _attractionlist;
  }

  Future<void> getAttractionCollectionFromFirebase() async {
    var _firestoreInstance = FirebaseFirestore.instance;
    QuerySnapshot qn = await _firestoreInstance.collection('attractions').get();

    var data = qn.docs.forEach((element) {
      var itemdata = element.data() as Map;
      var getitem = itemdata as Map<String, dynamic>;
      AccommodationsModel itemaccom = AccommodationsModel.fromJson(getitem);

      _attractionlist.add(itemaccom);
    });
  }
}
