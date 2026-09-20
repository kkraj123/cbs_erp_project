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
  static String categoryDropdownItemEnd = '/api/erpapi/GetItemCategoriesByIsLogical';
  static String saveItemEndPoint = '/api/ErpApi/SaveItem';
  static String unitEndPoint = '/api/ErpApi/GetUnits';

  static String unitMeasureEndpoint = '/api/ErpApi/GetUnits';
  static String saveUnitMeasureEndPoint = '/api/ErpApi/SaveUnit';

  static String categoryItemsTypeEndPoint = "/api/ErpApi/GetItemTypes";
  static String categorySaveItemEndPoint = "/api/ErpApi/SaveItemCategory";
  static String categoryByIsLogicEndPoint = "/api/ErpApi/GetItemCategoriesByIsLogical";



}
