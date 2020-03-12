import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';

class BaseDio {
  Dio dio;

  BaseDio._privateConstructor() {
    dio = Dio();
    dio.options = BaseOptions(
//      baseUrl: "https://192.168.1.14:8765/", // IP address of go server
      baseUrl: "https://newsapi.org/v2/",
      connectTimeout: 5000,
      receiveTimeout: 3000,
    );
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (HttpClient client) {
      client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    };
//    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate  = (client) {
//      SecurityContext sc = new SecurityContext();
//      //file is the path of certificate
//      sc.setTrustedCertificates("lib/cert.pem");
//      HttpClient httpClient = new HttpClient(context: sc);
//      return httpClient;
//    };
  }

  static final BaseDio instance = BaseDio._privateConstructor();

  factory BaseDio() {
    return instance;
  }
}