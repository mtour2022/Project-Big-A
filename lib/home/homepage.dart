import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shimmer/shimmer.dart';
import '../models/appcolor.dart';
import 'listpage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _dotPosition = 0;
  //edit to final
  final List<String> _promotionImages = [];
  late IconData iconval;
  List<Map<dynamic, dynamic>> largebuttonlist = [
    ({
      "title": "Accredited Accommodation",
      "dataref": "accommodations",
      "imgname": "accommodations.png",
      "icnname": LineIcons.bed
    }),
    ({
      "title": "Accredited Restaurants",
      "dataref": "restaurants",
      "imgname": "restaurants.png",
      "icnname": LineIcons.utensils
    }),
    ({
      "title": "Attractions to See",
      "dataref": "attractions",
      "imgname": "attractions.png",
      "icnname": LineIcons.binoculars
    }),
    ({
      "title": "Activities to Experience",
      "dataref": "activities",
      "imgname": "activities.png",
      "icnname": LineIcons.swimmer
    }),
  ];

  List<Map<dynamic, dynamic>> smallbuttonlist = [
    ({
      "title": "Accredited Travel Agencies",
      "dataref": "travelagencies",
      "imgname": "travelagencies.png",
      "icnname": LineIcons.plane
    }),
    ({
      "title": "Accredited Tour Guides",
      "dataref": "tourguides",
      "imgname": "tourguides.png",
      "icnname": LineIcons.flag
    }),
  ];

  //fetch promotional data from firebase
  fetchPromotionImages() async {
    var firestoreInstance = FirebaseFirestore.instance;
    QuerySnapshot qn = await firestoreInstance.collection('promotions').get();
    for (int i = 0; i < qn.docs.length; i++) {
      _promotionImages.add(qn.docs[i]['imagelink']);
      //print(qn.docs[i]['imagelink']);
    }
  }

  @override
  void initState() {
    fetchPromotionImages();
    super.initState();
  }

  final PageController controller = PageController();

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
                                  items: _promotionImages
                                      .map(
                                        (item) => Stack(
                                          children: [
                                            Shimmer.fromColors(
                                                highlightColor: Colors.white,
                                                baseColor: Appcolor.background,
                                                child: Container(
                                                    height: 350,
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    color: Colors.white)),
                                            Container(
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: NetworkImage(item),
                                                      fit: BoxFit.fitHeight)),
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
                          Positioned(
                            bottom: 10,
                            left: 0,
                            right: 0,
                            child: Center(
                              child: DotsIndicator(
                                dotsCount: _promotionImages.isEmpty
                                    ? 1
                                    : _promotionImages.length,
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
                      const Text(
                        "PROJECT BIG A",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Appcolor.bluecolor1,
                            fontSize: 42,
                            fontWeight: FontWeight.w800),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Column(
                        children: const [
                          Text(
                              "Boracay Online Application Centralized\n Information Guide",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color.fromARGB(255, 77, 77, 77),
                                fontSize: 18,
                              )),
                        ],
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 30),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Explore",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: Appcolor.grey3,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w800)),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      GridView.count(
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(10),
                        shrinkWrap: true,
                        childAspectRatio: 0.8,
                        crossAxisCount: 2,
                        children:
                            List.generate(largebuttonlist.length, (index) {
                          return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ListPage(
                                            selectedCategory:
                                                largebuttonlist[index]
                                                    ['dataref'],
                                          )),
                                );
                              },
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Stack(
                                    children: [
                                      Container(
                                        height: 200,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                    2 -
                                                35,
                                        color: Colors.white,
                                        child: Center(
                                          child: LoadingAnimationWidget
                                              .bouncingBall(
                                            color: Appcolor.bluecolor1,
                                            size: 25,
                                          ),
                                        ),
                                      ),
                                      Stack(
                                        children: [
                                          Container(
                                            height: 200,
                                            width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2 -
                                                35,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: AssetImage(
                                                        'assets/images/${largebuttonlist[index]["imgname"]}'),
                                                    fit: BoxFit.cover),
                                                color: Colors.black,
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                          ),
                                          Positioned.fill(
                                            child: Container(
                                              height: 200,
                                              width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      2 -
                                                  35,
                                              decoration: BoxDecoration(
                                                  gradient:
                                                      const LinearGradient(
                                                    begin: Alignment.topCenter,
                                                    end: Alignment.bottomCenter,
                                                    colors: [
                                                      Colors.transparent,
                                                      Colors.transparent,
                                                      Colors.transparent,
                                                      Appcolor.grey3,
                                                    ],
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                            ),
                                          ),
                                          Positioned(
                                            bottom: 10,
                                            left: 10,
                                            right: 10,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                    "${largebuttonlist[index]["title"]}",
                                                    textAlign: TextAlign.start,
                                                    style: const TextStyle(
                                                        color:
                                                            Appcolor.background,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w700)),
                                              ],
                                            ),
                                          ),
                                          Positioned(
                                            top: 10,
                                            right: 10,
                                            child: Icon(
                                              largebuttonlist[index]["icnname"],
                                              color: Colors.white,
                                              size: 20,
                                              shadows: const <Shadow>[
                                                Shadow(
                                                    color: Colors.black,
                                                    blurRadius: 15.0)
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ));
                        }),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 30),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Travel Needs",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: Appcolor.grey3,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w800)),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GridView.count(
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(10),
                        shrinkWrap: true,
                        childAspectRatio: 0.8,
                        crossAxisCount: 2,
                        children:
                            List.generate(smallbuttonlist.length, (index) {
                          return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ListPage(
                                            selectedCategory:
                                                smallbuttonlist[index]
                                                    ['dataref'],
                                          )),
                                );
                              },
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Stack(
                                    children: [
                                      Container(
                                        height: 200,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                    2 -
                                                35,
                                        color: Colors.white,
                                        child: Center(
                                          child: LoadingAnimationWidget
                                              .bouncingBall(
                                            color: Appcolor.bluecolor1,
                                            size: 25,
                                          ),
                                        ),
                                      ),
                                      Stack(
                                        children: [
                                          Container(
                                            height: 200,
                                            width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2 -
                                                35,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: AssetImage(
                                                        'assets/images/${smallbuttonlist[index]["imgname"]}'),
                                                    fit: BoxFit.cover),
                                                color: Colors.black,
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                          ),
                                          Positioned.fill(
                                            child: Container(
                                              height: 200,
                                              width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      2 -
                                                  35,
                                              decoration: BoxDecoration(
                                                  gradient:
                                                      const LinearGradient(
                                                    begin: Alignment.topCenter,
                                                    end: Alignment.bottomCenter,
                                                    colors: [
                                                      Colors.transparent,
                                                      Colors.transparent,
                                                      Colors.transparent,
                                                      Appcolor.grey3,
                                                    ],
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                            ),
                                          ),
                                          Positioned(
                                            bottom: 10,
                                            left: 10,
                                            right: 10,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                    "${smallbuttonlist[index]["title"]}",
                                                    textAlign: TextAlign.start,
                                                    style: const TextStyle(
                                                        color:
                                                            Appcolor.background,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w700)),
                                              ],
                                            ),
                                          ),
                                          Positioned(
                                            top: 10,
                                            right: 10,
                                            child: Icon(
                                              smallbuttonlist[index]["icnname"],
                                              color: Colors.white,
                                              size: 20,
                                              shadows: const <Shadow>[
                                                Shadow(
                                                    color: Colors.black,
                                                    blurRadius: 15.0)
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ));
                        }),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                ),
              ]),
            )),
      ),
    );
  }
}
