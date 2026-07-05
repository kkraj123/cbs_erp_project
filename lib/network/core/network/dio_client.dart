
import 'package:cbs_erp_project/network/support/share_preference.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../errors/app_exception.dart';
import 'api_constants.dart';


final dioClientProvider = Provider<DioClient>((ref) {
  return DioClient();
});

class DioClient {
  DioClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: SharedPreferenceManager.baseUrl,
        connectTimeout: ApiConstants.connectTimeout,
        receiveTimeout: ApiConstants.receiveTimeout,
        sendTimeout: ApiConstants.sendTimeout,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    _dio.interceptors.addAll([
      _BaseUrlInterceptor(),
      _AuthInterceptor(),
      _RetryInterceptor(dio: _dio),
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
      ),
    ]);
  }

  late final Dio _dio;

  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      return await _dio.get<T>(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
    } on DioException catch (e) {
      throw _mapDioException(e);
    }
  }

  Future<Response<T>> post<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      return await _dio.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
    } on DioException catch (e) {
      throw _mapDioException(e);
    }
  }

  Future<Response<T>> put<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      return await _dio.put<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
    } on DioException catch (e) {
      throw _mapDioException(e);
    }
  }

  Future<Response<T>> patch<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      return await _dio.patch<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
    } on DioException catch (e) {
      throw _mapDioException(e);
    }
  }

  Future<Response<T>> delete<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      return await _dio.delete<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
    } on DioException catch (e) {
      throw _mapDioException(e);
    }
  }

  AppException _mapDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return TimeoutException(
          message: 'Request timed out. Please try again.',
        );

      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        final serverMessage =
            (e.response?.data as Map<String, dynamic>?)?['message']
                as String? ??
            'Something went wrong on the server.';
        return ServerException(message: serverMessage, statusCode: statusCode);

      case DioExceptionType.cancel:
        return UnknownException(message: 'Request was cancelled.');

      case DioExceptionType.connectionError:
        return NetworkException(
          message:
              'No internet connection. Please check your network settings.',
        );

      default:
        return UnknownException(
          message: e.message ?? 'An unexpected error occurred.',
        );
    }
  }
}

class _BaseUrlInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options,
      RequestInterceptorHandler handler,
      ) async {
    final savedUrl = await SharedPreferenceManager.getBaseUrl();
    if (savedUrl.isNotEmpty) {
      options.baseUrl = savedUrl;
    }
    handler.next(options);
  }
}

class _AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // TODO: Read token from secure storage and attach
    // final token = SecureStorage.getToken();
    // if (token != null) options.headers['Authorization'] = 'Bearer $token';
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
    }
    handler.next(err);
  }
}

class _RetryInterceptor extends Interceptor {
  _RetryInterceptor({required this.dio, this.maxRetries = 1});

  final Dio dio;
  final int maxRetries;

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final extra = err.requestOptions.extra;
    final retryCount = (extra['retryCount'] as int?) ?? 0;

    final isRetryable =
        err.type == DioExceptionType.connectionError ||
        err.type == DioExceptionType.connectionTimeout;

    if (isRetryable && retryCount < maxRetries) {
      err.requestOptions.extra['retryCount'] = retryCount + 1;
      await Future<void>.delayed(Duration(seconds: retryCount + 1));
      try {
        final response = await dio.fetch(err.requestOptions);
        return handler.resolve(response);
      } catch (e) {
        // fall through to handler.next
      }
    }

    handler.next(err);
  }
}
