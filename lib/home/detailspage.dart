import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:projectbiga/models/mediumlistmodel.dart';
import 'package:projectbiga/models/largelistmodel.dart';
import 'package:projectbiga/models/smalllistmodel.dart';
import 'package:projectbiga/services/itempagservice.dart';
import 'package:projectbiga/widgets/topnavigationbar.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../models/appcolor.dart';

class LargeDetailsPage extends StatefulWidget {
  LargeListModel itemdetails;
  LargeDetailsPage({required this.itemdetails, super.key});

  @override
  State<LargeDetailsPage> createState() => _LargeDetailsPageState();
}

class _LargeDetailsPageState extends State<LargeDetailsPage> {
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
                        Text(
                          "${widget.itemdetails.description}",
                          style: const TextStyle(
                            color: Appcolor.grey2,
                            fontSize: 14,
                          ),
                        ),
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
        ],
      )),
    );
  }
}
