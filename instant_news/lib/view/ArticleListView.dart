import 'package:flutter/material.dart';
import 'package:instant_news/model/Article.dart';
import 'package:instant_news/view/ArticleCardView.dart';

class ArticleListView extends StatefulWidget {
  ArticleListView({Key key, this.articles}): super(key: key);

  final List<Article> articles;

  @override
  ArticleListViewState createState() => ArticleListViewState();
}

class ArticleListViewState extends State<ArticleListView> {

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.articles != null ? widget.articles.length : 0,
        itemBuilder: (context, index) {
          return ArticleCardView(article: widget.articles[index]);
        });
  }

}