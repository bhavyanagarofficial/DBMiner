import 'package:animations/animations.dart';
import 'package:db_minar/Components/components.dart';
import 'package:db_minar/QuotesApp/View/LikedQuotes/likedQuotes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Controller/quotesController.dart';

class BookMarkPage extends StatelessWidget {
  const BookMarkPage({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    QuotesController quotesController = Get.put(QuotesController());
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 70,
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.arrow_back_ios)),
          title: const Text(
            'Favorites',
            style: TextStyle(fontFamily: 'poppins', letterSpacing: -1),
          ),
        ),
        body: Obx(() {
          if (quotesController.likedQuotes.isEmpty) {
            return Center(
              child: Text(
                'No liked quotes',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            );
          } else {
            var quotesByCategory = quotesController.categoriesOfLikedQuotes;
            return GridView.builder(
              shrinkWrap: true,
              itemCount: quotesByCategory.keys.length,
              itemBuilder: (context, index) {
                var category = quotesByCategory.keys.elementAt(index);
                var quotes = quotesByCategory[category]!;
                final img = quotesController.category.firstWhere(
                    (cat) => cat["category"] == category,
                    orElse: () => {'image': ''})["image"];
                final bgImg = quotesController.category.firstWhere(
                        (cat) => cat["category"] == category,
                    orElse: () => {'bgImg': ''})["bgImg"];
                // final img = quotesController.category.firstWhere((element) => ,);
                return OpenContainer(
                  transitionDuration: const Duration(milliseconds: 600),
                  openBuilder: (context, _) => LikedQuotesPage(category: category, quotes: quotes,bgImg : bgImg),
                  closedElevation: 0,
                  closedShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  closedColor: Theme.of(context).cardColor,
                  closedBuilder: (context, openContainer) => buildCategory(height, width, img, category)
                );
              }, gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            );
          }
        }),
      ),
    );
  }
}
