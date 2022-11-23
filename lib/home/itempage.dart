import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:projectbiga/models/accommodationsmodel.dart';
import 'package:projectbiga/services/itempagservice.dart';
import 'package:provider/provider.dart';

import '../models/appcolor.dart';

class ItemPage extends StatefulWidget {
  const ItemPage({super.key});

  @override
  State<ItemPage> createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  @override
  Widget build(BuildContext context) {
    ItemPageService itemdata =
        Provider.of<ItemPageService>(context, listen: false);

    List<AccommodationsModel> itemlist = itemdata.getItems();

    return Scaffold(
        body: Column(
      children: [
        Expanded(
          child: GridView.count(
              padding: EdgeInsets.all(10),
              shrinkWrap: true,
              childAspectRatio: 1,
              crossAxisCount: 2,
              children: List.generate(itemlist.length, (index) {
                return GestureDetector(
                    onTap: () {},
                    //user physicalmodel to add shadow in a combined widgets
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: buildCardWidget(
                            title: itemlist[index].name,
                            imagelink: itemlist[index].image1,
                            iconval: LineIcons.bed,
                            context: context),
                      ),
                    ));
              })),
        ),
      ],
    ));
  }

  Widget buildCardWidget(
      {required String imagelink,
      required String title,
      required IconData iconval,
      context}) {
    return Stack(
      children: [
        Container(
          height: 300,
          width: MediaQuery.of(context).size.width / 2 - 35,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage('$imagelink'), fit: BoxFit.cover),
              color: Colors.black,
              borderRadius: BorderRadius.circular(5)),
        ),
        Positioned.fill(
          child: Container(
            height: 300,
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
}
