import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:projectbiga/SplashPage.dart';
import 'package:projectbiga/home/attractions/items_attractions.dart';
import 'package:projectbiga/home/restaurants/items_restaurants.dart';
import 'package:projectbiga/mainpage.dart';
import 'package:projectbiga/home/homepage.dart';
import 'package:projectbiga/home/accommodations.dart/items_accommodations.dart';
import 'package:projectbiga/services/getdatamodel.dart';
import 'package:projectbiga/services/itempagservice.dart';
import 'package:provider/provider.dart';

import 'home/activities/items_activities.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        //import instances from provider firebase
        ChangeNotifierProvider(create: (_) => ItemPageService()),
      ],
      child: OverlaySupport.global(
        child: MaterialApp(
            title: 'Automation System For Seemless Tourist Fee Computation',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                primarySwatch: Colors.blue, fontFamily: 'ProductSans'),
            // home: HomePage(),
            initialRoute: '/',
            routes: {
              '/': (context) => SplashPage(),
              '/mainpage': (context) => MainPage(),
              '/accommodations': (context) => const AccommodationsItemsPage(),
              '/restaurants': (context) => const RestaurantsItemsPage(),
              '/attractions': (context) => const AttractionsItemsPage(),
              '/activities': (context) => const ActivitiesItemsPage(),
            }),
      ),
    );
  }
}
