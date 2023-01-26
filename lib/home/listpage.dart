import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:overlay_support/overlay_support.dart';

import 'package:projectbiga/models/largelistmodel.dart';
import 'package:projectbiga/models/smalllistmodel.dart';
import 'package:projectbiga/services/itempagservice.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/appcolor.dart';
import 'detailspage.dart';

class ListPage extends StatefulWidget {
  String selectedCategory;
  //IconData iconval;
  ListPage({required this.selectedCategory, super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  List<LargeListModel> largeitemlist = [];
  List<SmallListModel> smallitemlist = [];

  fetchLargeData() async {
    ItemPageService itemdata =
        Provider.of<ItemPageService>(context, listen: false);
    if (widget.selectedCategory == "accommodations") {
      largeitemlist = itemdata.getaccommodations();
    } else if (widget.selectedCategory == "restaurants") {
      largeitemlist = itemdata.getrestaurants();
    } else if (widget.selectedCategory == "attractions") {
      largeitemlist = itemdata.getattractions();
    } else if (widget.selectedCategory == "activities") {
      largeitemlist = itemdata.getactivities();
    } else {
      return;
    }
  }

  fetchSmallData() async {
    ItemPageService itemdata =
        Provider.of<ItemPageService>(context, listen: false);
    if (widget.selectedCategory == "travelagencies") {
      smallitemlist = itemdata.gettravelagencies();
    } else if (widget.selectedCategory == "tourguides") {
      smallitemlist = itemdata.gettourguides();
    } else {
      return;
    }
  }

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch link';
    }
  }

  String docId2 = "";

