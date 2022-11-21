import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';

import '../models/appcolor.dart';
import '../models/datamodel.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Home',
      style: optionStyle,
    ),
    Text(
      'Likes',
      style: optionStyle,
    ),
    Text(
      'Search',
      style: optionStyle,
    ),
    Text(
      'Profile',
      style: optionStyle,
    ),
  ];
  var _dotPosition = 0;
  List<String> _promotionImages = [];

  fetchPromotionImages() async {
    var _firestoreInstance = FirebaseFirestore.instance;
    QuerySnapshot qn = await _firestoreInstance.collection('promotions').get();
    for (int i = 0; i < qn.docs.length; i++) {
      _promotionImages.add(qn.docs[i]['imagelink']);
      print(qn.docs[i]['imagelink']);
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
                            CarouselSlider(
                                items: _promotionImages
                                    .map((item) => Container(
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: NetworkImage(item),
                                                  fit: BoxFit.fitHeight)),
                                        ))
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
                            Positioned(
                              bottom: 10,
                              left: 0,
                              right: 0,
                              child: Center(
                                child: DotsIndicator(
                                  dotsCount: _promotionImages.length == 0
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
                                  color: Appcolor.grey3,
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
                          height: 25,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              buildCardWidget(
                                  imagelink: 'accommodations.png',
                                  title: 'Accredited\nAccommodations',
                                  context: context),
                              buildCardWidget(
                                  imagelink: 'restaurants.png',
                                  title: 'Accredited\nRestaurants',
                                  context: context),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              buildCardWidget(
                                  imagelink: 'attractions.png',
                                  title: 'Attractions\nTo See',
                                  context: context),
                              buildCardWidget(
                                  imagelink: 'activities.png',
                                  title: 'Activities\nto Experience',
                                  context: context),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              buildCardWidget(
                                  imagelink: 'travelagencies.png',
                                  title: 'Accredited\nTravel Agencies',
                                  context: context),
                              buildCardWidget(
                                  imagelink: 'tourguides.png',
                                  title: 'Accredited\nTour Guides',
                                  context: context),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 100,
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 10),
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
          bottomNavigationBar: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 20,
                    color: Colors.black.withOpacity(.1),
                  )
                ],
              ),
              child: SafeArea(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 8),
                      child: GNav(
                        // rippleColor: Colors.grey[300]!,
                        hoverColor: Colors.grey[100]!,
                        gap: 8,
                        activeColor: Appcolor.bluecolor1,
                        iconSize: 24,
                        tabBorderRadius: 10,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 12),
                        duration: const Duration(milliseconds: 400),
                        tabBackgroundColor: Colors.grey[100]!,
                        color: Appcolor.grey1,

                        tabs: const [
                          GButton(
                            icon: LineIcons.compass,
                            text: 'Explore',
                          ),
                          GButton(
                            icon: LineIcons.briefcase,
                            text: 'Bag',
                          ),
                          GButton(
                            icon: LineIcons.glasses,
                            text: 'Read',
                          ),
                          GButton(
                            icon: LineIcons.phone,
                            text: 'Call',
                          ),
                        ],
                        selectedIndex: _selectedIndex,
                        onTabChange: (index) {
                          setState(() {
                            _selectedIndex = index;
                          });
                        },
                      ))))),
    );
  }
}

Widget buildCardWidget(
    {required String imagelink, required String title, context}) {
  return Stack(
    children: [
      Container(
        height: 200,
        width: MediaQuery.of(context).size.width / 2 - 35,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/$imagelink'),
                fit: BoxFit.fitHeight),
            color: Colors.black,
            borderRadius: BorderRadius.circular(5)),
      ),
      Positioned.fill(
        child: Container(
          height: 200,
          width: MediaQuery.of(context).size.width / 2 - 35,
          decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.transparent,
                  Colors.transparent,
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
            Text("$title",
                textAlign: TextAlign.start,
                style: const TextStyle(
                    color: Appcolor.background,
                    fontSize: 14,
                    fontWeight: FontWeight.w700)),
          ],
        ),
      ),
    ],
  );
}
