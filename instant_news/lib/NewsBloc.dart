import 'package:instant_news/NewsRepository.dart';
import 'package:instant_news/model/Article.dart';
import 'package:instant_news/model/NewsResponse.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:ui' as ui;

class NewsBloc {
  final NewsRepository repository = NewsRepository();
  final BehaviorSubject<List<Article>> _subject = BehaviorSubject<List<Article>>();
  final BehaviorSubject<String> _searchSubject = BehaviorSubject<String>();
  final String countryCode = ui.window.locale.countryCode;

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

  Future<void> getEverything(String query) async {
    NewsResponse response = await repository.getEverything(query);
    _subject.sink.add(response.articles);
  }

  Future<void> getTrending() async {
    NewsResponse response = await repository.getTrending(countryCode);
    _subject.sink.add(response.articles);
  }

  Future<void> onSearchTextChanged(String query) {
    _searchSubject.sink.add(query);
  }

  dispose() {
    _subject.close();
    _searchSubject.close();
  }


  BehaviorSubject<List<Article>> get subject => _subject;
}

final newsBloc = NewsBloc();