import 'package:db_minar/QuotesApp/Model/quotesModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Controller/quotesController.dart';

class LikedQuotesPage extends StatelessWidget {
  final String category;
  final List<QuotesModel> quotes;
  final String? bgImg;

  const LikedQuotesPage({super.key, required this.category, required this.quotes, required this.bgImg});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    QuotesController quotesController = Get.put(QuotesController());
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                    opacity: 0.9,
                    fit: BoxFit.cover,
                      image: AssetImage(bgImg!))
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Align(
                alignment: Alignment.topLeft,
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.19),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.arrow_back_ios,color: Colors.white,),
                    onPressed: () {Navigator.pop(context);
                    },
                  ),
                ),
              ),
            ),
            PageView.builder(
              scrollDirection: Axis.vertical,
              itemCount: quotes.length,
              itemBuilder: (context, index) {
                var quote = quotes[index];
                var quoteIndex = quotesController.likedQuotes.indexOf(quote);
                return SizedBox(
                  height: height,
                  width: width,
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: height * 0.255,bottom: height * 0.1,left: width * 0.04),//l and r: width * 0.019
                            width: width * 0.8,
                            // color: Colors.blue,
                            child:Text(
                                quote.quote,
                                style: TextStyle(
                                    shadows: const [
                                      Shadow(
                                        offset: Offset(-2, -2),
                                        blurRadius: 50,
                                        color: Colors.black87,
                                      ),
                                      Shadow(
                                        offset: Offset(3, 3),
                                        blurRadius: 12,
                                        color: Colors.black87,
                                      ),
                                    ],
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: width * 0.055,
                                    fontFamily:'poppins'),
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
                                  Text(
                                      '- ${quote.author}',
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
                                        color: Colors.white,
                                        fontSize: width * 0.055,
                                        fontFamily: 'poppins',
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FontStyle.italic,
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
                        padding: const EdgeInsets.all(12),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withOpacity(0.18),
                            ),
                            child: IconButton(
                            icon: Icon(Icons.delete,color: Colors.white,),
                              onPressed: () {
                                quotesController.toggleLike(quote, quoteIndex);
                                quotesController.updateLikeBtn(quote,quoteIndex);
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}