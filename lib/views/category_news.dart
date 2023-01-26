import 'package:flutter/material.dart';

import '../helper/news.dart';
import '../models/article_model.dart';
import 'article_view.dart';
import 'package:readmore/readmore.dart';

class CategoryView extends StatefulWidget {
  final String category;

  CategoryView({Key? key, required this.category}) : super(key: key);

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  List<ArticleModel> articles = [];
  bool _loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategoryNews();
  }

  getCategoryNews() async {
    CategoryNewsClass newsClass = CategoryNewsClass();
    await newsClass.getNews(widget.category);
    articles = newsClass.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.category.isNotEmpty ? widget.category : "categories",
              style: TextStyle(color: Colors.black),
            ),
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
      body: _loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    /// Blogs
                    Container(
                      padding: const EdgeInsets.only(top: 16),
                      child: ListView.builder(
                          itemCount: articles.length,
                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return BlogTile(
                              A: articles[index],
                            );
                          }),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}

class BlogTile extends StatelessWidget {
  ArticleModel A;
  BlogTile({Key? key, required this.A}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ArticleView(
                            blogUrl: A.url,
                          )));
            },
            child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.network(A.urlToImage)),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            A.title,
            style: const TextStyle(
                fontSize: 18.5,
                color: Colors.black87,
                fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 6,
          ),
          const ReadMoreText(
            'Flutter is Google’s mobile UI open source framework to build high-quality native (super fast) interfaces for iOS and Android apps with the unified codebase. ',
            trimLines: 2,
            colorClickableText: Colors.blue,
            trimMode: TrimMode.Line,
            trimCollapsedText: 'ReadMore',
            trimExpandedText: 'Show less',
            moreStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
