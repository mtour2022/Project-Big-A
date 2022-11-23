import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/accommodationsmodel.dart';

class ItemPageService extends ChangeNotifier {
  FirebaseFirestore? instance;

  List<AccommodationsModel> _items = [];

  List<AccommodationsModel> getItems() {
    return _items;
  }

  Future<void> getItemsCollectionFromFirebase() async {
    /*instance = FirebaseFirestore.instance;
    CollectionReference itemcol = instance!.collection('accommodations');

    QuerySnapshot<Object?> snapshot = await itemcol.get();*/

    var _firestoreInstance = FirebaseFirestore.instance;
    QuerySnapshot qn =
        await _firestoreInstance.collection('accommodations').get();

    var data = qn.docs.forEach((element) {
      var itemdata = element.data() as Map;
      var getitem = itemdata as Map<String, dynamic>;
      AccommodationsModel itemaccom = AccommodationsModel.fromJson(getitem);

      _items.add(itemaccom);
      print(itemaccom.toString());
    });

    ;
    /*for (int i = 0; i < qn.docs.length; i++) {
      _items.add(qn.docs[i]['name']);
      
    }*/
  }
}
