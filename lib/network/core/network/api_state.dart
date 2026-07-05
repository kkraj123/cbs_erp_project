// lib/core/state/api_state.dart

class ApiState<T> {
  final bool isLoading;
  final T? data;
  final String? errorMessage;

  const ApiState({
    this.isLoading = false,
    this.data,
    this.errorMessage,
  });

  // starting point — nothing has happened yet
  factory ApiState.initial() => const ApiState();

  // while calling the API
  factory ApiState.loading() => const ApiState(isLoading: true);

  // API succeeded
  factory ApiState.success(T data) => ApiState(data: data);

  // API failed
  factory ApiState.error(String message) => ApiState(errorMessage: message);
}