import 'package:dio/dio.dart';
import 'package:fit_kit/fit_kit.dart';
import 'package:instant_news/api/BaseDio.dart';
import 'package:instant_news/model/HealthData.dart';
import 'package:instant_news/model/NewsResponse.dart';

class NewsApi {
  String apiKey = "6c5c888290f647818122022f271a88f0";

  Future<NewsResponse> getEverything(Map<String, String> params) async {
    params.putIfAbsent("apiKey", () => apiKey);
    Response response = await BaseDio().dio.get("everything", queryParameters: params);
    return NewsResponse.fromJson(response.data);
  }

  Future<NewsResponse> getTrending(String country) async {
    final Map<String, String> param = {
      'country': country,
      'apiKey': apiKey,
    };

    Response response = await BaseDio().dio.get("top-headlines", queryParameters: param);
    return NewsResponse.fromJson(response.data);
  }
  
  Future<void> postHealthData(List<FitData> data) async {
    BaseDio().dio.post("uploadHealthData", data: HealthData(data));
  }
}
