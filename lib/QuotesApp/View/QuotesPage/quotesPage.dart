import 'dart:io';

import 'package:circular_menu/circular_menu.dart';
import 'package:db_minar/Components/components.dart';
import 'package:db_minar/QuotesApp/Controller/quotesController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_extend/share_extend.dart';
import '../BookMarkPage/bookMarkPage.dart';
import '../EditPage/editPage.dart';
import '../EditPage/editPageController.dart';
import 'dart:ui' as ui;

class QuotesPage extends StatefulWidget {
  String category;
  QuotesPage({super.key,required this.category});

  @override
  State<QuotesPage> createState() => _QuotesPageState();
}

class _QuotesPageState extends State<QuotesPage> {
  QuotesController quotesController = Get.put(QuotesController());
  @override
  void initState(){
    WidgetsBinding.instance.addPostFrameCallback((_) {
      quotesController.fetchQuotesByCategory(widget.category);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    PageController pageController = PageController();
    EditPageController editPageController = Get.put(EditPageController());
    QuotesController quotesController = Get.put(QuotesController());
    editPageController.bgImg.value = wallPaperImgList[0];
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Stack(
                children: [
                  RepaintBoundary(
                  key: imgKey,
                    child: Obx(
                      () => saveAndShare(height, width, editPageController, quotesController, pageController),
            ),
          ),
          Obx(
                () => Container(
                  height: height,
                  width: width,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(editPageController.bgImg.value))),
                child: Align(
                  alignment: Alignment.center,
                  child: PageView.builder(
                    onPageChanged: (index) {
                      quotesController.changeQuoteIndex(index);
                    },
                    controller: pageController,
                    scrollDirection: Axis.vertical,
                    itemCount: quotesController.dataList.length,
                    itemBuilder: (context, index){
                      final quotes = quotesController.dataList[index];
                      return SizedBox(
                        height: height,
                        width: width,
                        child: Stack(
                          children: [
                            Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: height * 0.246,bottom: height * 0.089),
                                  width: width * 0.8,
                                  child: Obx(
                                    () =>  Text(
                                      textAlign: TextAlign.center,
                                      quotes.quote,
                                      style: TextStyle(
                                          shadows: const [
                                            Shadow(
                                              offset: Offset(-2, -2),
                                              blurRadius: 12,
                                              color: Colors.black54,
                                            ),
                                            Shadow(
                                              offset: Offset(3, 3),
                                              blurRadius: 12,
                                              color: Colors.black54,
                                            ),
                                          ],
                                          color:editPageController.changeTextColor.value,
                                          fontWeight: FontWeight.w500,
                                          fontSize: width * 0.055,
                                          fontFamily: editPageController.selectedFonts.value),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Padding(
                                    padding: EdgeInsets.only(right: width * 0.04),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Obx(
                                          () => Text(
                                            '- ${quotes.author}',
                                            style: TextStyle(
                                                shadows: const [
                                                  Shadow(
                                                    offset: Offset(-2, -2),
                                                    blurRadius: 11,
                                                    color: Colors.black54,
                                                  ),
                                                  Shadow(
                                                    offset: Offset(3, 3),
                                                    blurRadius: 11,
                                                    color: Colors.black54,
                                                  ),
                                                ],
                                                color: editPageController.changeTextColor.value,
                                                fontSize: width * 0.055,
                                                fontFamily: editPageController
                                                    .selectedFonts.value,
                                                fontWeight: FontWeight.w500,
                                                fontStyle: FontStyle.italic,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 1,
                                          margin: const EdgeInsets.only(top: 2),
                                          width: 110,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: height * 0.115),
                              child: CircularMenu(
                                      alignment: Alignment.bottomCenter,
                                      curve: Curves.bounceInOut,
                                      toggleButtonColor: Colors.white.withOpacity(0.14),
                                      reverseCurve: Curves.bounceInOut,
                                      toggleButtonIconColor: Colors.white,
                                      items: [
                                        CircularMenuItem(
                                          onTap: () {
                                          showModalBottomSheet(
                                              context: context,
                                              builder: (context) {
                                                return Container(
                                                    height: 100,
                                                    width: width,
                                                    decoration: const BoxDecoration(
                                                        borderRadius: BorderRadius.only(topLeft: Radius.circular(16),topRight: Radius.circular(16)),
                                                        color: Colors.white
                                                    ),
                                                    padding: const EdgeInsets.all(10),
                                                    child: TextButton(
                                                      onPressed:() async {
                                                        RenderRepaintBoundary boundary = imgKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
                                                        ui.Image image = await boundary.toImage();
                                                        ByteData? byteData = await (image.toByteData(format: ui.ImageByteFormat.png));
                                                        Uint8List img = byteData!.buffer.asUint8List();final path = await getApplicationDocumentsDirectory();
                                                        File file = File("${path.path}/img.png");await file.writeAsBytes(img);
                                                        int location = WallpaperManager.BOTH_SCREEN;
                                                        bool result = await WallpaperManager.setWallpaperFromFile(file.path, location);
                                                        Get.back();
                                                        showMsg('Wallpaper Applied Successfully');
                                                      },
                                                      child: Text('Set Wallpaper',style: TextStyle(color: Colors.black87,fontFamily: 'poppins',fontSize: width * 0.05,fontWeight: FontWeight.w600),),));
                                              });
                                        }, icon: Icons.image_outlined,iconColor: Colors.white,color: Colors.white.withOpacity(0.13),),
                                        CircularMenuItem(onTap: () async {
                                          RenderRepaintBoundary boundary =
                                          imgKey.currentContext!
                                              .findRenderObject()
                                          as RenderRepaintBoundary;
                                          ui.Image image =
                                          await boundary.toImage();
                                          ByteData? byteData =
                                          await (image.toByteData(
                                              format: ui
                                                  .ImageByteFormat.png));
                                          Uint8List img =
                                          byteData!.buffer.asUint8List();
                                          ImageGallerySaver.saveImage(img);
                                          showMsg('Image Saved To Gallery');
                                        }, icon: Icons.file_download_outlined,iconColor: Colors.white,color: Colors.white.withOpacity(0.13),),
                                        CircularMenuItem(onTap: () async {
                                          RenderRepaintBoundary boundary =
                                          imgKey.currentContext!.findRenderObject()
                                          as RenderRepaintBoundary;
                                          ui.Image image =
                                          await boundary.toImage();
                                          ByteData? byteData =
                                          await (image.toByteData(format: ui.ImageByteFormat.png));
                                          Uint8List img = byteData!.buffer.asUint8List();
                                          final path = await getApplicationDocumentsDirectory();
                                          File file = File("${path.path}/img.png");
                                          file.writeAsBytes(img);
                                          ShareExtend.share(file.path, "image");
                                        }, icon: Icons.share,iconColor: Colors.white,color: Colors.white.withOpacity(0.13),),
                                        CircularMenuItem(onTap: (){Clipboard.setData(ClipboardData(text: quotesController.dataList[quotesController.currentQuoteIndex.value].quote));
                                        showMsg('Quote Copied to Clipboard');}, icon: Icons.copy,iconColor: Colors.white,color: Colors.white.withOpacity(0.13),),
                                        CircularMenuItem(onTap: (){
                                          quotesController.toggleLike(quotes,index);
                                            },icon: quotesController.dataList[index].isLiked == "1"
                                                ? Icons.favorite_rounded
                                                : Icons.favorite_outline_rounded,
                                              iconColor: quotesController.dataList[index].isLiked == "1"
                                                  ? Colors.red
                                                  : Colors.white,
                                              color: Colors.white.withOpacity(0.13),),
                                      ]),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                 ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(onTap: (){
                            Get.back();
                          },child: buildOption(Icons.home,' Home',width)),
                          GestureDetector(onTap: (){
                            Get.to(const EditPage(), transition: Transition.rightToLeft, duration: const Duration(milliseconds: 400));
                          },child: buildOption(Icons.photo_library_rounded,' Theme',width)),
                          GestureDetector(onTap: (){
                            Get.to(const BookMarkPage(), transition: Transition.rightToLeft, duration: const Duration(milliseconds: 400));
                          },child: buildOption(Icons.favorite_outline_rounded,' Favorites',width)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ]),
      ),
    );
  }

  Container saveAndShare(double height, double width, EditPageController editPageController, QuotesController quotesController, PageController pageController) {
    return Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(editPageController.bgImg.value))),
              child: Align(
                alignment: Alignment.center,
                child: PageView.builder(
                  onPageChanged: (index) {
                    quotesController.changeQuoteIndex(index);
                  },
                  controller: pageController,
                  scrollDirection: Axis.vertical,
                  itemCount: quotesController.dataList.length,
                  itemBuilder: (context, index) {
                    final quotes = quotesController.dataList[index];
                    return SizedBox(
                      height: height,
                      width: width,
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                    top: height * 0.246,
                                    bottom: height * 0.089),
                                width: width * 0.8,
                                child: Obx(
                                  () => Text(
                                    textAlign: TextAlign.center,
                                    quotes.quote,
                                    style: TextStyle(
                                        shadows: const [
                                          Shadow(
                                            offset: Offset(-2, -2),
                                            blurRadius: 12,
                                            color: Colors.black54,
                                          ),
                                          Shadow(
                                            offset: Offset(3, 3),
                                            blurRadius: 12,
                                            color: Colors.black54,
                                          ),
                                        ],
                                        color: editPageController
                                            .changeTextColor.value,
                                        fontWeight: FontWeight.w500,
                                        fontSize: width * 0.055,
                                        fontFamily: editPageController
                                            .selectedFonts.value),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(right: width * 0.04),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.end,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Obx(
                                        () => Text(
                                          '- ${quotes.author}',
                                          style: TextStyle(
                                            shadows: const [
                                              Shadow(
                                                offset: Offset(-2, -2),
                                                blurRadius: 11,
                                                color: Colors.black54,
                                              ),
                                              Shadow(
                                                offset: Offset(3, 3),
                                                blurRadius: 11,
                                                color: Colors.black54,
                                              ),
                                            ],
                                            color: editPageController
                                                .changeTextColor.value,
                                            fontSize: width * 0.055,
                                            fontFamily: editPageController
                                                .selectedFonts.value,
                                            fontWeight: FontWeight.w500,
                                            fontStyle: FontStyle.italic,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 1,
                                        margin: const EdgeInsets.only(top: 2),
                                        width: 110,
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            );
  }

  Container shareAndSaveImg(double height, double width,
      EditPageController editPageController, PageController pageController) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              opacity: 0.92,
              image: AssetImage(editPageController.bgImg.value))),
      child: Align(
        alignment: Alignment.center,
        child: PageView.builder(
          onPageChanged: (index) {
            quotesController.changeQuoteIndex(index);
          },
          controller: pageController,
          scrollDirection: Axis.vertical,
          itemCount: quotesController.dataList.length,
          itemBuilder: (context, index) {
            final quotes = quotesController.dataList[index];
            return SizedBox(
              height: height,
              width: width,
              child: Stack(
                children: [
                  Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            top: height * 0.255, bottom: height * 0.1),
                        width: width * 0.8,
                        child: Obx(
                          () => Text(
                            textAlign: TextAlign.center,
                            quotes.quote,
                            style: TextStyle(
                                shadows: const [
                                  Shadow(
                                    offset: Offset(-2, -2),
                                    blurRadius: 11,
                                    color: Colors.black54,
                                  ),
                                  Shadow(
                                    offset: Offset(3, 3),
                                    blurRadius: 11,
                                    color: Colors.black54,
                                  ),
                                ],
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: width * 0.055,
                                fontFamily:
                                    editPageController.selectedFonts.value),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: EdgeInsets.only(right: width * 0.04),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Obx(
                                () => Text(
                                  '- ${quotes.author}',
                                  style: TextStyle(
                                    shadows: const [
                                      Shadow(
                                        offset: Offset(-2, -2),
                                        blurRadius: 11,
                                        color: Colors.black54,
                                      ),
                                      Shadow(
                                        offset: Offset(3, 3),
                                        blurRadius: 11,
                                        color: Colors.black54,
                                      ),
                                    ],
                                    color: Colors.white,
                                    fontSize: width * 0.055,
                                    fontFamily:
                                        editPageController.selectedFonts.value,
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ),
                              Container(
                                height: 1,
                                margin: const EdgeInsets.only(top: 2),
                                width: 110,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
  Container buildOption(var icon,String data, double width) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.15),
          borderRadius: BorderRadius.circular(10)),
      padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 15 ),
      child: Row(
        children: [
          Icon(icon),
          Text(
            data,
            style: TextStyle(color: Colors.white, fontFamily: 'poppins',fontSize: width * 0.03),
          )
        ],
      ),
    );
  }
}

GlobalKey imgKey = GlobalKey();