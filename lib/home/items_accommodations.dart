import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:projectbiga/models/largelistmodel.dart';
import 'package:projectbiga/services/itempagservice.dart';
import 'package:provider/provider.dart';

import '../models/appcolor.dart';
import 'largedetailspage.dart';

class AccommodationsItemsPage extends StatefulWidget {
  const AccommodationsItemsPage({super.key});

  @override
  State<AccommodationsItemsPage> createState() =>
      _AccommodationsItemsPageState();
}

class _AccommodationsItemsPageState extends State<AccommodationsItemsPage> {
  @override
  Widget build(BuildContext context) {
    ItemPageService itemdata =
        Provider.of<ItemPageService>(context, listen: false);

    List<LargeListModel> itemlist = itemdata.getaccommodations();

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
                    children: List.generate(itemlist.length, (index) {
                      return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LargeDetailsPage(
                                        itemdetails: itemlist[index],
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
                                      title: itemlist[index].name,
                                      imagelink: itemlist[index].image1,
                                      classval: itemlist[index].classval,
                                      address: itemlist[index].address,
                                      iconval: LineIcons.bed,
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
      required IconData iconval,
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
              Text("??? $classval",
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
}
