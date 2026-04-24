import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:rick_morty/base/networking/dio_http_client.dart';
import 'package:rick_morty/base/networking/http_client.dart';

@module
abstract class NetworkModule {
  @lazySingleton
  Dio dio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: 'https://rickandmortyapi.com/api',
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {'Accept': 'application/json'},
      ),
    );

    dio.interceptors.add(LogInterceptor(requestBody: false, responseBody: false, error: true));

    return dio;
  }

  @lazySingleton
  HttpClient httpClient(Dio dio) => DioHttpClient(dio);
}
