
sealed class ApiResponse<T> {
  const ApiResponse();
}

final class ApiSuccess<T> extends ApiResponse<T> {
  const ApiSuccess(this.data);
  final T data;
}

final class ApiError<T> extends ApiResponse<T> {
  const ApiError(this.message, {this.statusCode});
  final String message;
  final int? statusCode;
}

extension ApiResponseX<T> on ApiResponse<T> {
  bool get isSuccess => this is ApiSuccess<T>;
  bool get isError => this is ApiError<T>;

  T get dataOrThrow => switch (this) {
    ApiSuccess(:final data) => data,
    ApiError(:final message) => throw Exception(message),
  };

  R when<R>({
    required R Function(T data) success,
    required R Function(String message, int? statusCode) error,
  }) =>
      switch (this) {
        ApiSuccess(:final data) => success(data),
        ApiError(:final message, :final statusCode) =>
          error(message, statusCode),
      };
}
