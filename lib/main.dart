import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:projectbiga/SplashPage.dart';
import 'package:projectbiga/mainpage.dart';
import 'package:projectbiga/home/homepage.dart';
import 'package:projectbiga/home/itempage.dart';
import 'package:projectbiga/services/getdatamodel.dart';
import 'package:projectbiga/services/itempagservice.dart';
import 'package:provider/provider.dart';

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
              '/accommodations': (context) => const ItemPage(),
            }),
      ),
    );
  }
}
