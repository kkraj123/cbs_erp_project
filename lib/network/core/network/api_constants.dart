// lib/core/network/api_constants.dart

class ApiConstants {
  ApiConstants._();

  static const String baseUrl = '';
  static const Duration connectTimeout = Duration(seconds: 15);
  static const Duration receiveTimeout = Duration(seconds: 15);
  static const Duration sendTimeout = Duration(seconds: 15);

  // Endpoints
  static String loginEndPoint  = '/v1/MobileAppApi/Login';
  static String optVerifyingEndPoint = '/v1/MobileAppApi/VerifyOTP';
  static String getAllItemsEnd = '/api/ErpApi/GetAllItems';
  static String unitMeasureEndpoint = '/api/ErpApi/GetUnits';


}
