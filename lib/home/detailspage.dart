import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:latlng/latlng.dart';
import 'package:line_icons/line_icons.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:map/map.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:projectbiga/models/largelistmodel.dart';
import 'package:projectbiga/widgets/topnavigationbar.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/appcolor.dart';

class LargeDetailsPage extends StatefulWidget {
  LargeListModel itemdetails;
  String selectedCategory;
  String itemID;
  LargeDetailsPage(
      {required this.itemdetails,
      required this.selectedCategory,
      required this.itemID,
      super.key});

  @override
  State<LargeDetailsPage> createState() => _LargeDetailsPageState();
}

class _LargeDetailsPageState extends State<LargeDetailsPage> {
  late List<String> listitem = <String>[];
  var _dotPosition = 0;
  late LatLng latlongval;

  late LatLng destinationlatlong;

  late Uri _url;
  @override
  void initState() {
    destinationlatlong = LatLng(double.parse(widget.itemdetails.lat),
        double.parse(widget.itemdetails.long));
    listitem.add(widget.itemdetails.image1);
    listitem.add(widget.itemdetails.image2);
    listitem.add(widget.itemdetails.image3);
    latlongval = LatLng(double.parse(widget.itemdetails.lat),
        double.parse(widget.itemdetails.long));

    _url = Uri.parse(widget.itemdetails.website);

    super.initState();
  }

