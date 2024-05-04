import 'dart:developer';
import 'package:number_trivia_app/core/app/shared_prefs.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class BaseRepository {
  BaseRepository._();

  static final _instance = BaseRepository._();
  static const baseUrl = "http://numbersapi.com";
  static BaseRepository get instance => _instance;

  initialize() {
    if (SharedPrefs.instance.token != null) {
      _dio = Dio(BaseOptions(baseUrl: baseUrl, headers: {
        "Content-Type": "application/json",
        // 'Authorization': "Bearer ${GetIt.I<SharedPrefs>().instance.token}"
      }));
    } else {
      _dio = Dio(BaseOptions(baseUrl: baseUrl, headers: {
        "Content-Type": "application/json",
      }));
    }
    _dio.interceptors.add(
        PrettyDioLogger(request: true, requestBody: true, requestHeader: true));
  }

  Dio get dio => _dio;
  late final Dio _dio;

  addToken(String token) {
    _dio.options =
        _dio.options.copyWith(headers: {'Authorization': "Bearer $token"});

    log("Authorization token =======> $token");
  }
}
