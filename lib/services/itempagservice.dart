import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/mediumlistmodel.dart';
import '../models/largelistmodel.dart';

class ItemPageService extends ChangeNotifier {
  FirebaseFirestore? instance;

  List<LargeListModel> _accommodationlist = [];

  List<LargeListModel> getAccommodationItems() {
    return _accommodationlist;
  }

  Future<void> getAccommodationCollectionFromFirebase() async {
    var _firestoreInstance = FirebaseFirestore.instance;
    QuerySnapshot qn =
        await _firestoreInstance.collection('accommodations').get();

    var data = qn.docs.forEach((element) {
      var itemdata = element.data() as Map;
      var getitem = itemdata as Map<String, dynamic>;
      LargeListModel itemaccom = LargeListModel.fromJson(getitem);

      _accommodationlist.add(itemaccom);
    });
  }

  List<LargeListModel> _restaurantlist = [];

  List<LargeListModel> getRestaurantItems() {
    return _restaurantlist;
  }

  Future<void> getRestaurantCollectionFromFirebase() async {
    var _firestoreInstance = FirebaseFirestore.instance;
    QuerySnapshot qn = await _firestoreInstance.collection('restaurants').get();

    var data = qn.docs.forEach((element) {
      var itemdata = element.data() as Map;
      var getitem = itemdata as Map<String, dynamic>;
      LargeListModel itemaccom = LargeListModel.fromJson(getitem);

      _restaurantlist.add(itemaccom);
    });
  }

  List<LargeListModel> _attractionlist = [];

  List<LargeListModel> getAttractionItems() {
    return _attractionlist;
  }

  Future<void> getAttractionCollectionFromFirebase() async {
    var _firestoreInstance = FirebaseFirestore.instance;
    QuerySnapshot qn = await _firestoreInstance.collection('attractions').get();

    var data = qn.docs.forEach((element) {
      var itemdata = element.data() as Map;
      var getitem = itemdata as Map<String, dynamic>;
      LargeListModel itemaccom = LargeListModel.fromJson(getitem);

      _attractionlist.add(itemaccom);
    });
  }

  List<MediumListModel> _activitieslist = [];

  List<MediumListModel> getActivityItems() {
    return _activitieslist;
  }

  Future<void> getActivityCollectionFromFirebase() async {
    var _firestoreInstance = FirebaseFirestore.instance;
    QuerySnapshot qn = await _firestoreInstance.collection('activities').get();

    var data = qn.docs.forEach((element) {
      var itemdata = element.data() as Map;
      var getitem = itemdata as Map<String, dynamic>;
      MediumListModel itemaccom = MediumListModel.fromJson(getitem);

      _activitieslist.add(itemaccom);
    });
  }
}