  Future<void> _launchInBrowser() async {
    if (!await launchUrl(_url, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch link';
    }
  }

  openMapsSheet(context) async {
    try {
      final coords =
          Coords(destinationlatlong.latitude, destinationlatlong.longitude);
      final title = widget.itemdetails.name;
      final availableMaps = await MapLauncher.installedMaps;

      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Container(
                child: Wrap(
                  children: <Widget>[
                    for (var map in availableMaps)
                      ListTile(
                        onTap: () => map.showMarker(
                          coords: coords,
                          title: title,
                        ),
                        title: Text(map.mapName),
                        leading: const Icon(
                          LineIcons.locationArrow,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final controllerl = MapController(
      location: latlongval,
      zoom: 15,
    );
    return SafeArea(
      child: Scaffold(
          body: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Stack(
                        children: [
                          Container(
                            height: 350,
                            width: MediaQuery.of(context).size.width,
                            color: Colors.white,
                            child: Center(
                              child: LoadingAnimationWidget.bouncingBall(
                                color: Appcolor.bluecolor1,
                                size: 25,
                              ),
                            ),
                          ),
                          CarouselSlider(
                              items: listitem
                                  .map(
                                    (item) => Stack(
                                      children: [
                                        Shimmer.fromColors(
                                            highlightColor: Colors.white,
                                            baseColor: Appcolor.background,
                                            child: Container(
                                                height: 350,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                color: Colors.white)),
                                        Container(
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: NetworkImage(item),
                                                  fit: BoxFit.cover)),
                                        )
                                      ],
                                    ),
                                  )
                                  .toList(),
                              options: CarouselOptions(
                                  height: 350,
                                  viewportFraction: 1.0,
                                  enlargeCenterPage: false,
                                  autoPlay: true,
                                  onPageChanged:
                                      (val, carouselPageChangedReason) {
                                    setState(() {
                                      _dotPosition = val;
                                    });
                                  })),
                        ],
                      ),
                      const Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: TopNavigationBar(),
                      ),
                      Positioned(
                        bottom: 10,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: DotsIndicator(
                            dotsCount: listitem.isEmpty ? 1 : listitem.length,
                            position: _dotPosition.toDouble(),
                            decorator: const DotsDecorator(
                              color: Appcolor.grey1,
                              activeColor: Appcolor.bluecolor1,
                              spacing: EdgeInsets.all(2),
                              size: Size(8, 8),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${widget.itemdetails.name}",
                          style: const TextStyle(
                              color: Appcolor.grey3,
                              fontSize: 25,
                              fontWeight: FontWeight.w800),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          "${widget.itemdetails.classval}",
                          style: const TextStyle(
                            color: Appcolor.bluecolor1,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        ExpandableText(
                          widget.itemdetails.description,
                          expandText: 'show more',
                          collapseText: 'show less',
                          maxLines: 4,
                          linkColor: Appcolor.bluecolor1,
                          textAlign: TextAlign.justify,
                          style: const TextStyle(
                              fontSize: 14,
                              color: Appcolor.grey2,
                              fontWeight: FontWeight.normal),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Visibility(
                          visible: widget.itemdetails.address != "none",
                          child: Text(
                            "${widget.itemdetails.address}",
                            style: const TextStyle(
                              color: Appcolor.bluecolor1,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Visibility(
                          visible: widget.itemdetails.lat != "0",
                          child: Stack(
                            children: [
                              SizedBox(
                                height: 300,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: MapLayout(
                                    controller: controllerl,
                                    builder: (context, transformer) {
                                      return TileLayer(
                                        builder: (context, x, y, z) {
                                          final tilesInZoom =
                                              pow(2.0, z).floor();

                                          while (x < 0) {
                                            x += tilesInZoom;
                                          }
                                          while (y < 0) {
                                            y += tilesInZoom;
                                          }

                                          x %= tilesInZoom;
                                          y %= tilesInZoom;

                                          //Google Maps
                                          final url =
                                              'https://www.google.com/maps/vt/pb=!1m4!1m3!1i$z!2i$x!3i$y!2m3!1e0!2sm!3i420120488!3m7!2sen!5e1105!12m4!1e68!2m2!1sset!2sRoadmap!4e0!5m1!1e0!23i4111425';

                                          return CachedNetworkImage(
                                            imageUrl: url,
                                            fit: BoxFit.cover,
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ),
                              Positioned.fill(
                                  child: Align(
                                      alignment: Alignment.center,
                                      child: PhysicalModel(
                                        color: Colors.transparent,
                                        elevation: 10,
                                        shadowColor:
                                            Colors.black.withOpacity(0.8),
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: const Icon(
                                          Icons.location_on_rounded,
                                          size: 35,
                                          color: Colors.white,
                                        ),
                                      ))),
                              Visibility(
                                visible: widget.itemdetails.lat != "0",
                                child: Positioned(
                                  bottom: 10,
                                  left: 29,
                                  right: 29,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      openMapsSheet(context);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      shadowColor:
                                          Colors.black.withOpacity(0.5),
                                      padding: const EdgeInsets.all(15),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Icon(
                                          LineIcons.map,
                                          size: 20,
                                          color: Colors.white,
                                        ),
                                        Text(
                                          '\t\tOpen Map',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  //edit item
                  ElevatedButton(
                    onPressed: () {
                      TextEditingController adname = TextEditingController();
                      TextEditingController addescription =
                          TextEditingController();
                      TextEditingController adaddress = TextEditingController();
                      TextEditingController adclassval =
                          TextEditingController();
                      TextEditingController adwebsite = TextEditingController();
                      TextEditingController adlat = TextEditingController();
                      TextEditingController adlong = TextEditingController();
                      TextEditingController adimage1 = TextEditingController();
                      TextEditingController adimage2 = TextEditingController();
                      TextEditingController adimage3 = TextEditingController();

                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: Text("ADD NEW ITEM",
                                    style: TextStyle(
                                        fontSize: 25, color: Colors.blue[400])),
                                content: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      //field to comment
                                      buildTextFieldForm(
                                          title: "Title",
                                          controller: adname
                                            ..text = widget.itemdetails.name),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      buildTextFieldForm(
                                          title: "Description",
                                          controller: addescription
                                            ..text =
                                                widget.itemdetails.description),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      buildTextFieldForm(
                                          title: "Address",
                                          controller: adaddress
                                            ..text =
                                                widget.itemdetails.address),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      buildTextFieldForm(
                                          title: "Class",
                                          controller: adclassval
                                            ..text =
                                                widget.itemdetails.classval),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      buildTextFieldForm(
                                          title: "Website",
                                          controller: adwebsite
                                            ..text =
                                                widget.itemdetails.website),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      buildTextFieldForm(
                                          title: "Latitude",
                                          controller: adlat
                                            ..text = widget.itemdetails.lat),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      buildTextFieldForm(
                                          title: "Longitude",
                                          controller: adlong
                                            ..text = widget.itemdetails.long),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      buildTextFieldForm(
                                          title: "Image 1",
                                          controller: adimage1
                                            ..text = widget.itemdetails.image1),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      buildTextFieldForm(
                                          title: "Image 2",
                                          controller: adimage2
                                            ..text = widget.itemdetails.image2),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      buildTextFieldForm(
                                          title: "Image 3",
                                          controller: adimage2
                                            ..text = widget.itemdetails.image3),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      adname.clear();
                                      addescription.clear();
                                      adaddress.clear();
                                      adclassval.clear();
                                      adwebsite.clear();
                                      adlat.clear();
                                      adlong.clear();
                                      adimage1.clear();
                                      adimage2.clear();
                                      adimage3.clear();
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      'Cancel',
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 18),
                                    ),
                                  ),
                                  //add button for admin
                                  TextButton(
                                    onPressed: () async {
                                      await FirebaseFirestore.instance
                                          .collection(widget.selectedCategory)
                                          .doc(widget.itemID)
                                          .update({
                                        "name": adname.text,
                                        "description": addescription.text,
                                        "address": adaddress.text,
                                        "classval": adclassval.text,
                                        "website": adwebsite.text,
                                        "lat": adlat.text,
                                        "long": adlong.text,
                                        "image1": adimage1.text,
                                        "image2": adimage2.text,
                                        "image3": adimage3.text,
                                      });
                                      Navigator.pop(context);
                                      showSimpleNotification(
                                        const Text("Item Successfully Edited"),
                                        background: Colors.green[400],
                                        position: NotificationPosition.bottom,
                                      );
                                    },
                                    child: const Text(
                                      'Submit',
                                      style: TextStyle(
                                        color: Colors.teal,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ));
                    },
                    style: ElevatedButton.styleFrom(
                      shadowColor: Colors.black.withOpacity(0.5),
                      padding: const EdgeInsets.all(15),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(LineIcons.plusCircle,
                            size: 16, color: Colors.white),
                        SizedBox(width: 5),
                        Text('EDIT ITEM',
                            style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 200,
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: widget.itemdetails.website != "none",
            child: Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 80,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 3,
                        offset:
                            const Offset(3, 0), // changes position of shadow
                      ),
                    ],
                    borderRadius: BorderRadius.circular(5)),
                child: Container(
                  margin: const EdgeInsets.only(
                      top: 15, bottom: 15, left: 50, right: 50),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: const LinearGradient(colors: [
                        Appcolor.bluecolor1,
                        Appcolor.bluecolor3,
                        Appcolor.bluecolor3,
                      ])),
                  child: ElevatedButton(
                    onPressed: () {
                      _launchInBrowser();
                    },
                    style: ElevatedButton.styleFrom(
                        shadowColor: Colors.transparent),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        widget.itemdetails.website.contains('facebook')
                            ? const Icon(
                                LineIcons.facebook,
                                size: 20,
                                color: Colors.white,
                              )
                            : const Icon(
                                LineIcons.globe,
                                size: 20,
                                color: Colors.white,
                              ),
                        widget.itemdetails.website.contains('facebook')
                            ? const Text(
                                '\t\tVisit Facebook',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              )
                            : const Text(
                                '\t\tVisit Website',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      )),
    );
  }
}

//Text Field
Widget buildTextFieldForm(
    {required String title, required TextEditingController controller}) {
  return TextField(
    controller: controller,
    textCapitalization: TextCapitalization.words,
    decoration: InputDecoration(
      labelStyle: const TextStyle(color: Colors.grey),
      labelText: title,
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.blue, width: 1.5),
        borderRadius: BorderRadius.circular(
          10.0,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.blue, width: 1.5),
        borderRadius: BorderRadius.circular(
          10.0,
        ),
      ),
    ),
  );
}


//edit field
/*Widget buildEditItem(
    {required String docId, required String selectedCategory}) {
  return 
}*/