import 'package:flutter/material.dart';

class QuotesModel {
  late String quote,author,category,isLiked;

  QuotesModel({
    required this.quote,
    required this.author,
    required this.category,
    required this.isLiked,
  });

  factory QuotesModel.fromJson(Map m1){
    return QuotesModel(
      quote: m1['quote'] ?? 'hello',
      author: (m1['author'] == 'Unknown') ? 'C.S. Lewis' : m1['author'],
      category: m1['category'] ?? 'hello',
      isLiked: m1['isLiked'] ?? 'hello',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'category': category,
      'quote': quote,
      'author': author,
      'isLiked': isLiked,
    };
  }

}