import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../../Components/components.dart';
import 'editPageController.dart';

class EditPage extends StatelessWidget {
  const EditPage({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    EditPageController editPageController = Get.put(EditPageController());
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black87,
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.arrow_back_ios)),
          title: const Text(
            'Theme',
            style: TextStyle(fontFamily: 'poppins', letterSpacing: -1),
          ),
        ),
        body: Stack(
          children: [
            Obx(
              () => Container(
                height: height,
                width: width,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(editPageController.bgImg.value))),
                child: ClipRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 12.0, sigmaY: 12.0),
                    child: Container(),
                  ),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CarouselSlider.builder(
                  itemCount: wallPaperImgList.length,
                  options: CarouselOptions(
                      height: height * 0.695,
                      // autoPlay: true,
                      // reverse: true,
                      // viewportFraction: 1,
                      pageSnapping: true,
                      enlargeCenterPage: true,
                      enableInfiniteScroll: true,
                      scrollPhysics: const BouncingScrollPhysics()),
                  itemBuilder: (context, index, realIndex) => GestureDetector(
                    onTap: () {
                      editPageController.changeBgImage(index);
                    },
                    child: Obx(
                      () => Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(top: 20, bottom: 8),
                        width: width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border:
                              (index == editPageController.selectedIndex.value)
                                  ? Border.all(color: Colors.white, width: 1.5)
                                  : null,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(wallPaperImgList[index]),
                          ),
                        ),
                        child: Text(
                          'ABCD',
                          style: TextStyle(
                            fontFamily: editPageController.selectedFonts.value,
                            color: editPageController.changeTextColor.value,
                            fontSize: width * 0.04,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Fonts',
                        style: TextStyle(
                            fontFamily: 'poppins', fontSize: width * 0.044),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            ...List.generate(
                              fonts.length,
                              (index) => TextButton(
                                onPressed: () {
                                  editPageController.changeFonts(fonts[index]);
                                },
                                child: Text(
                                  'Quotes',
                                  style: TextStyle(
                                      fontFamily: fonts[index],
                                      color: Colors.white,
                                      fontSize: width * 0.04),
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                editPageController.changeFonts('poppins');
                              },
                              child: Text(
                                'Default',
                                style: TextStyle(
                                    fontFamily: 'poppins',
                                    color: Colors.white,
                                    fontSize: width * 0.04),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 13,
                      ),
                      GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text(
                                      'Set Text Color',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    content: SingleChildScrollView(
                                      child: Obx(
                                        () => ColorPicker(
                                          pickerColor: editPageController.changeTextColor.value,
                                          onColorChanged: (Color value) {
                                            editPageController.changeColor(value);
                                          },
                                          pickerAreaHeightPercent: height * 0.001,
                                        ),
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text('Cancel')),
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text('OK')),
                                    ],
                                  );
                                });
                          },
                          child: Text(
                            'Change text color',
                            style: TextStyle(
                              decoration: TextDecoration.underline,

                                fontSize: width * 0.044, fontFamily: 'poppins'),
                          )),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
