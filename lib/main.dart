// Project: Flutter App + Hashnode API
// Date created: Saturday, Dec ‎26, ‎2020
// Developer: Samuel Adekunle (acctgen1)
// First Launch: Wed, Jan 6th, 2021

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'functions/locator.dart';
import 'screens/homepage.dart';
import 'theme/colors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App + Hashnode API',
      theme: ThemeData( 
        primaryColor: AppColor().mainColor,
        accentColor: AppColor().mainColor,
        primaryIconTheme: IconThemeData(color: AppColor().mainColor),
        visualDensity: VisualDensity.comfortable,
      ),
      debugShowCheckedModeBanner: false,
      home: HomePgae(),
    );
  }
}
