import 'package:db_minar/QuotesApp/Controller/quotesController.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../QuotesApp/View/EditPage/editPageController.dart';


int selectedIndex = 0;
String compare = '';

Row heading(String category,double width) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(category,
          style: TextStyle(
              fontFamily: 'poppins', fontSize: width * 0.051, fontWeight: FontWeight.bold)),
      Text('See all',
          style: TextStyle(
              fontFamily: 'poppins', fontSize: width * 0.04, fontWeight: FontWeight.w500)),
    ],
  );
}

Column buildCategory(double height, double width, String img, String categoryName) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        alignment: Alignment.bottomLeft,
        height: height * 0.148,
        width: width/2.3,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(img)),
            borderRadius: BorderRadius.circular(10)
        ),
      ),
      const SizedBox(height: 8),
      Text(categoryName,style: TextStyle(fontFamily: 'poppins',fontWeight: FontWeight.w500,fontSize: width * 0.038),),
    ],
  );
}

void showMsg(String msg){
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.black,
    textColor: Colors.white,
    fontSize: 16,
  );
}

List wallPaperImgList = [
  'assets/image/WallpaperImages/38.jpg',
  'assets/image/WallpaperImages/37.jpg',
  'assets/image/WallpaperImages/6.jpg',
  'assets/image/WallpaperImages/41.jpg',
  'assets/image/WallpaperImages/42.jpg',
  'assets/image/WallpaperImages/43.jpg',
  'assets/image/WallpaperImages/44.jpg',
  'assets/image/WallpaperImages/45.jpg',
  'assets/image/WallpaperImages/46.jpg',
  'assets/image/WallpaperImages/13.jpg',
  'assets/image/WallpaperImages/14.jpg',
  'assets/image/WallpaperImages/15.jpg',
  'assets/image/WallpaperImages/22.jpg',
  'assets/image/WallpaperImages/23.jpg',
  'assets/image/WallpaperImages/24.jpg',
  'assets/image/WallpaperImages/26.jpg',
  'assets/image/WallpaperImages/1.jpg',
  'assets/image/WallpaperImages/2.jpg',
  'assets/image/WallpaperImages/4.jpg',
  'assets/image/WallpaperImages/5.jpg',
  'assets/image/WallpaperImages/39.jpg',
  'assets/image/WallpaperImages/7.jpg',
  'assets/image/WallpaperImages/8.jpg',
  'assets/image/WallpaperImages/9.jpg',
  'assets/image/WallpaperImages/10.jpg',
  'assets/image/WallpaperImages/27.jpg',
  'assets/image/WallpaperImages/28.jpg',
  'assets/image/WallpaperImages/29.jpg',
  'assets/image/WallpaperImages/30.jpg',
  'assets/image/WallpaperImages/31.jpg',
  'assets/image/WallpaperImages/32.jpg',
  'assets/image/WallpaperImages/40.jpg',
  'assets/image/WallpaperImages/11.jpg',
  'assets/image/WallpaperImages/12.jpg',
  'assets/image/WallpaperImages/33.jpg',
  'assets/image/WallpaperImages/34.jpg',
  'assets/image/WallpaperImages/35.jpg',
  'assets/image/WallpaperImages/36.jpg',
];

List fonts = [
  'al',
  'ch',
  'co',
  'fu',
  'ha',
  'mo',
  'sc',
  'tr'
];