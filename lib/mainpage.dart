import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:projectbiga/bag/bagpage.dart';
import 'package:projectbiga/callpage/callpage.dart';
import 'package:projectbiga/home/homepage.dart';
import 'package:projectbiga/home/items_accommodations.dart';
import 'package:projectbiga/read/readpage.dart';
import 'package:projectbiga/services/itempagservice.dart';
import 'package:projectbiga/widgets/topnavigationbar.dart';
import 'package:provider/provider.dart';

import 'models/appcolor.dart';

class MainPage extends StatefulWidget {
  int currentIndex;

  MainPage({this.currentIndex = 0});
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          /* drawer: Container(
            width: MediaQuery.of(context).size.width * 0.60,
            child: Drawer(elevation: 6, child: SideMenuBar())),*/
          body: Stack(children: [
            buildPages(),
            const Positioned(
                top: 0, right: 0, left: 0, child: TopNavigationBar()),
            /*Positioned(
            bottom: 6,
            right: 20,
            left: 20,
            child: PhysicalModel(
              color: Colors.transparent,
              elevation: 8,
              shadowColor: Colors.grey[300],
              borderRadius: BorderRadius.circular(50),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: BottomNavyBar(
                    iconSize: 30,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    backgroundColor: Colors.white,
                    containerHeight: 68,
                    itemCornerRadius: 50,
                    selectedIndex: widget.currentIndex,
                    onItemSelected: (index) {
                      setState(() => widget.currentIndex = index);
                    },
                    items: <BottomNavyBarItem>[
                      BottomNavyBarItem(
                        icon: Icon(CupertinoIcons.compass, size: 30),
                        title: Text('Explore'),
                        textAlign: TextAlign.center,
                        activeColor: Colors.blue,
                        inactiveColor: Colors.blue[200],
                      ),
                      BottomNavyBarItem(
                        icon: Icon(CupertinoIcons.calendar, size: 30),
                        title: Text('Itinerary'),
                        textAlign: TextAlign.center,
                        activeColor: Colors.blue,
                        inactiveColor: Colors.blue[200],
                      ),
                      BottomNavyBarItem(
                        icon: Icon(CupertinoIcons.bag, size: 30),
                        /*icon: SvgPicture.asset(
                          'assets/icons/' + AppIcons.BagIcon + '.svg',
                          color: Colors.blue,
                          height: 30,
                          width: 30,
                        ),*/
                        title: Text('Bag'),
                        textAlign: TextAlign.center,
                        activeColor: Colors.blue,
                        inactiveColor: Colors.blue[200],
                      ),
                      BottomNavyBarItem(
                        icon: Icon(CupertinoIcons.bag, size: 30),
                        /*icon: SvgPicture.asset(
                          'assets/icons/' + AppIcons.BagIcon + '.svg',
                          color: Colors.blue,
                          height: 30,
                          width: 30,
                        ),*/
                        title: Text('Essentials'),
                        textAlign: TextAlign.center,
                        activeColor: Colors.blue,
                        inactiveColor: Colors.blue[200],
                      ),
                    ]),
              ),
            ),
          )*/
          ]),
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
                        selectedIndex: widget.currentIndex,
                        /*onTabChange: (index) {
                          setState(() {
                            _selectedIndex = index;
                          });
                        },*/

                        onTabChange: (index) {
                          setState(() => widget.currentIndex = index);
                        },
                      ))))),
    );
  }

  Widget buildPages() {
    switch (widget.currentIndex) {
      case 1:
        return BagPage();
      case 2:
        return ReadPage();
      case 3:
        return CallPage();
      case 0:
      default:
        return HomePage();
    }
  }
}
