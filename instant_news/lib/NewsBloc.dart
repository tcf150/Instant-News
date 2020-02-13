import 'package:instant_news/NewsRepository.dart';
import 'package:instant_news/model/Article.dart';
import 'package:instant_news/model/NewsResponse.dart';
import 'package:rxdart/rxdart.dart';

class NewsBloc {
  final NewsRepository repository = NewsRepository();
  final BehaviorSubject<List<Article>> _subject = BehaviorSubject<List<Article>>();

  getEverything(String query) async {
    NewsResponse response = await repository.getEverything(query);
    _subject.sink.add(response.articles);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<List<Article>> get subject => _subject;
}

final newsBloc = NewsBloc();