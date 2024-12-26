import 'package:db_minar/QuotesApp/View/HomePage/homePage.dart';
import 'package:db_minar/QuotesApp/View/SplashScreen/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'QuotesApp/View/HomePage/tempFile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const Splashscreen(),
    );
  }
}