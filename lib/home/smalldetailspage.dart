import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:projectbiga/models/largelistmodel.dart';
import 'package:projectbiga/models/smalllistmodel.dart';
import 'package:projectbiga/services/itempagservice.dart';
import 'package:projectbiga/widgets/topnavigationbar.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../models/appcolor.dart';

class SmallDetailsPage extends StatefulWidget {
  LargeListModel itemdetails;
  SmallDetailsPage({required this.itemdetails, super.key});

  @override
  State<SmallDetailsPage> createState() => _SmallDetailsPageState();
}

class _SmallDetailsPageState extends State<SmallDetailsPage> {
  late List<String> listitem = <String>[];
  var _dotPosition = 0;
  @override
  void initState() {
    listitem.add(widget.itemdetails.image1);
    listitem.add(widget.itemdetails.image2);
    listitem.add(widget.itemdetails.image3);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                                // leftDotColor: const Color(0xFF1A1A3F),
                                //rightDotColor: const Color(0xFFEA3799),
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
                            dotsCount:
                                listitem.length == 0 ? 1 : listitem.length,
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
                        Text(
                          "${widget.itemdetails.address}",
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
                        /* Text(
                          widget.itemdetails.description,
                          style: const TextStyle(
                            color: Appcolor.grey2,
                            fontSize: 14,
                          ),
                        ),*/
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 500,
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
                        offset: Offset(3, 0), // changes position of shadow
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
                    onPressed: () {},
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
