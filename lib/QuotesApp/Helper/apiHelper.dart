import 'dart:convert';

import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class QuotesApi{
  static QuotesApi quotesApi = QuotesApi._();
  QuotesApi._();

  Future fetchData() async {
    Uri url = Uri.parse('https://sheetdb.io/api/v1/7zk7a4do030g9');

    Response response = await http.get(url);

    if(response.statusCode == 200){
      final jsonData = response.body;
      final data = jsonDecode(jsonData);
      return data;
    }
    else{
      return [];
    }
  }
}