  @override
  void initState() async {
    if (widget.selectedCategory == 'accommodations') {
      fetchLargeData();
    } else if (widget.selectedCategory == "restaurants") {
      fetchLargeData();
    } else if (widget.selectedCategory == "attractions") {
      fetchLargeData();
    } else if (widget.selectedCategory == "activities") {
      fetchLargeData();
    } else if (widget.selectedCategory == "travelagencies") {
      fetchSmallData();
    } else if (widget.selectedCategory == "tourguides") {
      fetchSmallData();
    }

    DocumentReference docRef =
        FirebaseFirestore.instance.collection(widget.selectedCategory).doc();

    DocumentSnapshot docSnap = await docRef.get();
    docId2 = docSnap.reference.id;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Stack(
        children: [
          Column(
            children: [
              const SizedBox(
                height: 60,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 0, bottom: 0),
                child: buildAddItem(
                    docId: docId2,
                    selectedCategory: widget.selectedCategory,
                    context: context),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: GridView.count(
                    padding: const EdgeInsets.all(10),
                    shrinkWrap: true,
                    childAspectRatio: 0.8,
                    crossAxisCount: 2,
                    children: List.generate(
                        largeitemlist.isNotEmpty
                            ? largeitemlist.length
                            : smallitemlist.length, (index) {
                      return GestureDetector(
                          onTap: () async {
                            if (largeitemlist.isNotEmpty) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LargeDetailsPage(
                                            itemdetails: largeitemlist[index],
                                            selectedCategory:
                                                widget.selectedCategory,
                                            itemID: docId2,
                                          )));
                            } else {
                              _launchInBrowser(
                                  Uri.parse(smallitemlist[index].website));
                            }
                          },
                          //user physicalmodel to add shadow in a combined widgets
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Stack(
                                children: [
                                  Container(
                                    height: 200,
                                    width:
                                        MediaQuery.of(context).size.width / 2 -
                                            35,
                                    color: Colors.white,
                                    child: Center(
                                      child:
                                          LoadingAnimationWidget.bouncingBall(
                                        color: Appcolor.bluecolor1,
                                        size: 25,
                                      ),
                                    ),
                                  ),
                                  buildCardWidget(
                                      title: largeitemlist.isNotEmpty
                                          ? largeitemlist[index].name
                                          : smallitemlist[index].name,
                                      imagelink: largeitemlist.isNotEmpty
                                          ? largeitemlist[index].image1
                                          : smallitemlist[index].image1,
                                      classval: largeitemlist.isNotEmpty
                                          ? largeitemlist[index].classval
                                          : "",
                                      address: largeitemlist.isNotEmpty
                                          ? largeitemlist[index].name
                                          : smallitemlist[index].address,
                                      //iconval: widget.iconval,
                                      context: context),
                                  Positioned(
                                      child: buildDeleteItem(
                                          docId: docId2,
                                          selectedCategory:
                                              widget.selectedCategory))
                                ],
                              ),
                            ),
                          ));
                    })),
              ),
            ],
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset('assets/images/biga.png',
                        height: 40, width: 40),
                    Image.asset('assets/images/lgu.png', height: 40, width: 40),
                    Image.asset('assets/images/mtour.png',
                        height: 40, width: 40),
                  ],
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }

  Widget buildCardWidget(
      {required String imagelink,
      required String title,
      required String address,
      required String classval,
      context}) {
    return Stack(
      children: [
        Container(
          height: 200,
          width: MediaQuery.of(context).size.width / 2 - 35,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(imagelink), fit: BoxFit.cover),
              borderRadius: BorderRadius.circular(5)),
        ),
        Positioned.fill(
          child: Container(
            height: 200,
            width: MediaQuery.of(context).size.width / 2 - 35,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.transparent,
                    Colors.transparent,
                    Colors.black.withOpacity(0.5),
                    Appcolor.grey3,
                  ],
                ),
                borderRadius: BorderRadius.circular(5)),
          ),
        ),
        Positioned(
          bottom: 10,
          left: 10,
          right: 10,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                      color: Appcolor.background,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      shadows: <Shadow>[
                        Shadow(
                          offset: Offset(1, 1),
                          blurRadius: 8,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ])),
              Text("• $classval",
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                      color: Appcolor.background,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      shadows: <Shadow>[
                        Shadow(
                          offset: Offset(1, 1),
                          blurRadius: 3.0,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ])),
              Text(address,
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                      color: Appcolor.background,
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      shadows: <Shadow>[
                        Shadow(
                          offset: Offset(1, 1),
                          blurRadius: 3.0,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ])),
            ],
          ),
        ),
        Positioned(
          top: 10,
          right: 10,
          child: Icon(
            widget.selectedCategory == "accommodations"
                ? LineIcons.bed
                : widget.selectedCategory == "restaurants"
                    ? LineIcons.utensils
                    : widget.selectedCategory == "attractions"
                        ? LineIcons.binoculars
                        : widget.selectedCategory == "activities"
                            ? LineIcons.swimmer
                            : widget.selectedCategory == "travelagencies"
                                ? LineIcons.plane
                                : widget.selectedCategory == "tourguides"
                                    ? LineIcons.flag
                                    : LineIcons.bed,
            color: Colors.white,
            size: 20,
            shadows: const <Shadow>[
              Shadow(color: Colors.black, blurRadius: 15.0)
            ],
          ),
        ),
      ],
    );
  }
}

//Text Field
Widget buildTextField(
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

//image upload
Widget buildImageUpload(
    {required String title,
    required TextEditingController controller,
    required String selectedCategory}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      shadowColor: Colors.black.withOpacity(0.5),
      padding: const EdgeInsets.all(15),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Icon(LineIcons.image, size: 16, color: Colors.white),
        SizedBox(width: 5),
        Text('Image 1', style: TextStyle(color: Colors.white)),
      ],
    ),
    onPressed: () async {
      ImagePicker imagePicker = ImagePicker();
      XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
      //print('${file?.path}');

      if (file == null) return;

      String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();

      Reference referenceRoot = FirebaseStorage.instance.ref();
      Reference referenceImages = referenceRoot.child(selectedCategory);
      Reference referenceImageToUpload = referenceImages.child(uniqueFileName);
      try {
        await referenceImageToUpload.putFile(File(file.path));
        controller.text = await referenceImageToUpload.getDownloadURL();
      } catch (error) {
        showSimpleNotification(
          const Text("Image Failed to Upload"),
          background: Colors.grey,
          position: NotificationPosition.bottom,
        );
      }
    },
  );
}

