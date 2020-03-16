import 'package:fit_kit/fit_kit.dart';
import 'package:instant_news/NewsRepository.dart';
import 'package:instant_news/model/Article.dart';
import 'package:instant_news/model/NewsResponse.dart';
import 'package:instant_news/model/SearchRequest.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:ui' as ui;

class NewsBloc {
  final NewsRepository repository = NewsRepository();
  final BehaviorSubject<List<Article>> _subject = BehaviorSubject<List<Article>>();

  Future<void> getEverything(SearchRequest request) async {
    NewsResponse response = await repository.getEverything(request);
    _subject.sink.add(response.articles);
  }

  Future<void> getTrending(String countryCode) async {
    NewsResponse response = await repository.getTrending(countryCode);
    _subject.sink.add(response.articles);
  }

  Future<void> postHealthData(List<FitData> data) async {
    repository.postHealthData(data);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<List<Article>> get subject => _subject;
}

final newsBloc = NewsBloc();