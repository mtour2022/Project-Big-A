import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/acitivitieslist.dart';
import '../models/listmodel.dart';

class ItemPageService extends ChangeNotifier {
  FirebaseFirestore? instance;

  List<ListModel> _accommodationlist = [];

  List<ListModel> getAccommodationItems() {
    return _accommodationlist;
  }

  Future<void> getAccommodationCollectionFromFirebase() async {
    var _firestoreInstance = FirebaseFirestore.instance;
    QuerySnapshot qn =
        await _firestoreInstance.collection('accommodations').get();

    var data = qn.docs.forEach((element) {
      var itemdata = element.data() as Map;
      var getitem = itemdata as Map<String, dynamic>;
      ListModel itemaccom = ListModel.fromJson(getitem);

      _accommodationlist.add(itemaccom);
    });
  }

  List<ListModel> _restaurantlist = [];

  List<ListModel> getRestaurantItems() {
    return _restaurantlist;
  }

  Future<void> getRestaurantCollectionFromFirebase() async {
    var _firestoreInstance = FirebaseFirestore.instance;
    QuerySnapshot qn = await _firestoreInstance.collection('restaurants').get();

    var data = qn.docs.forEach((element) {
      var itemdata = element.data() as Map;
      var getitem = itemdata as Map<String, dynamic>;
      ListModel itemaccom = ListModel.fromJson(getitem);

      _restaurantlist.add(itemaccom);
    });
  }

  List<ListModel> _attractionlist = [];

  List<ListModel> getAttractionItems() {
    return _attractionlist;
  }

  Future<void> getAttractionCollectionFromFirebase() async {
    var _firestoreInstance = FirebaseFirestore.instance;
    QuerySnapshot qn = await _firestoreInstance.collection('attractions').get();

    var data = qn.docs.forEach((element) {
      var itemdata = element.data() as Map;
      var getitem = itemdata as Map<String, dynamic>;
      ListModel itemaccom = ListModel.fromJson(getitem);

      _attractionlist.add(itemaccom);
    });
  }

  List<ActivityListModel> _activitieslist = [];

  List<ActivityListModel> getActivityItems() {
    return _activitieslist;
  }

  Future<void> getActivityCollectionFromFirebase() async {
    var _firestoreInstance = FirebaseFirestore.instance;
    QuerySnapshot qn = await _firestoreInstance.collection('activities').get();

    var data = qn.docs.forEach((element) {
      var itemdata = element.data() as Map;
      var getitem = itemdata as Map<String, dynamic>;
      ActivityListModel itemaccom = ActivityListModel.fromJson(getitem);

      _activitieslist.add(itemaccom);
    });
  }
}