//delete Item
Widget buildDeleteItem(
    {required String docId, required String selectedCategory}) {
  return IconButton(
    color: Colors.grey,
    icon: LineIcon.trash(),
    iconSize: 25,
    onPressed: () async {
      await FirebaseFirestore.instance
          .collection(selectedCategory)
          .doc(docId)
          .delete();
    },
  );
}

//add item
Widget buildAddItem(
    {required String docId, required String selectedCategory, context}) {
  return ElevatedButton(
    onPressed: () {
      TextEditingController name = TextEditingController();
      TextEditingController description = TextEditingController();
      TextEditingController address = TextEditingController();
      TextEditingController classval = TextEditingController();
      TextEditingController website = TextEditingController();
      TextEditingController lat = TextEditingController();
      TextEditingController long = TextEditingController();
      TextEditingController image1 = TextEditingController();
      TextEditingController image2 = TextEditingController();
      TextEditingController image3 = TextEditingController();

      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text("ADD NEW ITEM",
                    style: TextStyle(fontSize: 25, color: Colors.blue[400])),
                content: SingleChildScrollView(
                  child: Column(
                    children: [
                      //field to comment
                      buildTextField(title: "Title", controller: name),
                      const SizedBox(
                        height: 10,
                      ),
                      buildTextField(
                          title: "Description", controller: description),
                      const SizedBox(
                        height: 10,
                      ),
                      buildTextField(title: "Address", controller: address),
                      const SizedBox(
                        height: 10,
                      ),
                      buildTextField(title: "Class", controller: classval),
                      const SizedBox(
                        height: 10,
                      ),
                      buildTextField(title: "Website", controller: website),
                      const SizedBox(
                        height: 10,
                      ),
                      buildTextField(title: "Latitude", controller: lat),
                      const SizedBox(
                        height: 10,
                      ),
                      buildTextField(title: "Longitude", controller: long),
                      const SizedBox(
                        height: 10,
                      ),

                      image1.text.isEmpty
                          ? buildImageUpload(
                              title: "Image 1",
                              controller: image1,
                              selectedCategory: selectedCategory)
                          : buildTextField(
                              title: "Image 1", controller: image1),
                      const SizedBox(
                        height: 10,
                      ),
                      image2.text.isEmpty
                          ? buildImageUpload(
                              title: "Image 2",
                              controller: image2,
                              selectedCategory: selectedCategory)
                          : buildTextField(
                              title: "Image 2", controller: image2),
                      const SizedBox(
                        height: 10,
                      ),
                      image3.text.isEmpty
                          ? buildImageUpload(
                              title: "Image 3",
                              controller: image3,
                              selectedCategory: selectedCategory)
                          : buildTextField(
                              title: "Image 3", controller: image2),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      name.clear();
                      description.clear();
                      address.clear();
                      classval.clear();
                      website.clear();
                      lat.clear();
                      long.clear();
                      image1.clear();
                      image2.clear();
                      image3.clear();
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Cancel',
                      style: TextStyle(color: Colors.red, fontSize: 18),
                    ),
                  ),
                  //add button for admin
                  TextButton(
                    onPressed: () async {
                      Map<String, String> dataToSave = {
                        "name": name.text,
                        "description": description.text,
                        "address": address.text,
                        "classval": classval.text,
                        "website": website.text,
                        "lat": lat.text,
                        "long": long.text,
                        "image1": image1.text,
                        "image2": image2.text,
                        "image3": image3.text,
                      };
                      await FirebaseFirestore.instance
                          .collection(selectedCategory)
                          .add(dataToSave);

                      Navigator.pop(context);
                      showSimpleNotification(
                        const Text("New Step Added"),
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
        Icon(LineIcons.plusCircle, size: 16, color: Colors.white),
        SizedBox(width: 5),
        Text('ADD NEW ITEM', style: TextStyle(color: Colors.white)),
      ],
    ),
  );
}
