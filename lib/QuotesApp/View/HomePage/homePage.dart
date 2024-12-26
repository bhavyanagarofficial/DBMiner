import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Components/components.dart';
import '../../Model/quotesModel.dart';
import '../QuotesPage/quotesPage.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.arrow_back_ios)),
          title: const Text(
            'Topics',
            style: TextStyle(fontFamily: 'poppins', letterSpacing: -1),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: ListView(
            children: [
              //todo ------------------------ Premium Box
              Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.symmetric(horizontal: 22),
                height: height * 0.12,
                width: width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: const DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/image/pr.jpeg'))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Go Premium',
                      style: TextStyle(
                          fontFamily: 'poppins',
                          fontSize: width * 0.047,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(width: 25),
                    const Icon(Icons.arrow_forward_ios)
                  ],
                ),
              ),
              //todo  ----------------------- Popular
              SizedBox(height: height * 0.038),
              heading('Most Popular', width),
              SizedBox(height: height * 0.015),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Column(
                      children: [
                        GestureDetector(
                            onTap: () {navigateToFilteredQuotesPage('Love');},
                            child: buildCategory(height, width, 'assets/image/HomePageCategorise/Popular/love.jpg', 'Love')),
                        const SizedBox(height: 10),
                        GestureDetector(
                            onTap: (){
                              navigateToFilteredQuotesPage('Life');
                              },child: buildCategory(height, width, 'assets/image/HomePageCategorise/Popular/life.jpg', 'Life')),
                      ],
                    ),
                    Column(
                      children: [
                        GestureDetector(onTap: (){navigateToFilteredQuotesPage('Motivation');},child: buildCategory(height, width, 'assets/image/HomePageCategorise/Popular/motivation.jpg', 'Motivation')),
                        const SizedBox(height: 10),
                        GestureDetector(onTap: (){navigateToFilteredQuotesPage('Work');},child: buildCategory(height, width, 'assets/image/HomePageCategorise/Popular/work.jpg', 'Work')),
                      ],
                    ),
                    Column(
                      children: [
                        GestureDetector(onTap: () {
                          navigateToFilteredQuotesPage('Mom');
                        },child: buildCategory(height, width, 'assets/image/HomePageCategorise/Popular/mom.jpg', 'Mom')),
                        const SizedBox(height: 12),
                        buildCategory(height, width, 'assets/image/HomePageCategorise/Popular/friends.jpg', 'Friends'),
                      ],
                    ),
                  ],
                ),
              ),
              // todo  ----------------------- Family
              SizedBox(height: height * 0.036),
              heading('Family', width),
              SizedBox(height: height * 0.015),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Column(
                      children: [
                        GestureDetector(onTap: (){
                          navigateToFilteredQuotesPage('Family');
                        },child: buildCategory(height, width, 'assets/image/HomePageCategorise/Family/family.jpg', 'Family')),
                        const SizedBox(height: 10),
                        GestureDetector(onTap: (){navigateToFilteredQuotesPage('Dad');},child: buildCategory(height, width, 'assets/image/HomePageCategorise/Family/dad.jpg', 'Dad')),
                      ],
                    ),
                    Column(
                      children: [
                        GestureDetector(onTap: (){navigateToFilteredQuotesPage('Mom');},child: buildCategory(height, width, 'assets/image/HomePageCategorise/Family/mom.jpg', 'Mom')),
                        const SizedBox(height: 10),
                        GestureDetector(onTap: (){navigateToFilteredQuotesPage('Parenting');},child: buildCategory(height, width, 'assets/image/HomePageCategorise/Family/parenting.jpg', 'Parenting')),
                      ],
                    ),
                    Column(
                      children: [
                        buildCategory(height, width, 'assets/image/HomePageCategorise/Family/home.jpg', 'Home'),
                        const SizedBox(height: 12),
                        buildCategory(height, width, 'assets/image/HomePageCategorise/Family/brotherhood.jpeg', 'Brotherhood'),
                      ],
                    ),
                  ],
                ),
              ),
              // todo  ----------------------- Motivation
              SizedBox(height: height * 0.036),
              heading('Motivational', width),
              SizedBox(height: height * 0.015),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Column(
                      children: [
                        buildCategory(height, width, 'assets/image/HomePageCategorise/Motivation/inspiration.jpg', 'Inspiration'),
                        const SizedBox(height: 10),
                        buildCategory(height, width, 'assets/image/HomePageCategorise/Motivation/knowledge.jpg', 'Knowledge'),
                      ],
                    ),
                    Column(
                      children: [
                        buildCategory(
                            height,
                            width,
                            'assets/image/HomePageCategorise/Motivation/freedom.jpg',
                            'Freedom'),
                        const SizedBox(height: 10),
                        buildCategory(
                            height,
                            width,
                            'assets/image/HomePageCategorise/Motivation/intelligence.jpg',
                            'Intelligence'),
                      ],
                    ),
                    Column(
                      children: [
                        buildCategory(
                            height,
                            width,
                            'assets/image/HomePageCategorise/Motivation/courage.jpg',
                            'Courage'),
                        const SizedBox(height: 12),
                        buildCategory(
                            height,
                            width,
                            'assets/image/HomePageCategorise/Motivation/motivation.jpg',
                            'Motivation'),
                      ],
                    ),
                  ],
                ),
              ),
              // todo  ----------------------- Other
              SizedBox(height: height * 0.036),
              heading('Other', width),
              SizedBox(height: height * 0.015),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Column(
                      children: [
                        buildCategory(
                            height,
                            width,
                            'assets/image/HomePageCategorise/Other/god.jpg',
                            'God'),
                        const SizedBox(height: 10),
                        buildCategory(
                            height,
                            width,
                            'assets/image/HomePageCategorise/Other/age.jpg',
                            'Age'),
                      ],
                    ),
                    Column(
                      children: [
                        buildCategory(
                            height,
                            width,
                            'assets/image/HomePageCategorise/Other/env.jpg',
                            'Environment'),
                        const SizedBox(height: 10),
                        buildCategory(
                            height,
                            width,
                            'assets/image/HomePageCategorise/Other/dreams.jpg',
                            'Dreams'),
                      ],
                    ),
                    Column(
                      children: [
                        buildCategory(
                            height,
                            width,
                            'assets/image/HomePageCategorise/Other/communication.jpg',
                            'Communication'),
                        const SizedBox(height: 12),
                        buildCategory(
                            height,
                            width,
                            'assets/image/HomePageCategorise/Other/change.jpg',
                            'Change'),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  void navigateToFilteredQuotesPage(String category) {
    Get.to(
      QuotesPage(category: category,),
      transition: Transition.rightToLeft,
      duration: const Duration(milliseconds: 400),
    );
  }
}
