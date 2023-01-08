import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../models/article_model.dart';
import 'package:http/http.dart' as http;

class News {
  List<ArticleModel> news = [];

  Future<void> getNews() async {
    String url =
        "https://newsapi.org/v2/top-headlines?country=in&apiKey=0be6096aa54449e88da2f202525da8bd";

    var response = await http.get(Uri.parse(url));

    var jsonData = jsonDecode(response.body);
    if (jsonData['status'] == "ok") {
      jsonData['articles'].forEach((element) {
        if (element["urlToImage"] != null && element['description'] != null) {
          ArticleModel articleModel = ArticleModel(
              title: element['title'],
              author: element["author"] ?? "",
              description: element["description"],
              url: element["url"],
              urlToImage: element["urlToImage"],
              content: element["content"] ?? "");
          news.add(articleModel);
        }
      });
    }
  }
}

class CategoryNewsClass {
  List<ArticleModel> news = [];

  Future<void> getNews(String category) async {
    String url =
        "https://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=01812358e7d94bd3b6477fe1091fda03";
    String text = "hello world";
    final googleapi = Uri.parse(
        'https://translation.googleapis.com/language/translate/v2/?q=$text&target=am&source=en');
    var response = await http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body);
    if (jsonData['status'] == "ok") {
      var translated = await http.post(googleapi, headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept-Encoding': 'application/gzip',
        'X-RapidAPI-Key': '62d52976femsh5256c41480449dep17e3cfjsnf1dc2f6dec7d',
        'X-RapidAPI-Host': 'google-translate1.p.rapidapi.com'
      });
      if (kDebugMode) {
        if (translated.statusCode == 200) {
          final body = jsonDecode(response.body);
          final translations = body['data']['translations'] as List;
          final translation = translations.first;
          print(translation);
        }
      }
      jsonData['articles'].forEach((element) {
        if (element["urlToImage"] != null && element['description'] != null) {
          ArticleModel articleModel = ArticleModel(
              title: element['title'],
              author: element["author"] ?? "",
              description: element["description"],
              url: element["url"],
              urlToImage: element["urlToImage"],
              content: element["content"] ?? "");

          news.add(articleModel);
        }
      });
    }
  }
}
