import 'package:instant_news/NewsRepository.dart';
import 'package:instant_news/model/Article.dart';
import 'package:instant_news/model/NewsResponse.dart';
import 'package:rxdart/rxdart.dart';

class NewsBloc {
  final NewsRepository repository = NewsRepository();
  final BehaviorSubject<List<Article>> _subject = BehaviorSubject<List<Article>>();
  final BehaviorSubject<String> _searchSubject = BehaviorSubject<String>();
  final String countryCode = "SG";

  NewsBloc() {
    _searchSubject.stream.debounceTime(Duration(milliseconds: 500))
        .listen((event) {
          _subject.sink.add(List());
          if(event.isEmpty) {
            getTrending();
          } else {
            getEverything(event);
          }
    });
  }

  getEverything(String query) async {
    NewsResponse response = await repository.getEverything(query);
    _subject.sink.add(response.articles);
  }

  getTrending() async {
    NewsResponse response = await repository.getTrending(countryCode);
    _subject.sink.add(response.articles);
  }

  onSearchTextChanged(String query) {
    _searchSubject.sink.add(query);
  }

  dispose() {
    _subject.close();
    _searchSubject.close();
  }


  BehaviorSubject<List<Article>> get subject => _subject;
}

final newsBloc = NewsBloc();