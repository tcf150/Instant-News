import 'package:instant_news/model/Article.dart';

class NewsResponse {
  final String status;
  final int totalResults;
  final List<Article> articles;

  NewsResponse(this.status, this.totalResults, this.articles);

  NewsResponse.fromJson(Map<String, dynamic> json)
      : status = json["status"],
        totalResults = json["totalResults"],
        articles = (json["articles"] as List).map((i) => new Article.fromJson(i)).toList();
}