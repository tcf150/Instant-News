import 'package:flutter/material.dart';
import 'package:instant_news/NewsBloc.dart';
import 'package:instant_news/model/Article.dart';
import 'package:instant_news/view/ArticleListView.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Instant News',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Instant News'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    newsBloc.getTrending();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Article>>(
      stream: newsBloc.subject.stream,
      builder: (context, AsyncSnapshot<List<Article>> snapshot) {
        return Scaffold(
            appBar: AppBar(
              title: Text(widget.title),
            ),
            body: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Card(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
                    child: TextField(
                      onChanged: (text) {
                        newsBloc.onSearchTextChanged(text);
                      },
                      decoration: InputDecoration(
                          border: InputBorder.none, hintText: 'Search'),
                    ),
                  ),
                ),
                Flexible(
                  child: ArticleListView(articles: snapshot.data),
                  flex: 1,
                )
              ],
            ));
      },
    );
  }
}
