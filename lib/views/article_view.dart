import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../helper/news.dart';
import '../models/article_model.dart';

class ArticleView extends StatefulWidget {
  ArticleModel articles;
  ArticleView({Key? key, required this.articles}) : super(key: key);

  @override
  State<ArticleView> createState() => _ArticleViewState();
}

class _ArticleViewState extends State<ArticleView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              "News",
              style: TextStyle(color: Colors.black),
            ),
            Text(
              "App",
              style: TextStyle(color: Colors.blue),
            )
          ],
        ),
        actions: [
          Opacity(
            opacity: 0,
            child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: const Icon(Icons.save)),
          )
        ],
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.network(widget.articles.urlToImage)),
            const SizedBox(
              height: 8,
            ),
            Text(
              widget.articles.title,
              style: const TextStyle(
                  fontSize: 18.5,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 6,
            ),
            Text(
              widget.articles.description,
              style: const TextStyle(color: Colors.black54),
            )
          ],
        ),
      ),
    );
  }
}
