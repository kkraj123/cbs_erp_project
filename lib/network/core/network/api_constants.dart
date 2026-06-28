// lib/core/network/api_constants.dart

class ApiConstants {
  ApiConstants._();

  static const String baseUrl = 'https://jsonplaceholder.typicode.com';
  static const Duration connectTimeout = Duration(seconds: 15);
  static const Duration receiveTimeout = Duration(seconds: 15);
  static const Duration sendTimeout = Duration(seconds: 15);

  // Endpoints
  static const String posts = '/posts';
  static const String users = '/users';
  static const String comments = '/comments';

  static String postById(int id) => '/posts/$id';
  static String commentsByPost(int postId) => '/posts/$postId/comments';
}
