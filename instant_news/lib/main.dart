import 'package:flutter/material.dart';
import 'package:instant_news/NewsBloc.dart';
import 'package:instant_news/firebase_notification_handler.dart';
import 'package:instant_news/health.dart';
import 'package:instant_news/model/Article.dart';
import 'package:instant_news/model/SearchRequest.dart';
import 'package:instant_news/pushnotification/pushexample.dart';
import 'package:instant_news/search.dart';
import 'package:instant_news/view/ArticleListView.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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

    FirebaseNotifications().setUpFirebase(context);
    newsBloc.getTrending();
  }

  _navigateToSearch(BuildContext context) async {
    final result = await Navigator.push(context, MaterialPageRoute(builder: (context) => SearchPage()));
    final SearchRequest request = result as SearchRequest;
    newsBloc.getEverything(request);
  }

  _navigateToHealth(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => HealthPage()));
  }

  _navigateToPushExample(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => PushExample()));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Article>>(
      stream: newsBloc.subject.stream,
      builder: (context, AsyncSnapshot<List<Article>> snapshot) {
        return Scaffold(
            appBar: AppBar(
              title: Text(widget.title),
              actions: <Widget>[
                IconButton(
                  onPressed: () {
                    _navigateToSearch(context);
                  },
                  icon: Icon(
                    Icons.search,
                    color: Colors.white,
                  )
                ),
                IconButton(
                    onPressed: () {
                      _navigateToHealth(context);
                    },
                    icon: Icon(
                      Icons.accessible_forward,
                      color: Colors.white,
                    )
                ),
//                IconButton(
//                    onPressed: () {
//                      _navigateToPushExample(context);
//                    },
//                    icon: Icon(
//                      Icons.notifications_active,
//                      color: Colors.white,
//                    )
//                )
              ],
            ),
            body: Container(
              child: Center(
                child: RefreshIndicator(
                  child: ArticleListView(articles: snapshot.data),
                  onRefresh: () => newsBloc.getTrending(),)
            ))
        );
      },
    );
  }
}
