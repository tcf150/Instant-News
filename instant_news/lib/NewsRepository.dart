import 'package:fit_kit/fit_kit.dart';
import 'package:instant_news/api/NewsApi.dart';
import 'package:instant_news/model/SearchRequest.dart';

import 'model/NewsResponse.dart';

class NewsRepository {
  NewsApi api = NewsApi();

  Future<NewsResponse> getEverything(SearchRequest request) {
    Map<String, String> params = Map();
    if (request.keyword.isNotEmpty) params.putIfAbsent("q", () => request.keyword);
    if (request.sortBy.isNotEmpty) params.putIfAbsent("sortBy", () => request.sortBy);
    if (request.from.isNotEmpty) params.putIfAbsent("from", () => request.from);
    params.putIfAbsent("language", () => request.language);
    return api.getEverything(params);
  }

  Future<NewsResponse> getTrending(String country) {
    return api.getTrending(country);
  }

  Future<void> postHealthData(List<FitData> data, String token) {
    api.postHealthData(data, token);
  }

}