import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:projectbiga/models/appcolor.dart';
import 'package:projectbiga/services/itempagservice.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class SplashPage extends StatelessWidget {
  const SplashPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    //retrieve instance of categoryservice
    ItemPageService itemService =
        Provider.of<ItemPageService>(context, listen: false);

    Future.delayed(Duration(seconds: 3), () async {
      //wait for the firebase initialization to occur if fetched start pulling data from online database
      FirebaseApp app = await Firebase.initializeApp();

      //fetch data from firebase
      itemService.getAccommodationCollectionFromFirebase().whenComplete(() {
        itemService.getRestaurantCollectionFromFirebase().whenComplete(() {
          itemService.getAttractionCollectionFromFirebase().whenComplete(() {
            itemService.getActivityCollectionFromFirebase().whenComplete(() {
              itemService
                  .getTravelAgencyCollectionFromFirebase()
                  .whenComplete(() {
                itemService
                    .getTourGuidesCollectionFromFirebase()
                    .whenComplete(() {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/mainpage', (Route<dynamic> route) => false);
                });
              });
            });
          });
        });
      });
    });

    return SafeArea(
        child: Scaffold(
            backgroundColor: Appcolor.background,
            body: Stack(children: [
              Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: <Color>[
                            Colors.white.withOpacity(0.5),
                            Colors.white.withOpacity(0.8),
                            Colors.white,
                            Colors.white,
                          ],
                        ),
                        //color: Colors.white.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Image.asset(
                        "assets/images/lgu.png",
                        height: 150,
                        width: 150,
                        fit: BoxFit.fitHeight,
                      ),
                    ),

                    //use SizedBox for spacing
                    SizedBox(height: 10),
                  ],
                ),
              ),
              const Align(
                alignment: Alignment.center,
                child: SizedBox(
                  height: 200,
                  width: 200,
                  child: CircularProgressIndicator(
                    strokeWidth: 5,
                    valueColor: AlwaysStoppedAnimation(
                      Appcolor.bluecolor1,
                    ),
                  ),
                ),
              )
            ])));
  }
}
