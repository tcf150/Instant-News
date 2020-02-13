import 'package:instant_news/api/NewsApi.dart';

import 'model/NewsResponse.dart';

class NewsRepository {
  NewsApi api = NewsApi();

  Future<NewsResponse>getEverything(String query) {
    return api.getEverything(query);
  }

}