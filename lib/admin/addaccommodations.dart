import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';

import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'package:line_icons/line_icons.dart';
import 'package:shimmer/shimmer.dart';
import 'package:uuid/uuid.dart';

import '../models/largelistmodel.dart';
import '../models/appcolor.dart';

class AddAccommodationsPage extends StatefulWidget {
  const AddAccommodationsPage({Key? key}) : super(key: key);

  @override
  State<AddAccommodationsPage> createState() => _AddAccommodationsPageState();
}

class _AddAccommodationsPageState extends State<AddAccommodationsPage> {
  var uuid = Uuid();
  String id = "";

  @override
  void initState() {
    id = uuid.v1();
    super.initState();
  }

  Future addData({
    required String name,
    required String description,
    required String address,
    required String classval,
    required String website,
    required String lat,
    required String long,
    required String image1,
    required String image2,
    required String image3,
  }) async {
    //Reference to document
    final dataReference =
        FirebaseFirestore.instance.collection('accommodations').doc('$id');

    final json = LargeListModel(
      name: name,
      description: description,
      address: address,
      classval: classval,
      website: website,
      lat: lat,
      long: long,
      image1: image1,
      image2: image2,
      image3: image3,
    );

    final jsonobjt = json.toJson();

    await dataReference.set(jsonobjt);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Appcolor.background,
            child: SingleChildScrollView(
              child: Stack(children: [
                SingleChildScrollView(
                  child: Column(
                    children: [],
                  ),
                ),
                Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 20, right: 20, top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset('assets/images/biga.png',
                                height: 40, width: 40),
                            Image.asset('assets/images/lgu.png',
                                height: 40, width: 40),
                            Image.asset('assets/images/mtour.png',
                                height: 40, width: 40),
                          ],
                        ),
                      ),
                    )),
              ]),
            )),
      ),
    );
  }
}
