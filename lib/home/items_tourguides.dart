import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:projectbiga/models/largelistmodel.dart';
import 'package:projectbiga/models/smalllistmodel.dart';
import 'package:projectbiga/services/itempagservice.dart';
import 'package:provider/provider.dart';

import '../models/appcolor.dart';

class TourGuidesItemsPage extends StatefulWidget {
  const TourGuidesItemsPage({super.key});

  @override
  State<TourGuidesItemsPage> createState() => _TourGuidesItemsPageState();
}

class _TourGuidesItemsPageState extends State<TourGuidesItemsPage> {
  @override
  Widget build(BuildContext context) {
    ItemPageService itemdata =
        Provider.of<ItemPageService>(context, listen: false);

    List<SmallListModel> itemlist = itemdata.getTourGuideItems();

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
                child: ListView.builder(
                    itemCount: itemlist.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        padding: const EdgeInsets.all(20),
                        margin: const EdgeInsets.only(
                            left: 20, right: 20, top: 10, bottom: 10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 2,
                                blurRadius: 3,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                            borderRadius: BorderRadius.circular(5)),
                        child: Row(
                          children: [
                            Flexible(
                              flex: 1,
                              child: Row(
                                children: [
                                  itemlist[index].image1 == "none"
                                      ? ClipOval(
                                          child: Image.network(
                                          "https://firebasestorage.googleapis.com/v0/b/project-big-a-16ca5.appspot.com/o/tourguides%2Fmaltoa%2F302035363_103637019149767_4017422460466057100_n.jpg?alt=media&token=023ef776-403e-4880-89cd-03da0558bc5a",
                                          height: 50,
                                          width: 50,
                                          fit: BoxFit.cover,
                                        ))
                                      : ClipOval(
                                          child: Image.network(
                                          "${itemlist[index].image1}",
                                          height: 50,
                                          width: 50,
                                          fit: BoxFit.cover,
                                        )),
                                  const SizedBox(
                                    width: 5,
                                  ),

                                  /*IconButton(
                                    icon: itemlist[index]
                                            .website
                                            .contains('facebook')
                                        ? const Icon(LineIcons.facebook)
                                        : const Icon(LineIcons.globe),
                                    iconSize: 30,
                                    onPressed: () {},
                                  )*/
                                ],
                              ),
                            ),
                            Flexible(
                              flex: 3,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("${itemlist[index].name}",
                                      textAlign: TextAlign.start,
                                      style: const TextStyle(
                                        color: Appcolor.grey3,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                      )),
                                  Text("${itemlist[index].address}",
                                      textAlign: TextAlign.start,
                                      style: const TextStyle(
                                        color: Appcolor.grey3,
                                        fontSize: 12,
                                      )),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
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
}
