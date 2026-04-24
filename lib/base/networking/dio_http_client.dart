import 'dart:io';
import 'package:dio/dio.dart';
import 'package:rick_morty/base/networking/http_client.dart';
import 'package:rick_morty/base/networking/network_exceptions.dart';

class DioHttpClient implements HttpClient {
  const DioHttpClient(this._dio);

  final Dio _dio;

  @override
  Future<Response> get(
    String uri, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    data,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) => _processNetworkCall(
    () => _dio.get(
      uri,
      queryParameters: queryParameters,
      options: options,
      data: data,
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
    ),
  );

  @override
  Future<Response> delete(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) => _processNetworkCall(
    () => _dio.delete(uri, data: data, queryParameters: queryParameters, options: options, cancelToken: cancelToken),
  );

  @override
  Future<Response> post(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) => _processNetworkCall(
    () => _dio.post(
      uri,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
      onSendProgress: onSendProgress,
    ),
  );

  @override
  Future<Response> put(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) => _processNetworkCall(
    () => _dio.put(
      uri,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
      onSendProgress: onSendProgress,
    ),
  );

  @override
  Future<Response> patch(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) => _processNetworkCall(
    () => _dio.patch(
      uri,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
      onSendProgress: onSendProgress,
    ),
  );

  Future<Response> _processNetworkCall(Future<Response> Function() call) async {
    try {
      return await call();
    } on SocketException {
      throw NoInternetException();
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Exception _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        throw TimeoutException();
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        final data = error.response?.data;
        throw WrongDataException(
          statusCode: statusCode ?? 0,
          cause: data?.toString() ?? 'Unknown error',
          callId: error.requestOptions.path,
          sourceClass: 'DioHttpClient',
        );
      case DioExceptionType.cancel:
        throw CancelledException();
      default:
        throw ServerNotWorkingException(callId: error.requestOptions.path);
    }
  }
}
