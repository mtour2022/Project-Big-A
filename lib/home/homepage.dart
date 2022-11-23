import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shimmer/shimmer.dart';
import '../models/appcolor.dart';

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

  //fetch promotional data from firebase
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
                          Stack(
                            children: [
                              Container(
                                height: 350,
                                width: MediaQuery.of(context).size.width,
                                color: Colors.white,
                                child: Center(
                                  child: LoadingAnimationWidget.bouncingBall(
                                    color: Appcolor.bluecolor1,
                                    // leftDotColor: const Color(0xFF1A1A3F),
                                    //rightDotColor: const Color(0xFFEA3799),
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
                                        /*Container(
                                              decoration: BoxDecoration(
                                                  /*image: DecorationImage(
                                                    
                                                      image:   NetworkImage(item),
                                                      fit: BoxFit.fitHeight)*/),
                                                      child:  
                                            )*/
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
                        height: 25,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed('/accommodations');
                              },
                              child: buildCardWidget(
                                  imagelink: 'accommodations.png',
                                  title: 'Accredited\nAccommodations',
                                  iconval: LineIcons.bed,
                                  context: context),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushNamed('/restaurants');
                              },
                              child: buildCardWidget(
                                  imagelink: 'restaurants.png',
                                  title: 'Accredited\nRestaurants',
                                  iconval: LineIcons.utensils,
                                  context: context),
                            ),
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
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushNamed('/attractions');
                              },
                              child: buildCardWidget(
                                  imagelink: 'attractions.png',
                                  title: 'Attractions\nTo See',
                                  iconval: LineIcons.binoculars,
                                  context: context),
                            ),
                            buildCardWidget(
                                imagelink: 'activities.png',
                                title: 'Activities\nto Experience',
                                iconval: LineIcons.swimmer,
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
                                iconval: LineIcons.plane,
                                context: context),
                            buildCardWidget(
                                imagelink: 'tourguides.png',
                                title: 'Accredited\nTour Guides',
                                iconval: LineIcons.flag,
                                context: context),
                          ],
                        ),
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

Widget buildCardWidget(
    {required String imagelink,
    required String title,
    required IconData iconval,
    context}) {
  return Stack(
    children: [
      Container(
        height: 200,
        width: MediaQuery.of(context).size.width / 2 - 35,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/$imagelink'),
                fit: BoxFit.cover),
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
      Positioned(
        top: 10,
        right: 10,
        child: Icon(
          iconval,
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
