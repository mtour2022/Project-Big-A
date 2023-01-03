import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:projectbiga/home/smalldetailspage.dart';
import 'package:projectbiga/models/largelistmodel.dart';
import 'package:projectbiga/models/smalllistmodel.dart';
import 'package:projectbiga/services/itempagservice.dart';
import 'package:provider/provider.dart';
import 'package:line_icons/line_icons.dart';
import '../models/appcolor.dart';
import 'largedetailspage.dart';

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

  @override
  void initState() {
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
              Expanded(
                child: GridView.count(
                    padding: EdgeInsets.all(10),
                    shrinkWrap: true,
                    childAspectRatio: 0.8,
                    crossAxisCount: 2,
                    children: List.generate(
                        largeitemlist.isNotEmpty
                            ? largeitemlist.length
                            : smallitemlist.length, (index) {
                      return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => largeitemlist.isNotEmpty
                                      ? LargeDetailsPage(
                                          itemdetails: largeitemlist[index],
                                        )
                                      : SmallDetailsPage(
                                          itemdetails: smallitemlist[index],
                                        )),
                            );
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
                                        // leftDotColor: const Color(0xFF1A1A3F),
                                        //rightDotColor: const Color(0xFFEA3799),
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
          )
        ],
      )),
    );
  }

  Widget buildCardWidget(
      {required String imagelink,
      required String title,
      required String address,
      required String classval,
      //required IconData iconval,
      context}) {
    return Stack(
      children: [
        Container(
          height: 200,
          width: MediaQuery.of(context).size.width / 2 - 35,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage('$imagelink'), fit: BoxFit.cover),
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
              Text("$title",
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
              Text("$address",
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
        /*Positioned(
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
        ),*/
      ],
    );
  }
}
