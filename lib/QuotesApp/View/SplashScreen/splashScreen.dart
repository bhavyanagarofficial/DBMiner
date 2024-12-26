import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controller/quotesController.dart';
import '../../Model/quotesModel.dart';
import '../HomePage/homePage.dart';

double width = 0;

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  Animation<double>? animation;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 4));
    animation = Tween<double>(begin: 0, end: 0).animate(animationController!);

    animationController!.addListener(() {
      setState(() {});
    });
    animationController!.forward();
    fetchDataAndNavigate();
  }

  Future<void> fetchDataAndNavigate() async {
    QuotesController quotesController = Get.put(QuotesController());
    try {
      List<QuotesModel>? dataList = await quotesController.fetchApiData();
      if (dataList != null) {
        Get.off(() => HomePage());
      } else {
        print('Loading......');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    QuotesController quotesController = Get.put(QuotesController());
    List<QuotesModel>? dataList = [];
    width = MediaQuery.of(context).size.width;
    animation = Tween<double>(begin: width * 0.062, end: width * 0.11).animate(animationController!);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black87,
        body: Center(
          child: Text(
          'Quotes',
          style: TextStyle(
            fontSize: animation!.value,
            color: Colors.white,
            fontFamily: 'poppins',
          ),
                      ),
        ),
      ),
    );
  }
}

