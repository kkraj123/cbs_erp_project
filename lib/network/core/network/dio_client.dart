
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../errors/app_exception.dart';
import 'api_constants.dart';

/// ---------------------------------------------------------------------------
/// Dio instance provider
/// ---------------------------------------------------------------------------
final dioClientProvider = Provider<DioClient>((ref) {
  return DioClient();
});

/// ---------------------------------------------------------------------------
/// DioClient — wraps Dio with interceptors and unified error mapping
/// ---------------------------------------------------------------------------
class DioClient {
  DioClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
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

  // ── GET ──────────────────────────────────────────────────────────────────
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

  // ── POST ─────────────────────────────────────────────────────────────────
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

  // ── PUT ──────────────────────────────────────────────────────────────────
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

  // ── PATCH ────────────────────────────────────────────────────────────────
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

  // ── DELETE ───────────────────────────────────────────────────────────────
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

  // ── Error Mapper ─────────────────────────────────────────────────────────
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

/// ---------------------------------------------------------------------------
/// Auth Interceptor — attach tokens, refresh on 401
/// ---------------------------------------------------------------------------
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
      // TODO: Refresh token logic here
      // try {
      //   final newToken = await AuthService.refreshToken();
      //   err.requestOptions.headers['Authorization'] = 'Bearer $newToken';
      //   final cloned = await Dio().fetch(err.requestOptions);
      //   return handler.resolve(cloned);
      // } catch (_) { /* logout */ }
    }
    handler.next(err);
  }
}

/// ---------------------------------------------------------------------------
/// Retry Interceptor — retry transient failures up to [maxRetries] times
/// ---------------------------------------------------------------------------
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
