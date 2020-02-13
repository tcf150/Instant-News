import 'package:flutter/material.dart';
import 'package:instant_news/model/Article.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticleCardView extends StatefulWidget {
  ArticleCardView({Key key, this.article}) : super(key: key);

  final Article article;

  @override
  ArticleCardViewState createState() => ArticleCardViewState();
}

class ArticleCardViewState extends State<ArticleCardView> {

  @override
  Widget build(BuildContext context) {

    return Card(
        child: new InkWell(
          onTap: () {
            launchUrl(widget.article.url);
          },
          child: Wrap(
            children: <Widget>[
              Image(image: NetworkImage(widget.article.urlToImage)),
              Padding(
                padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
                child: Text(
                    widget.article.title,
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold
                    )
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 2, left: 8, right: 8),
                child: Text(widget.article.description),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4, left: 8, right: 8),
                child: Text(DateFormat('yyyy-MM-ddTHH:mm:ssZ','en-US').parse(widget.article.publishedAt).toString()),
              ),
              Align(
                alignment: Alignment.centerRight,
                child:  Padding(
                  padding: const EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 8),
                  child: Text(
                      'Source: ${widget.article.source.name}',
                      style: TextStyle(
                        fontSize: 12.0,
                          fontWeight: FontWeight.bold
                      )
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }

  launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: false);
    } else {
      throw 'Could not launch $url';
    }
  }
}