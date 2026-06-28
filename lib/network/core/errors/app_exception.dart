// lib/core/errors/app_exception.dart

sealed class AppException implements Exception {
  const AppException({required this.message, this.statusCode});

  final String message;
  final int? statusCode;

  @override
  String toString() => message;
}

class ServerException extends AppException {
  const ServerException({required super.message, super.statusCode});
}

class NetworkException extends AppException {
  const NetworkException({required super.message});
}

class TimeoutException extends AppException {
  const TimeoutException({required super.message});
}

class ParseException extends AppException {
  const ParseException({required super.message});
}

class UnknownException extends AppException {
  const UnknownException({required super.message});
}
