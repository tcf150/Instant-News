import 'package:dio/dio.dart';
import 'package:instant_news/api/BaseDio.dart';
import 'package:instant_news/model/NewsResponse.dart';

class NewsApi {

  Future<NewsResponse> getEverything(String query) async {
    final Map<String, String> param = {
      'q': query,
      'apiKey': BaseDio().apiKey,
    };
    Response response = await BaseDio().dio.get("everything", queryParameters: param);
    return NewsResponse.fromJson(response.data);
  }
}