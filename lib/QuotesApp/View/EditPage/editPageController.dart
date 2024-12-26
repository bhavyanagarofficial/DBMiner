import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Components/components.dart';


class EditPageController extends GetxController{
  RxString bgImg = ''.obs,selectedFonts = 'poppins'.obs;
  RxInt selectedIndex = 0.obs,ck = 0.obs;
  var changeTextColor = Colors.white.obs;
  void changeBgImage(int index){
    bgImg.value = wallPaperImgList[index];
    selectedIndex.value = index;
  }

  void changeFonts(String selectedFont){
    selectedFonts.value = selectedFont;
  }

  void changeColor(var value) {
    changeTextColor.value = value;
  }
}