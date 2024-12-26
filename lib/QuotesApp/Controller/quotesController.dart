import 'package:db_minar/QuotesApp/Helper/dbHelper.dart';
import 'package:db_minar/QuotesApp/Model/quotesModel.dart';
import 'package:get/get.dart';
import '../Helper/apiHelper.dart';

class QuotesController extends GetxController {
  RxList<QuotesModel> dataList = <QuotesModel>[].obs,
      allQuotes = <QuotesModel>[].obs,
      likedQuotes = <QuotesModel>[].obs;
  RxInt currentQuoteIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    getLikedQuotes();
  }

  List category = [
    {
      "category": "Love",
      "image": 'assets/image/HomePageCategorise/Popular/love.jpg',
      "bgImg": 'assets/image/WallpaperImages/47.jpg',
    },
    {
      "category": "Life",
      "image": 'assets/image/HomePageCategorise/Popular/life.jpg',
      "bgImg": 'assets/image/WallpaperImages/49.jpg',
    },
    {
      "category": "Work",
      "image": 'assets/image/HomePageCategorise/Popular/work.jpg',
      "bgImg": 'assets/image/WallpaperImages/50.jpeg',
    },
    {
      "category": "Motivation",
      "image": 'assets/image/HomePageCategorise/Popular/motivation.jpg',
      "bgImg": 'assets/image/WallpaperImages/48.jpg',
    },
    {
      "category": "Family",
      "image":  'assets/image/HomePageCategorise/Family/family.jpg',
      "bgImg": 'assets/image/WallpaperImages/53.jpeg',//30
    },
    {
      "category": "Mom",
      "image": 'assets/image/HomePageCategorise/Family/mom.jpg',
      "bgImg": 'assets/image/WallpaperImages/51.jpg',
    },
    {
      "category": "Dad",
      "image": 'assets/image/HomePageCategorise/Family/dad.jpg',
      "bgImg": 'assets/image/WallpaperImages/52.jpeg',
    },
    {
      "category": "Parenting",
      "image": 'assets/image/HomePageCategorise/Family/parenting.jpg',
      "bgImg": 'assets/image/WallpaperImages/43.jpg',
    },
  ];

  Future<List<QuotesModel>> fetchApiData() async {
    final data = await QuotesApi.quotesApi.fetchData();
    dataList.value = (data as List).map((e) => QuotesModel.fromJson(e)).toList();
    allQuotes.value = (data as List).map((e) => QuotesModel.fromJson(e)).toList();;
    return dataList;
  }

  void changeQuoteIndex(int index) {
    currentQuoteIndex.value = index;
  }

  Future<void> toggleLike(QuotesModel quote, int index) async {
    print(dataList[index].isLiked);

    if (dataList[index].isLiked == "1") {
      dataList[index].isLiked = "0";
    } else {
      dataList[index].isLiked = "1";
    }

    if (likedQuotes.any((liked) => liked.quote == quote.quote)){
      likedQuotes.removeWhere((liked) => liked.quote == quote.quote);
      await DbHelper.dbHelper.deleteLikedQuotes(quote.quote);
    }
    else{
      likedQuotes.add(quote);
      await DbHelper.dbHelper.insertLikedQuote(quote);
    }

    print(dataList[index].isLiked);
    update();
    dataList.refresh();
  }

  void fetchQuotesByCategory(String category) {
    List<QuotesModel> filteredQuotes =
        allQuotes.where((quote) => quote.category == category).toList();
    dataList(filteredQuotes);
  }

  Future<void> getLikedQuotes() async {
    List<QuotesModel> likedQuotesFromDb = await DbHelper.dbHelper.getLikedQuotes();
    likedQuotes.value = likedQuotesFromDb;
  }

  Map<String, List<QuotesModel>> get categoriesOfLikedQuotes{
    var groupedQuotes = <String, List<QuotesModel>>{};
    for(var quote in likedQuotes){
      if(groupedQuotes.containsKey(quote.category)){
        groupedQuotes[quote.category]!.add(quote);
      }
      else{
        groupedQuotes[quote.category] = [quote];
      }
    }
    return groupedQuotes;
  }

  void updateLikeBtn(QuotesModel quote,index){
    print(allQuotes.length);
    for(int i=0; i<allQuotes.length; i++){
      if(quote.quote == allQuotes[i].quote){
        allQuotes[i].isLiked = '0';
      }
    }
    dataList.refresh();
  }
}