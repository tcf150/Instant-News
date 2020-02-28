import 'package:dio/dio.dart';

class BaseDio {
  String apiKey = "6c5c888290f647818122022f271a88f0";
  Dio dio;

  BaseDio._privateConstructor() {
    BaseOptions options = new BaseOptions(
      baseUrl: "https://newsapi.org/v2/",
      connectTimeout: 5000,
      receiveTimeout: 3000,
    );
    dio = Dio(options);
  }

  static final BaseDio instance = BaseDio._privateConstructor();

  factory BaseDio() {
    return instance;
  }
}